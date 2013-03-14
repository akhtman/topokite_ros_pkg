/*
 * UEyeCam.cpp
 *
 *  Created on: 18.10.2011
 *      Author: maxim
 */

#include "UEyeWrapper.h"

//TODO:: Think about Mutex!!

UEyeCam::UEyeCam(int hCam, string frameId = "/ueyecam") 
{
	uEyeCam_ = hCam;
	initCamera();
	initSensorInfo();
	x_offset = 0;
	y_offset = 0;
	width_ = 0;
	height_ = 0;
	previewSize_.height = 600;
	previewSize_.width = 800;
	encoding_ = "";
	cv::namedWindow("image", CV_WINDOW_AUTOSIZE);
}

UEyeCam::UEyeCam(HIDS &hCam, string frameId = "/ueyecam") 
{
	UEyeCam((int)hCam, frameId);
}

UEyeCam::~UEyeCam() 
{
	// TODO Auto-generated destructor stub.. include memoryfree and threadstopping and so on;
	//Thing about using shared::ptr;
}

void UEyeCam::initCamera() 
{
	if (is_InitCamera (&uEyeCam_, NULL)) throw std::runtime_error("Camera could not be initiated! Is usb connected?");
	ROS_INFO("Camera is initiated");
}

void UEyeCam::setROI(int x_offsetT, int y_offsetT, int widthT, int heightT) 
{
	if (is_SetAOI(uEyeCam_, IS_SET_IMAGE_AOI, &x_offsetT, &y_offsetT, &widthT, &heightT)) 
		throw std::runtime_error("ROI could not be set");
	x_offset = x_offsetT;
	y_offset = y_offsetT;
	width_ = widthT;
	height_ = heightT;
	//initMemory();
}

void UEyeCam::setROIFullResolution()
{
	setROI(0,0,sensInfo.nMaxWidth,sensInfo.nMaxHeight);
}

void UEyeCam::setEncoding(string rosEncoding) 
{
	if (is_SetColorMode (uEyeCam_, rosToUeyeEncoding(rosEncoding))) 
		throw std::runtime_error("Encoding %s could not be set" + rosEncoding);
	encoding_ = rosEncoding;
	//	ROS_ERROR("Encoding %s could not be set", rosEncoding.c_str());
}

bool UEyeCam::setFPSAuto(bool autoFPSOn) 
{
	double fpsAuto, autoGainState, shutterAutoState;
	int result;
	fpsAuto = autoFPSOn;
	is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_GAIN, &autoGainState, 0);
	is_SetAutoParameter (uEyeCam_,  IS_GET_ENABLE_AUTO_SHUTTER, &shutterAutoState, 0);
	if (fpsAuto){
		if (!shutterAutoState) ROS_ERROR("Auto FPS can not be set: Autoshutter has to be enabled");
		if (autoGainState) ROS_ERROR("Auto FPS can not be set: Autogain has to be disabled");
	}
	result= is_SetAutoParameter (uEyeCam_, IS_SET_ENABLE_AUTO_FRAMERATE, &fpsAuto, 0);
	ROS_INFO("4");
	if (result == IS_NO_SUCCESS) {
		ROS_ERROR("Error Calling Ueye API");
		return false;
	}
	return true;
}

bool UEyeCam::setFPS(double fpsVlaue)
{
	double disable, fpsAutoState, fps, newfps;
	int result;
	disable = 0;
	is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_FRAMERATE, &fpsAutoState, 0);
	if (fpsAutoState) ROS_INFO("AutoFPS is enabled: Disabling now...");
	is_SetAutoParameter (uEyeCam_, IS_SET_ENABLE_AUTO_FRAMERATE, &disable, 0);
	result = is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_FRAMERATE, &fpsAutoState, 0);
	if (result == IS_NO_SUCCESS) {
		ROS_ERROR("Error Calling Ueye API");
		return false;
	}
	fps = fpsVlaue;
	result = is_SetFrameRate(uEyeCam_,fps,&newfps);
	if (result == IS_NO_SUCCESS) {
		ROS_ERROR("Error Calling Ueye API");
		return false;
	}
	return true;
}

