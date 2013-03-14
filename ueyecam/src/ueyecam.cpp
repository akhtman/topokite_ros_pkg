#include <ueye.h>
#include <ros/ros.h>
#include <std_msgs/String.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/SetCameraInfo.h>
#include <image_transport/image_transport.h>
#include <sensor_msgs/image_encodings.h>
#include <camera_info_manager/camera_info_manager.h>
#include "UEyeWrapper.h"
#include "ServiceHandler.h"

using namespace std;
namespace enc = sensor_msgs::image_encodings;

// define sensor messages to be published
sensor_msgs::Image ros_image_msg, previewMsg; // image captured by the camera
sensor_msgs::CameraInfo cam_info_msg; // camera parameters and model

int main(int argc, char **argv)
{

	ros::Time::init();
	ros::init(argc, argv, "ueyecam");   // initialize ros and node named roscam

	ros::NodeHandle nh("~");

	int uEyeID, roiWidth, roiHeight, fps, yOffset, xOffset;
	string cameraInfoFile, distortionModel, encoding;
	bool fullResolution, liveMode, gainAuto;

	//------------------------Setting Parameters via Parameter Server--------------------------------//
	nh.param("uEyeID", uEyeID, 1); //iv Parameters on Server not available ==> 1 as Value
	nh.param("fullResolution", fullResolution, true);
	//--------------------------Values for Region/Area of interest-----------------------------------//
	nh.param("roiWidth", roiWidth, 1280);  // < should'nt these be named as width_roi or something like that ? >
	nh.param("roiHeight", roiHeight, 1024);
	nh.param("xOffset", xOffset, 0);
	nh.param("yOffset", yOffset, 0);
	//--------------------------End Values for Region/Area of interest-----------------------------------//
	nh.param("fps", fps, 1); // TODO::by now this is only the framerate for the loop, not for UeyeAPI,, set higher agai
	//TODO:: reduce lps if fps lower
	nh.param<std::string>("encoding", encoding, "rgb8");
	nh.param("gainAuto", gainAuto, false);
	nh.param("liveMode", liveMode, true);
	nh.param<std::string>("cameraInfoFile", cameraInfoFile, "file://ueyecam.ini");
	nh.param<std::string>("distortionModel", distortionModel, "plumb_bob"); //TODO::has to be implemented into the UEyeCam
	
	image_transport::ImageTransport it(nh);  // image transporter
	//image_transport::CameraPublisher image_pub = it.advertiseCamera("image_raw", 1);
	image_transport::CameraPublisher pub = it.advertiseCamera("image", 1);
	image_transport::Publisher preview = it.advertise("preview", 1);

	//HIDS hCam = uEyeID;   // camera initialization (id=1) ...
	UEyeCam* uEyeCam = 0;

	try {
		uEyeCam = new UEyeCam(uEyeID, nh.getNamespace());
		if (fullResolution) uEyeCam->setROIFullResolution(); //TODO::Error Handling everywhere!!
		else uEyeCam->setROI(xOffset, yOffset, roiWidth, roiHeight);
		uEyeCam->setEncoding(encoding);
		uEyeCam->setFPS(fps);
		uEyeCam->setGainAuto(gainAuto);
	}
	catch (std::runtime_error& e) {
		ROS_ERROR("Error happened while Initializing:");
		ROS_ERROR("%s", e.what());
		return 0;
	}

	ServiceHandler serviceHandler(nh, uEyeCam); //this has an error when ending with ctr+c
	camera_info_manager::CameraInfoManager cinfo(nh, nh.getNamespace(), cameraInfoFile);
	//camera_info_manager::CameraInfoManager cinfo(nh_camera, uEyeCam->getSensorIdentfication()); 	//This means if one of these is changed a new calibration has to be made

	ros::Rate loop_rate(fps);
	ros::Time t_prev(ros::Time::now());
	int count = 0, skip_count = 0;

	bool disconnected = false; //This value is becoming true if the camera gets disconnected
	uEyeCam->checkDisconnection(disconnected);
	uEyeCam->initMemory();
	if (liveMode) uEyeCam->startLiveMode();
	while (ros::ok())
	{
		if (disconnected) { //Exiting Loop if camera gets disconnected TODO:: Maybe change to a try catch block and catching error camera unplugged
			ROS_ERROR("Camera got disconnected ==> Exit Node");
			break;
		}

		if (count++ % fps == 0)
		{
			ros::Time t(ros::Time::now());
			ros::Duration d(t - t_prev);
			ROS_INFO("%.1f fps skip %d - Cam Framerate: %f", (double)fps / d.toSec(), skip_count, uEyeCam->getFPS());
			t_prev = t;
		}

		if (!liveMode) if (!uEyeCam->captureFrame()) skip_count++;

		ros_image_msg = uEyeCam->getImageMsgs(nh.getNamespace());
		ros_image_msg.header.stamp = ros::Time::now();

		if (cinfo.isCalibrated()) cam_info_msg = cinfo.getCameraInfo();
		else cam_info_msg = uEyeCam->getCameraInfoMsgs(nh.getNamespace());
		//we might have to work on ROI message in case of changing it by param or service. CameraInfo Manager doesn't change its ROI;

		cam_info_msg.header.frame_id = ros_image_msg.header.frame_id;
		//cam_info_msg.header.seq = ros_image_msg.header.seq; //TODO:: Checkn ob das so richtig sit und warum nciht gleich der ganze header?
		//beim abrufen unterschiedlich??
		cam_info_msg.header.stamp = ros_image_msg.header.stamp;

		//ROS_INFO("Header seq %i",cam_info_msg.header.seq);
		//ROS_INFO("Image seq  %i",ros_image_msg.header.seq);

		uEyeCam->copyImageData((char*)(&ros_image_msg.data[0]));
		pub.publish(ros_image_msg, cam_info_msg); // publish captured image as ros sensor message*/
		//ROS_INFO("Height %i and width %i",ros_image_msg.height, ros_image_msg.width);
		
		//uEyeCam->makePreview((char*)(&previewMsg.data[0]));
		//preview.publish(uEyeCam->getPreviewMsg());
		uEyeCam->getPreviewMsg();
		ros::spinOnce();
		//loop_rate.sleep();
	}

	ROS_INFO("Image Publishing stopped");
	uEyeCam->stopLiveMode();
	uEyeCam->exitCamera();
	
	delete uEyeCam;

	ROS_INFO("Exiting Node");
	return 0;
}
