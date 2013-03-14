; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setGainAuto-request.msg.html

(cl:defclass <setGainAuto-request> (roslisp-msg-protocol:ros-message)
  ((autoGainOn
    :reader autoGainOn
    :initarg :autoGainOn
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setGainAuto-request (<setGainAuto-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setGainAuto-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setGainAuto-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setGainAuto-request> is deprecated: use ueyecam-srv:setGainAuto-request instead.")))

(cl:ensure-generic-function 'autoGainOn-val :lambda-list '(m))
(cl:defmethod autoGainOn-val ((m <setGainAuto-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:autoGainOn-val is deprecated.  Use ueyecam-srv:autoGainOn instead.")
  (autoGainOn m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setGainAuto-request>) ostream)
  "Serializes a message object of type '<setGainAuto-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'autoGainOn) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setGainAuto-request>) istream)
  "Deserializes a message object of type '<setGainAuto-request>"
    (cl:setf (cl:slot-value msg 'autoGainOn) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setGainAuto-request>)))
  "Returns string type for a service object of type '<setGainAuto-request>"
  "ueyecam/setGainAutoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setGainAuto-request)))
  "Returns string type for a service object of type 'setGainAuto-request"
  "ueyecam/setGainAutoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setGainAuto-request>)))
  "Returns md5sum for a message object of type '<setGainAuto-request>"
  "f4bcdb7cb8a2d309439357abe46d441b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setGainAuto-request)))
  "Returns md5sum for a message object of type 'setGainAuto-request"
  "f4bcdb7cb8a2d309439357abe46d441b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setGainAuto-request>)))
  "Returns full string definition for message of type '<setGainAuto-request>"
  (cl:format cl:nil "bool autoGainOn~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setGainAuto-request)))
  "Returns full string definition for message of type 'setGainAuto-request"
  (cl:format cl:nil "bool autoGainOn~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setGainAuto-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setGainAuto-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setGainAuto-request
    (cl:cons ':autoGainOn (autoGainOn msg))
))
;//! \htmlinclude setGainAuto-response.msg.html

(cl:defclass <setGainAuto-response> (roslisp-msg-protocol:ros-message)
  ((currentAutoGain
    :reader currentAutoGain
    :initarg :currentAutoGain
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setGainAuto-response (<setGainAuto-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setGainAuto-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setGainAuto-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setGainAuto-response> is deprecated: use ueyecam-srv:setGainAuto-response instead.")))

(cl:ensure-generic-function 'currentAutoGain-val :lambda-list '(m))
(cl:defmethod currentAutoGain-val ((m <setGainAuto-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:currentAutoGain-val is deprecated.  Use ueyecam-srv:currentAutoGain instead.")
  (currentAutoGain m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setGainAuto-response>) ostream)
  "Serializes a message object of type '<setGainAuto-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'currentAutoGain) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setGainAuto-response>) istream)
  "Deserializes a message object of type '<setGainAuto-response>"
    (cl:setf (cl:slot-value msg 'currentAutoGain) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setGainAuto-response>)))
  "Returns string type for a service object of type '<setGainAuto-response>"
  "ueyecam/setGainAutoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setGainAuto-response)))
  "Returns string type for a service object of type 'setGainAuto-response"
  "ueyecam/setGainAutoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setGainAuto-response>)))
  "Returns md5sum for a message object of type '<setGainAuto-response>"
  "f4bcdb7cb8a2d309439357abe46d441b")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setGainAuto-response)))
  "Returns md5sum for a message object of type 'setGainAuto-response"
  "f4bcdb7cb8a2d309439357abe46d441b")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setGainAuto-response>)))
  "Returns full string definition for message of type '<setGainAuto-response>"
  (cl:format cl:nil "bool currentAutoGain~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setGainAuto-response)))
  "Returns full string definition for message of type 'setGainAuto-response"
  (cl:format cl:nil "bool currentAutoGain~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setGainAuto-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setGainAuto-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setGainAuto-response
    (cl:cons ':currentAutoGain (currentAutoGain msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setGainAuto)))
  'setGainAuto-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setGainAuto)))
  'setGainAuto-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setGainAuto)))
  "Returns string type for a service object of type '<setGainAuto>"
  "ueyecam/setGainAuto")