bool UEyeCam::setEdgeEnhancement(int edgeValue)
{
	int result;
	switch (edgeValue) {  // I don't like the uEye Values for EdgeEnhancement, that's why i switched
	case 0: result = is_SetEdgeEnhancement (uEyeCam_, IS_EDGE_EN_DISABLE); break;
	case 1: result = is_SetEdgeEnhancement (uEyeCam_, IS_EDGE_EN_WEAK); break;
	case 2: result = is_SetEdgeEnhancement (uEyeCam_, IS_EDGE_EN_STRONG); break;
	default:
		ROS_ERROR("Edge Value not Valid: Has to be 0,1,2");
		return false;
		break;
	}
	if (result == IS_NO_SUCCESS) {
		ROS_ERROR("Error Calling Ueye API");
	}
	return true;
}


int UEyeCam::getEdgeEnhancement()
{
	int edgeValueState = is_SetEdgeEnhancement (uEyeCam_, IS_GET_EDGE_ENHANCEMENT);
	switch (edgeValueState) { // I don't like the uEye Values for EdgeEnhancement, that's why i switched
	case 0: return 0;
	break;
	case 1: return 2;
	break;
	case 2: return 1;
	break;
	default:
		ROS_ERROR("edgeEnhancement value not known");
		return 0;
		break;
	}
}

string UEyeCam::getEdgeEnhancementString()
{
	int edgeValueState = getEdgeEnhancement();
	string values[3] = {"Disabled","Weak","Strong"};
	return values[edgeValueState];
}

double UEyeCam::getFPS(){

	double fpsOfCam = 0;
	int fpsGet = is_GetFramesPerSecond(uEyeCam_,&fpsOfCam);

	if (fpsGet!=IS_SUCCESS) {
		ROS_INFO("Could not retrieve FPS of UEye camera");
	}

	return fpsOfCam;
}

bool UEyeCam::getFPSAuto()
{
	double fpsAuto;
	if(is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_FRAMERATE, &fpsAuto, 0)) 
		throw std::runtime_error("FPS Auto could not be retrieved");
	return fpsAuto;
}

bool UEyeCam::getGainAuto()
{
	double gainAuto;
	if(is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_GAIN, &gainAuto, 0)) 
		throw std::runtime_error("Gain Auto  could not be retrieved");
	return gainAuto;
}
bool UEyeCam::getShutterAuto()
{
	double shutterAuto;
	if(is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_SHUTTER, &shutterAuto, 0)) 
		throw std::runtime_error("Shutter Auto  could not be retrieved");
	return shutterAuto;
}

bool UEyeCam::captureFrame()
{
	INT captFrame = is_FreezeVideo (uEyeCam_, IS_WAIT); // set time delay to 60s
	if (captFrame != IS_SUCCESS){
		ROS_INFO("error in frame capturing");
		return false;
	}
	return true;
}

bool UEyeCam::setShutterAuto(bool shutterAutoOn)
{
	double shutterAuto;
	int result;
	shutterAuto = shutterAutoOn;
	result = is_SetAutoParameter (uEyeCam_, IS_SET_ENABLE_AUTO_SHUTTER, &shutterAuto, 0);
	if (result == IS_NO_SUCCESS){
		ROS_ERROR("Error Calling Ueye API");
		return false;
	}
	return true;
}

