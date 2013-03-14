#include <ros/ros.h>
#include <ueye.h>
#include <image_transport/image_transport.h>
#include <cv_bridge/cv_bridge.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/image_encodings.h>
#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <boost/date_time/posix_time/posix_time.hpp>
#include <boost/date_time/local_time_adjustor.hpp>
#include <boost/date_time/c_local_time_adjustor.hpp>

#include <ueyecam/SaveImage.h>

using namespace std;
namespace enc = sensor_msgs::image_encodings;

static const char WINDOW[] = "Image window";

class UEyeCam
{	
public:
  UEyeCam(int hCam = 1) : nh_("~"), it_(nh_)
  {
		hCam_ = hCam;
		//image_pub_ = it_.advertiseCamera("image", 1);
    preview_pub_ = it_.advertise("preview", 1);
		//cv::namedWindow(WINDOW);
		// Initiate camera
		if (is_InitCamera(&hCam_, NULL)) {
			ROS_ERROR("Camera could not be initiated! Is usb connected?");
		}
		// Get sensor info
		else if (is_GetSensorInfo(hCam_, &sens_info_)) {
			ROS_ERROR("Sensor info not acquired");
		}
    //Get camera info
		else if (is_GetCameraInfo(hCam_, &cam_info_)) {
			ROS_ERROR("Camera info not acquired");
		}
		else ROS_INFO("Camera ready: %s %ix%i", sens_info_.strSensorName,
			sens_info_.nMaxWidth, sens_info_.nMaxHeight);
		//Process ROS parameters
		processParams();
		//Initiate memory
		if (is_InitMemory()) {
			ROS_ERROR("Failed to allocate memory");
		}
		else ROS_INFO("Memory allocated and added to sequence: %ix%i", height_, step_);
		initImageMsg();
		is_startLiveMode();
		ros::Time::init();
	}
	
  ~UEyeCam()
  {
    cv::destroyWindow(WINDOW);
		if (is_StopLiveVideo (hCam_, IS_DONT_WAIT)) {
			ROS_ERROR("Camera connection termination failed");
		}
		else if (is_FreeImageMem (hCam_, image_mem_, pid_)) {
			ROS_ERROR("Image memory release failed");
		}
		else if (is_ExitCamera (hCam_)) {
			ROS_ERROR("Camera exit failed");
		}
		else ROS_INFO("Camera connection closed");
  }

  void publish()
  {
		if (is_LockSeqBuf (hCam_, 1, image_mem_)) {
			ROS_ERROR("Lock Sequence Buffer failed");
		}
		else {
			image_msg_.header.stamp = ros::Time::now();
			memcpy((char*)(&image_msg_.data[0]), image_mem_, height_*step_);
			ROS_INFO("Publishing frame %s at %.1f fps", 
				formatTime(image_msg_.header.stamp).c_str(), ui_fps_set_);
		}
		if (is_UnlockSeqBuf (hCam_, 1, image_mem_)) {
			ROS_ERROR("Unlock Sequence Buffer failed");
		}
		//preview_pub_.publish(image_msg_);

    try {
      cv_image_ = cv_bridge::toCvCopy(image_msg_, ros_enc_);
    }
    catch (cv_bridge::Exception& e) {
      ROS_ERROR("cv_bridge exception: %s", e.what());
			return;
    }
		//cvtColor(cv_image_->image, cv_image_->image, CV_BGR2RGB);
		cv::resize(cv_image_->image, cv_preview_->image, cv::Size(pre_width_, pre_height_));
    //cv::imshow(WINDOW, cv_preview_->image);
    //cv::waitKey(3);
    
    preview_pub_.publish(cv_preview_->toImageMsg());
		//preview_pub_.publish(cv_image_->toImageMsg());
		ros::Duration(1.0/ui_fps_set_).sleep();
  }		

	void setAutoParameters()
	{
		double control = 1.0, wb_speed = 10.0;
		is_SetAutoParameter(hCam_, IS_SET_ENABLE_AUTO_GAIN, &control, 0);
		is_SetAutoParameter(hCam_, IS_SET_ENABLE_AUTO_SHUTTER, &control, 0);
		is_SetAutoParameter(hCam_, IS_SET_ENABLE_AUTO_WHITEBALANCE, &control, 0);
		is_SetAutoParameter(hCam_, IS_SET_AUTO_WB_SPEED, &wb_speed, 0);	
	}
	
	bool saveImage(ueyecam::SaveImage::Request &req, ueyecam::SaveImage::Response &res)
	{
		if (!req.filename.compare("auto")) {
			req.filename = boost::str( boost::format("%sTK%s.jpg") 
				% image_path_ % formatTime(image_msg_.header.stamp) );
		}
		ROS_INFO("Saving image %s ...", req.filename.c_str());
		res.success = imwrite(req.filename, cv_image_->image);
		return res.success;
	}

private:
	ros::NodeHandle nh_;
  	image_transport::ImageTransport it_;
	image_transport::CameraPublisher image_pub_;
	image_transport::Publisher preview_pub_;
	sensor_msgs::Image image_msg_;
	sensor_msgs::CameraInfo cam_info_msg_;
	cv_bridge::CvImagePtr cv_image_, cv_preview_;
	HIDS hCam_;
	SENSORINFO sens_info_;
  CAMINFO cam_info_;
	char *image_mem_;
	bool roi_enable_;
	int pid_, height_, width_, roi_x_, roi_y_, step_;
	int pre_width_, pre_height_;
	int ui_enc_, cv_enc_;
	string ros_enc_, frame_id_, image_path_;
	double ui_fps_, ui_fps_set_;
	
