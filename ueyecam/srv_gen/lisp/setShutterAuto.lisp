; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setShutterAuto-request.msg.html

(cl:defclass <setShutterAuto-request> (roslisp-msg-protocol:ros-message)
  ((autoShutterOn
    :reader autoShutterOn
    :initarg :autoShutterOn
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setShutterAuto-request (<setShutterAuto-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setShutterAuto-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setShutterAuto-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setShutterAuto-request> is deprecated: use ueyecam-srv:setShutterAuto-request instead.")))

(cl:ensure-generic-function 'autoShutterOn-val :lambda-list '(m))
(cl:defmethod autoShutterOn-val ((m <setShutterAuto-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:autoShutterOn-val is deprecated.  Use ueyecam-srv:autoShutterOn instead.")
  (autoShutterOn m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setShutterAuto-request>) ostream)
  "Serializes a message object of type '<setShutterAuto-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'autoShutterOn) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setShutterAuto-request>) istream)
  "Deserializes a message object of type '<setShutterAuto-request>"
    (cl:setf (cl:slot-value msg 'autoShutterOn) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setShutterAuto-request>)))
  "Returns string type for a service object of type '<setShutterAuto-request>"
  "ueyecam/setShutterAutoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setShutterAuto-request)))
  "Returns string type for a service object of type 'setShutterAuto-request"
  "ueyecam/setShutterAutoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setShutterAuto-request>)))
  "Returns md5sum for a message object of type '<setShutterAuto-request>"
  "6782540b0448994e3619d704361a9735")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setShutterAuto-request)))
  "Returns md5sum for a message object of type 'setShutterAuto-request"
  "6782540b0448994e3619d704361a9735")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setShutterAuto-request>)))
  "Returns full string definition for message of type '<setShutterAuto-request>"
  (cl:format cl:nil "bool autoShutterOn~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setShutterAuto-request)))
  "Returns full string definition for message of type 'setShutterAuto-request"
  (cl:format cl:nil "bool autoShutterOn~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setShutterAuto-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setShutterAuto-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setShutterAuto-request
    (cl:cons ':autoShutterOn (autoShutterOn msg))
))
;//! \htmlinclude setShutterAuto-response.msg.html

(cl:defclass <setShutterAuto-response> (roslisp-msg-protocol:ros-message)
  ((currentAutoShutter
    :reader currentAutoShutter
    :initarg :currentAutoShutter
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setShutterAuto-response (<setShutterAuto-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setShutterAuto-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setShutterAuto-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setShutterAuto-response> is deprecated: use ueyecam-srv:setShutterAuto-response instead.")))

(cl:ensure-generic-function 'currentAutoShutter-val :lambda-list '(m))
(cl:defmethod currentAutoShutter-val ((m <setShutterAuto-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:currentAutoShutter-val is deprecated.  Use ueyecam-srv:currentAutoShutter instead.")
  (currentAutoShutter m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setShutterAuto-response>) ostream)
  "Serializes a message object of type '<setShutterAuto-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'currentAutoShutter) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setShutterAuto-response>) istream)
  "Deserializes a message object of type '<setShutterAuto-response>"
    (cl:setf (cl:slot-value msg 'currentAutoShutter) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setShutterAuto-response>)))
  "Returns string type for a service object of type '<setShutterAuto-response>"
  "ueyecam/setShutterAutoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setShutterAuto-response)))
  "Returns string type for a service object of type 'setShutterAuto-response"
  "ueyecam/setShutterAutoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setShutterAuto-response>)))
  "Returns md5sum for a message object of type '<setShutterAuto-response>"
  "6782540b0448994e3619d704361a9735")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setShutterAuto-response)))
  "Returns md5sum for a message object of type 'setShutterAuto-response"
  "6782540b0448994e3619d704361a9735")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setShutterAuto-response>)))
  "Returns full string definition for message of type '<setShutterAuto-response>"
  (cl:format cl:nil "bool currentAutoShutter~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setShutterAuto-response)))
  "Returns full string definition for message of type 'setShutterAuto-response"
  (cl:format cl:nil "bool currentAutoShutter~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setShutterAuto-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setShutterAuto-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setShutterAuto-response
    (cl:cons ':currentAutoShutter (currentAutoShutter msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setShutterAuto)))
  'setShutterAuto-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setShutterAuto)))
  'setShutterAuto-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setShutterAuto)))
  "Returns string type for a service object of type '<setShutterAuto>"
  "ueyecam/setShutterAuto")