bool UEyeCam::setGainAuto(bool gainAutoOn)
{
	double gainAuto, fpsAutoState;
	bool result;

	gainAuto = gainAutoOn;
	is_SetAutoParameter (uEyeCam_, IS_GET_ENABLE_AUTO_FRAMERATE, &fpsAutoState, 0);

	if (gainAutoOn == true)
		if (fpsAutoState) {
			ROS_ERROR("Autogain can not be set: Autos FPS has to be disabled");
			return false;
		}

	result = is_SetAutoParameter(uEyeCam_, IS_SET_ENABLE_AUTO_GAIN, &gainAuto, 0);

	if (result == IS_NO_SUCCESS) {
		ROS_ERROR("Error Calling Ueye API");
		return false;
	}	else {
		double wbSpeed = 1.0;
		double wb = 1.0;
		is_SetAutoParameter(uEyeCam_, IS_SET_ENABLE_AUTO_WHITEBALANCE, &wb, 0);
		is_SetAutoParameter(uEyeCam_, IS_SET_AUTO_WB_SPEED, &wbSpeed, 0);
		is_SetAutoParameter(uEyeCam_, IS_SET_ENABLE_AUTO_SHUTTER, &wb, 0);
	}
	return true;
}


bool UEyeCam::startLiveMode()
{
	int startCapture = is_CaptureVideo (uEyeCam_, IS_WAIT);

	switch (startCapture) {
	case IS_SUCCESS:
		ROS_INFO("Live Video capture started");
		break;
	case IS_NO_SUCCESS:
		ROS_INFO("Live Video capture not started");
		return false;
	case IS_TRIGGER_ACTIVATED:
		ROS_INFO("Live Video capture not started: Camera is already waiting for trigger!");
		return false;
	case IS_GET_LIVE:
		ROS_INFO("Live Capturing is alive");
	default:
		ROS_INFO("This is one of the messages you should actually never see");
		return false;
		break;
	}

	return true;
}

bool UEyeCam::getLiveVideoOn() 
{
	return is_CaptureVideo (uEyeCam_, IS_GET_LIVE);
}


void UEyeCam::initSensorInfo() 
{
	if (is_GetSensorInfo(uEyeCam_, &sensInfo)) 
		throw std::runtime_error("sensor info not acquired");
}


void UEyeCam::initCameraInfo() 
{
	if (is_GetCameraInfo(uEyeCam_,&camInfo)) 
		throw std::runtime_error("sensor info not acquired");
}

void UEyeCam::initMemory()
{
	ROS_INFO("Allocating memory...");
	if ((height_ == 0) || (width_ == 0)) 
		throw std::runtime_error("Values for height and width are not reasonable. Did you set them correctly?");
	if (encoding_ == "") throw std::runtime_error("Encoding has to be set first");

	if (is_AllocImageMem(uEyeCam_, width_, height_, enc::bitDepth(encoding_)*enc::numChannels(encoding_), &ppcImgMem, &pid))
		throw std::runtime_error("Memory could not be allocated");
	if (is_SetImageMem (uEyeCam_, ppcImgMem, pid)) throw std::runtime_error("Memory not available");
	if (is_AddToSequence (uEyeCam_, ppcImgMem, pid)) throw std::runtime_error("Memory could not be added to sequence");

	ROS_INFO("Memory is allocated and added to sequence");
	is_GetImageMemPitch(uEyeCam_, &step);
}

bool UEyeCam::stopLiveMode()
{
	if (is_StopLiveVideo (uEyeCam_, IS_DONT_WAIT) != IS_SUCCESS) return false;
	return true;
}

bool UEyeCam::exitCamera()
{
	disconThread->interrupt();
	disconThread->join();
	is_FreeImageMem (uEyeCam_, ppcImgMem, pid); // free the allocated memory
	is_ExitCamera (uEyeCam_); 	// exit camera
	return true;
}

bool UEyeCam::copyImageData(char* target)
{
	is_LockSeqBuf (uEyeCam_, 0, ppcImgMem);//TODO::Error Handling
	memcpy(target, ppcImgMem, height_*step);
	is_UnlockSeqBuf (uEyeCam_, 0, ppcImgMem);
	return true;
}

