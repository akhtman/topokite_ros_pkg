/*
 * ServiceHandler.cpp
 *
 *  Created on: 19.10.2011
 *      Author: maxim
 */

#include "ServiceHandler.h"

ServiceHandler::ServiceHandler(ros::NodeHandle nh, UEyeCam *uEye) : nh_(nh)
{
	uEye_ = uEye;
	setFPSService = nh_.advertiseService("setFPS", &ServiceHandler::setFPS, this);
	setFPSAutoService = nh_.advertiseService("setFPSAuto", &ServiceHandler::setFPSAuto, this);
	setShutterAutoService = nh_.advertiseService("setShutterAuto", &ServiceHandler::setShutterAuto, this);
	setGainAutoService = nh_.advertiseService("setGainAuto", &ServiceHandler::setGainAuto, this);
	setEdgeEnhancementService = nh_.advertiseService("setEdgeEnhancement", &ServiceHandler::setEdgeEnhancement, this);
	setROIService = nh_.advertiseService("setROI", &ServiceHandler::setROI, this);
	setEncodingService = nh_.advertiseService("setEncoding", &ServiceHandler::setEncoding, this);
	setROIFullService = nh_.advertiseService("setROIFull", &ServiceHandler::setROIFull, this);
	saveImageService = nh_.advertiseService("SaveImage", &ServiceHandler::saveImage, this);
}

ServiceHandler::~ServiceHandler() {
	// TODO Auto-generated destructor stub
}

bool ServiceHandler::saveImage(ueyecam::SaveImage::Request &req, ueyecam::SaveImage::Response &res)
{
	ROS_INFO("Trying to save image...");
	res.success = uEye_->saveImage(req.filename);
	return res.success;
}

bool ServiceHandler::setFPS(ueyecam::setFPS::Request &req, ueyecam::setFPS::Response &res)
{
	bool success = uEye_->setFPS(req.fps);
	res.newFPS = uEye_->getFPS();
	return success;
}

bool ServiceHandler::setFPSAuto(ueyecam::setFPSAuto::Request &req, ueyecam::setFPSAuto::Response &res)
{
	bool success = uEye_->setFPSAuto(req.autoFPSon);
	res.currentAutoFPs = uEye_->getFPSAuto();
	return success;
}

bool ServiceHandler::setShutterAuto(ueyecam::setShutterAuto::Request &req, ueyecam::setShutterAuto::Response &res)
{
	bool success = uEye_->setShutterAuto(req.autoShutterOn);
	res.currentAutoShutter = uEye_->getShutterAuto();
	return success;
}

bool ServiceHandler::setGainAuto(ueyecam::setGainAuto::Request &req, ueyecam::setGainAuto::Response &res)
{
	bool success = uEye_->setGainAuto(req.autoGainOn);
	res.currentAutoGain = uEye_->getGainAuto();
	return success;
}

bool ServiceHandler::setEdgeEnhancement(ueyecam::setEdgeEnhancement::Request &req, ueyecam::setEdgeEnhancement::Response &res)
{
	bool success = uEye_->setEdgeEnhancement(req.edgeEnhancementSet);
	res.edgeEnhancementGet = uEye_->getEdgeEnhancement();
	res.edgeEnhancementGetString = uEye_->getEdgeEnhancementString();
	return success;
}

bool ServiceHandler::setROI(ueyecam::setROI::Request &req, ueyecam::setROI::Response &res) 
{
	bool success = true;
	uEye_->setROI(req.x_offset,req.y_offset,req.width,req.height);
	uEye_->initMemory();
	return success;
}

bool ServiceHandler::setROIFull(ueyecam::setROIFull::Request &req, ueyecam::setROIFull::Response &res) 
{
	bool success = true;
	uEye_->setROIFullResolution();
	uEye_->initMemory();
	return success;
}

bool ServiceHandler::setEncoding(ueyecam::setEncoding::Request &req, ueyecam::setEncoding::Response &res) 
{
	bool success = true;
	bool liveVideoOn;
	liveVideoOn = uEye_->getLiveVideoOn(); //needs to be off to allow encoding change;
	if (liveVideoOn) uEye_->stopLiveMode();
	try {
		uEye_->setEncoding(req.encoding);
		uEye_->initMemory();
	}
	catch(std::runtime_error &e) {
		ROS_ERROR("%s",e.what());
	}
	if (liveVideoOn) uEye_->startLiveMode();
	return success;
}
