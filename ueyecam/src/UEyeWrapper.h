/*
 * UEyeCam.h
 *
 *  Created on: 18.10.2011
 *      Author: maxim
 */

#ifndef UEyeWrapper_H_
#define UEyeWrapper_H_

#include <stdio.h>
#include <ueye.h>
#include <ros/ros.h>
#include <sensor_msgs/Image.h>
#include <sensor_msgs/CameraInfo.h>
#include <sensor_msgs/image_encodings.h>

#include <opencv2/imgproc/imgproc.hpp>
#include <opencv2/highgui/highgui.hpp>

#include <cv_bridge/cv_bridge.h>
#include <boost/thread.hpp>

using namespace std;
namespace enc = sensor_msgs::image_encodings;


class UEyeCam {

public:
	UEyeCam(HIDS &hCam, string frameId);
	UEyeCam(int hCam, string frameId);
	virtual ~UEyeCam();

	//These methods throw std::runtimerros
	void setROI(int x_offset, int y_offset, int width, int height);
	void setROIFullResolution();
	void setEncoding(string rosEncoding);
	void initMemory();

	//These methods return true if everything works, /false for errors
	bool startLiveMode();
	bool stopLiveMode();
	bool exitCamera();
	bool captureFrame();
	bool loadParamFile(string filename);
	bool setFPS(double fpsValue);
	bool setFPSAuto(bool autoFPSOn);
	bool setShutterAuto(bool shutterAutoOn);
	bool setGainAuto(bool gainAutoOn);
	bool setEdgeEnhancement(int value);
	bool copyImageData(char* target);
	bool makePreview(char* preview);
	bool saveImage(string filename);

	//These methods return values (need add const for appropriate functions)
	double getFPS();
	bool getFPSAuto();
	bool getGainAuto();
	bool getShutterAuto();
	int getEdgeEnhancement();
	string getEdgeEnhancementString();
	SENSORINFO getSensInfo() const;
	CAMINFO	getCamInfo() const;
	char* getImageMemoryPointer() const;
	string getSensorIdentfication() const;
	sensor_msgs::CameraInfo getCameraInfoMsgs(string frameID) const;
	sensor_msgs::Image getImageMsgs(string frameID) const;
	sensor_msgs::ImagePtr getPreviewMsg();
	bool getLiveVideoOn();
	int getCvEncoding();

	void checkDisconnection(bool &disconnectValue);
	int rosToUeyeEncoding(string rosEncoding);

private:
	void initCamera();
	void initSensorInfo();
	void initCameraInfo();
	char *ppcImgMem;
	int pid, cvEncoding_;
	string frameId_, encoding_, rosEncoding_;
  void cameraDisconnectThread(bool &disconnectvalue);
	sensor_msgs::Image imageMsg, previewMsg_;
	sensor_msgs::ImagePtr imageMsgPtr;
	cv_bridge::CvImagePtr cvImagePtr_;
	cv::Size previewSize_;

	HIDS uEyeCam_;
	SENSORINFO sensInfo;
	CAMINFO camInfo;
	boost::thread * disconThread;

	double width_, height_;
	double x_offset, y_offset;
	int step;
};

#endif /* UEyeWrapper_H_ */