sensor_msgs::ImagePtr UEyeCam::getPreviewMsg()
{
	cout << "start" << endl; 
	//cv::Mat image(height_, width_, cvEncoding_);
	//cv::Mat preview(preH_, preW_, cvEncoding_);
	
	//cvPtr_->image.create(height_, width_, cvEncoding_); cout << "1" << endl;
	//cvPtr_->image.data = (uchar *)ppcImgMem; cout << "2" << endl;
	//cv::resize(cvPtr_->image, cvPtr_->image, previewSize_); cout << "3" << endl;
	//cv::imshow("Preview", cvPtr_->image);
	//cv::waitKey(3);
	//previewMsg_ = bridge_.cvToImgMsg(preview, "bgr8");
	
	
	cvPtr_->header.frame_id = frameId_;
	cvPtr_->header.stamp = ros::Time::now();
	return cvPtr_->toImageMsg();
	
}

bool UEyeCam::makePreview(char* target)
{/*
	try {
		cv::Mat image(height_, width_, this->cvEncoding_);
		cv::Mat preview(preH_, preW_, this->cvEncoding_);
		this->copyImageData((char *) image.data);
		cv::resize(image, preview, preview.size());
		memcpy(target, preview.data, preH_*step);
		return true;
	}
	catch  ( cv::Exception& e ) {
		ROS_ERROR("%s", e.what());
		return false;
	}*/
	return false;
}

bool UEyeCam::saveImage(string filename)
{
	ROS_INFO("Saving image %s", filename.c_str());
	try {
		cv::Mat image(height_, width_, this->cvEncoding_);
		this->copyImageData((char *) image.data);
		cvtColor(image, image, CV_BGR2RGB);
		return cv::imwrite(filename, image);
	} 
	catch ( cv::Exception& e ) {
		ROS_ERROR("%s", e.what());
		return false;
	}
}

bool UEyeCam::loadParamFile(string filename) 
{
	printf("Setting camera parameters automatically");
	const IS_CHAR* fileName = filename.c_str();

	if (is_LoadParameters (uEyeCam_, fileName) != IS_SUCCESS) 	// loading camera parameters
	{
		ROS_INFO("Parameter Loading (param.ini) has failed - using AutoConfiguration");
		return false;
	}
	return true;
}

void UEyeCam::cameraDisconnectThread(bool &disconnectvalue) 
{
	// This Thread is checking whether the camera is disconnect. In Case it is the disconnectvalue gets true */
	is_EnableEvent(uEyeCam_, IS_SET_EVENT_REMOVE);
	while (ros::ok()) {
		INT nRet = is_WaitEvent(uEyeCam_, IS_SET_EVENT_REMOVE,500);
		if (nRet == IS_TIMED_OUT);
		else if(nRet == IS_SUCCESS)	disconnectvalue = true;
		try { boost::this_thread::interruption_point();	}
		catch (boost::thread_interrupted e) {
			ROS_DEBUG("WatcherThread killed");
			break;}
	}
	is_DisableEvent(uEyeCam_, IS_SET_EVENT_REMOVE);
}

void UEyeCam::checkDisconnection(bool &disconnectvalue) 
{
	disconThread = new boost::thread(boost::bind((&UEyeCam::cameraDisconnectThread),
		this,	boost::ref(disconnectvalue))); //This Thread is checking whether a camera gets disconnected.
}

SENSORINFO UEyeCam::getSensInfo() const
{
	return sensInfo;
}

CAMINFO UEyeCam::getCamInfo() const
{
	return camInfo;
}

char* UEyeCam::getImageMemoryPointer() const
{
	return ppcImgMem;
}

string UEyeCam::getSensorIdentfication() const 
{
	stringstream sensorIdentification;
	sensorIdentification <<
			getSensInfo().strSensorName << "-" <<
			getSensInfo().nMaxWidth << "x" <<
			getSensInfo().nMaxHeight << "_" <<
			"plumb_bob";
	//distortionModel; //CameraName is the SensorIdentification. I includes SensorName,width,height,distortionmodel
	return sensorIdentification.str();
}