	void processParams()
	{
		width_ = sens_info_.nMaxWidth;
		height_ = sens_info_.nMaxHeight;
		nh_.param("roiEnable", roi_enable_, false);
		if (roi_enable_) {
			nh_.param("roiWidth", width_, width_);
			nh_.param("roiHeight", height_, height_);
			nh_.param("xOffset", roi_x_, 0);
			nh_.param("yOffset", roi_y_, 0);
		}
		nh_.param("fps", ui_fps_, 9.0); setFrameRate();
		nh_.param<string>("encoding", ros_enc_, "bgr8"); setEncoding();
		nh_.param<string>("frame_id", frame_id_, "ueyecam");
		nh_.param<string>("image_path", image_path_, "/media/data/");
		pre_width_ = 640;
		pre_height_ = (int)(height_*pre_width_/width_);
		setAutoParameters();
	}
	
	void initImageMsg() 
	{
		image_msg_.header.frame_id = frame_id_;
		image_msg_.height = height_;
		image_msg_.width = width_;
		image_msg_.encoding = ros_enc_;
		image_msg_.is_bigendian = false;
		image_msg_.step = step_;
		image_msg_.data.resize(height_*step_);
		cv_preview_ = cv_bridge::toCvCopy(image_msg_, ros_enc_);
	}
	
	bool is_startLiveMode()
	{
		switch (is_CaptureVideo (hCam_, IS_WAIT)) {
		case IS_SUCCESS:
			ROS_INFO("Live Video capture started");
			return IS_SUCCESS;
		case IS_NO_SUCCESS:
			ROS_INFO("Live Video capture not started");
			break;
		case IS_TRIGGER_ACTIVATED:
			ROS_INFO("Live Video capture not started: Camera is already waiting for trigger!");
			break;
		case IS_GET_LIVE:
			ROS_INFO("Live Capturing is alive");
			break;
		default:
			ROS_INFO("This is one of the messages you should actually never see");
			break;
		}
		return IS_NO_SUCCESS;
	}
	
	bool is_InitMemory()
	{
		bool result = IS_NO_SUCCESS;
		if (is_AllocImageMem(hCam_, width_, height_, enc::bitDepth(ros_enc_)*enc::numChannels(ros_enc_), &image_mem_, &pid_))
			ROS_ERROR("Memory could not be allocated");
		else if (is_SetImageMem (hCam_, image_mem_, pid_)) 
			ROS_ERROR("Memory not available");
		else if (is_AddToSequence (hCam_, image_mem_, pid_)) 
			ROS_ERROR("Memory could not be added to sequence");
		else if (is_GetImageMemPitch(hCam_, &step_))
			ROS_ERROR("Getting image memmory pitch failed");
		else result = IS_SUCCESS;
		return result;
	}
	
	void setFrameRate()
	{
		if (is_SetFrameRate(hCam_, ui_fps_, &ui_fps_set_)) {
			ROS_DEBUG("Frame rate %.2f could not be set", ui_fps_);
		}
	}
	
	void setEncoding()
	{
		if (!ros_enc_.compare("mono8")) {
			cv_enc_ = CV_8U;
			ui_enc_ = IS_CM_MONO8;
		}
		else if (!ros_enc_.compare("mono16")) {
			cv_enc_ = CV_16U;
			ui_enc_ = IS_CM_MONO16;
		}
		else if (!ros_enc_.compare("rgb8")) {
			cv_enc_ = CV_8UC3;
			ui_enc_ = IS_CM_RGB8_PACKED;
		}
		else if (!ros_enc_.compare("bgr8")) {
			cv_enc_ = CV_8UC3;
			ui_enc_ = IS_CM_BGR8_PACKED;
		}
		else 
			throw runtime_error("Color mode %s unrecognized" + ros_enc_);
		if (is_SetColorMode(hCam_, ui_enc_)) {
			throw runtime_error("Encoding %s could not be set" + ros_enc_);
		}
	}
	
	void setEncoding(string enc)
	{
		ros_enc_ = enc;
		setEncoding();
	}
	
	string formatTime(ros::Time rt)
	{
		using namespace boost::posix_time;
		typedef boost::date_time::c_local_adjustor<ptime> local_adj;
		string result = to_iso_string(local_adj::utc_to_local(rt.toBoost()));
		boost::algorithm::replace_all(result, ",", ".");
		return result;
	}
};

int main(int argc, char** argv)
{
  ros::init(argc, argv, "ueyecam");
	ros::NodeHandle nh("~");
	UEyeCam ueyecam;
	ros::ServiceServer ssSaveImage = nh.advertiseService("save_image", &UEyeCam::saveImage, &ueyecam);
	
	//ros::Rate loop_rate(1);
	while (ros::ok()) {
		ueyecam.publish();
  	ros::spinOnce();
		//loop_rate.sleep();
	}
  return 0;
}
