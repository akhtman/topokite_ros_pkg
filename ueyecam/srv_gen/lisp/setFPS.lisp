; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setFPS-request.msg.html

(cl:defclass <setFPS-request> (roslisp-msg-protocol:ros-message)
  ((fps
    :reader fps
    :initarg :fps
    :type cl:float
    :initform 0.0))
)

(cl:defclass setFPS-request (<setFPS-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setFPS-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setFPS-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setFPS-request> is deprecated: use ueyecam-srv:setFPS-request instead.")))

(cl:ensure-generic-function 'fps-val :lambda-list '(m))
(cl:defmethod fps-val ((m <setFPS-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:fps-val is deprecated.  Use ueyecam-srv:fps instead.")
  (fps m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setFPS-request>) ostream)
  "Serializes a message object of type '<setFPS-request>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'fps))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setFPS-request>) istream)
  "Deserializes a message object of type '<setFPS-request>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'fps) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setFPS-request>)))
  "Returns string type for a service object of type '<setFPS-request>"
  "ueyecam/setFPSRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPS-request)))
  "Returns string type for a service object of type 'setFPS-request"
  "ueyecam/setFPSRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setFPS-request>)))
  "Returns md5sum for a message object of type '<setFPS-request>"
  "d6233c61096f7e9e4b2f127a64d00493")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setFPS-request)))
  "Returns md5sum for a message object of type 'setFPS-request"
  "d6233c61096f7e9e4b2f127a64d00493")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setFPS-request>)))
  "Returns full string definition for message of type '<setFPS-request>"
  (cl:format cl:nil "float32 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setFPS-request)))
  "Returns full string definition for message of type 'setFPS-request"
  (cl:format cl:nil "float32 fps~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setFPS-request>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setFPS-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setFPS-request
    (cl:cons ':fps (fps msg))
))
;//! \htmlinclude setFPS-response.msg.html

(cl:defclass <setFPS-response> (roslisp-msg-protocol:ros-message)
  ((newFPS
    :reader newFPS
    :initarg :newFPS
    :type cl:float
    :initform 0.0))
)

(cl:defclass setFPS-response (<setFPS-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setFPS-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setFPS-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setFPS-response> is deprecated: use ueyecam-srv:setFPS-response instead.")))

(cl:ensure-generic-function 'newFPS-val :lambda-list '(m))
(cl:defmethod newFPS-val ((m <setFPS-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:newFPS-val is deprecated.  Use ueyecam-srv:newFPS instead.")
  (newFPS m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setFPS-response>) ostream)
  "Serializes a message object of type '<setFPS-response>"
  (cl:let ((bits (roslisp-utils:encode-single-float-bits (cl:slot-value msg 'newFPS))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) bits) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) bits) ostream))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setFPS-response>) istream)
  "Deserializes a message object of type '<setFPS-response>"
    (cl:let ((bits 0))
      (cl:setf (cl:ldb (cl:byte 8 0) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) bits) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) bits) (cl:read-byte istream))
    (cl:setf (cl:slot-value msg 'newFPS) (roslisp-utils:decode-single-float-bits bits)))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setFPS-response>)))
  "Returns string type for a service object of type '<setFPS-response>"
  "ueyecam/setFPSResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPS-response)))
  "Returns string type for a service object of type 'setFPS-response"
  "ueyecam/setFPSResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setFPS-response>)))
  "Returns md5sum for a message object of type '<setFPS-response>"
  "d6233c61096f7e9e4b2f127a64d00493")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setFPS-response)))
  "Returns md5sum for a message object of type 'setFPS-response"
  "d6233c61096f7e9e4b2f127a64d00493")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setFPS-response>)))
  "Returns full string definition for message of type '<setFPS-response>"
  (cl:format cl:nil "float32 newFPS~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setFPS-response)))
  "Returns full string definition for message of type 'setFPS-response"
  (cl:format cl:nil "float32 newFPS~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setFPS-response>))
  (cl:+ 0
     4
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setFPS-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setFPS-response
    (cl:cons ':newFPS (newFPS msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setFPS)))
  'setFPS-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setFPS)))
  'setFPS-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPS)))
  "Returns string type for a service object of type '<setFPS>"
  "ueyecam/setFPS")