sensor_msgs::Image UEyeCam::getImageMsgs(string frame_id) const 
{
	sensor_msgs::Image ros_image_msg;
	ros_image_msg.header.frame_id = frame_id;
	ros_image_msg.height = height_;
	ros_image_msg.width = width_;
	ros_image_msg.encoding = encoding_;
	ros_image_msg.is_bigendian = false;
	ros_image_msg.step = step;
	ros_image_msg.data.resize(height_*step);
	return ros_image_msg;
}

sensor_msgs::CameraInfo UEyeCam::getCameraInfoMsgs(string frame_id) const 
{
	sensor_msgs::CameraInfo cam_info_msg;

	cam_info_msg.header.frame_id=frame_id;
	cam_info_msg.height = sensInfo.nMaxHeight;
	cam_info_msg.width = sensInfo.nMaxWidth;
	//cam_info_msg.distortion_model = distortionmodel;
	cam_info_msg.distortion_model = "plumb_bob";

	if ((height_*width_)==(sensInfo.nMaxWidth*sensInfo.nMaxHeight)) {
		cam_info_msg.roi.height = height_;
		cam_info_msg.roi.width = width_;
		cam_info_msg.roi.x_offset = x_offset;
		cam_info_msg.roi.y_offset = y_offset;
		cam_info_msg.roi.do_rectify = true;
	}
	else {
		cam_info_msg.roi.height = 0;
		cam_info_msg.roi.width = 0;
		cam_info_msg.roi.x_offset = 0;
		cam_info_msg.roi.y_offset = 0;
		cam_info_msg.roi.do_rectify = false;
	}

	return cam_info_msg;
}

int UEyeCam::getCvEncoding()
{
	if (!rosEncoding_.compare("mono8")) return IS_CM_MONO8;
	if (!rosEncoding_.compare("mono16")) return IS_CM_MONO16;
	if (!rosEncoding_.compare("rgb8")) return IS_CM_RGB8_PACKED;
	return -1;
}

int UEyeCam::rosToUeyeEncoding(string rosEncode)
{
	if (!rosEncode.compare("mono8")) {
		cvEncoding_ = CV_8U;
		return IS_CM_MONO8;
	}
	if (!rosEncode.compare("mono16")) {
		cvEncoding_ = CV_16U;
		return IS_CM_MONO16;
	}
	if (!rosEncode.compare("rgb8")) {
		cvEncoding_ = CV_8UC3;
		return IS_CM_RGB8_PACKED;
	}

	throw std::runtime_error("Ros Encoding " + rosEncode +"could not be translated to UEyeEncoding");
	return 0;

	/* BitsPerPicelFunctionFrom uEyeDemo. I don't know why they just do not have such a function in the API
		 int Mainview::GetBitsPerPixel(int colormode)
		{
			switch (colormode)
			{
			default:
			case IS_CM_MONO8:
			case IS_CM_BAYER_RG8:
				return 8;   // occupies 8 Bit
			case IS_CM_MONO12:
			case IS_CM_MONO16:
			case IS_CM_BAYER_RG12:
			case IS_CM_BAYER_RG16:
			case IS_CM_BGR555_PACKED:
			case IS_CM_BGR565_PACKED:
			case IS_CM_UYVY_PACKED:
			case IS_CM_CBYCRY_PACKED:
				return 16;  // occupies 16 Bit
			case IS_CM_RGB8_PACKED:
			case IS_CM_BGR8_PACKED:
				return 24;
			case IS_CM_RGBA8_PACKED:
			case IS_CM_BGRA8_PACKED:
			case IS_CM_RGBY8_PACKED:
			case IS_CM_BGRY8_PACKED:
			case IS_CM_RGB10V2_PACKED:
			case IS_CM_BGR10V2_PACKED:
				return 32;
			}
		}
	 */
}