/*
 * ServiceHandler.h
 *
 *  Created on: 19.10.2011
 *      Author: maxim
 */

#ifndef SERVICEHANDLER_H_
#define SERVICEHANDLER_H_

#include "UEyeWrapper.h"
#include <ueyecam/setFPS.h>
#include <ueyecam/setFPSAuto.h>
#include <ueyecam/setShutterAuto.h>
#include <ueyecam/setGainAuto.h>
#include <ueyecam/setEdgeEnhancement.h>
#include <ueyecam/setROI.h>
#include <ueyecam/setROIFull.h>
#include <ueyecam/setEncoding.h>
#include <ueyecam/SaveImage.h>

class ServiceHandler {
public:
	ServiceHandler(ros::NodeHandle nh, UEyeCam *newUeye);
	virtual ~ServiceHandler();

	bool setFPS(ueyecam::setFPS::Request &req, ueyecam::setFPS::Response &res);
	bool setFPSAuto(ueyecam::setFPSAuto::Request &req, ueyecam::setFPSAuto::Response &res);
	bool setShutterAuto(ueyecam::setShutterAuto::Request &req, ueyecam::setShutterAuto::Response &res);
	bool setGainAuto(ueyecam::setGainAuto::Request &req, ueyecam::setGainAuto::Response &res);
	bool setEdgeEnhancement(ueyecam::setEdgeEnhancement::Request &req, ueyecam::setEdgeEnhancement::Response &res);
	bool setROI(ueyecam::setROI::Request &req, ueyecam::setROI::Response &res);
	bool setROIFull(ueyecam::setROIFull::Request &req, ueyecam::setROIFull::Response &res);
	bool setEncoding(ueyecam::setEncoding::Request &req, ueyecam::setEncoding::Response &res);
	bool saveImage(ueyecam::SaveImage::Request &req, ueyecam::SaveImage::Response &res);

	ros::NodeHandle nh_;
	UEyeCam *uEye_;
	ros::ServiceServer setFPSService;
	ros::ServiceServer setFPSAutoService ;
	ros::ServiceServer setShutterAutoService;
	ros::ServiceServer setGainAutoService;
	ros::ServiceServer setEdgeEnhancementService;
	ros::ServiceServer setROIService;
	ros::ServiceServer setROIFullService;
	ros::ServiceServer setEncodingService;
	ros::ServiceServer saveImageService;

};

#endif /* SERVICEHANDLER_H_ */
