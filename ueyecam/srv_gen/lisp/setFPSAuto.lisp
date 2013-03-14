; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setFPSAuto-request.msg.html

(cl:defclass <setFPSAuto-request> (roslisp-msg-protocol:ros-message)
  ((autoFPSon
    :reader autoFPSon
    :initarg :autoFPSon
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setFPSAuto-request (<setFPSAuto-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setFPSAuto-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setFPSAuto-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setFPSAuto-request> is deprecated: use ueyecam-srv:setFPSAuto-request instead.")))

(cl:ensure-generic-function 'autoFPSon-val :lambda-list '(m))
(cl:defmethod autoFPSon-val ((m <setFPSAuto-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:autoFPSon-val is deprecated.  Use ueyecam-srv:autoFPSon instead.")
  (autoFPSon m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setFPSAuto-request>) ostream)
  "Serializes a message object of type '<setFPSAuto-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'autoFPSon) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setFPSAuto-request>) istream)
  "Deserializes a message object of type '<setFPSAuto-request>"
    (cl:setf (cl:slot-value msg 'autoFPSon) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setFPSAuto-request>)))
  "Returns string type for a service object of type '<setFPSAuto-request>"
  "ueyecam/setFPSAutoRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPSAuto-request)))
  "Returns string type for a service object of type 'setFPSAuto-request"
  "ueyecam/setFPSAutoRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setFPSAuto-request>)))
  "Returns md5sum for a message object of type '<setFPSAuto-request>"
  "ab88e3b58f1545cec00723d68863fabc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setFPSAuto-request)))
  "Returns md5sum for a message object of type 'setFPSAuto-request"
  "ab88e3b58f1545cec00723d68863fabc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setFPSAuto-request>)))
  "Returns full string definition for message of type '<setFPSAuto-request>"
  (cl:format cl:nil "bool autoFPSon~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setFPSAuto-request)))
  "Returns full string definition for message of type 'setFPSAuto-request"
  (cl:format cl:nil "bool autoFPSon~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setFPSAuto-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setFPSAuto-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setFPSAuto-request
    (cl:cons ':autoFPSon (autoFPSon msg))
))
;//! \htmlinclude setFPSAuto-response.msg.html

(cl:defclass <setFPSAuto-response> (roslisp-msg-protocol:ros-message)
  ((currentAutoFPs
    :reader currentAutoFPs
    :initarg :currentAutoFPs
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setFPSAuto-response (<setFPSAuto-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setFPSAuto-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setFPSAuto-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setFPSAuto-response> is deprecated: use ueyecam-srv:setFPSAuto-response instead.")))

(cl:ensure-generic-function 'currentAutoFPs-val :lambda-list '(m))
(cl:defmethod currentAutoFPs-val ((m <setFPSAuto-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:currentAutoFPs-val is deprecated.  Use ueyecam-srv:currentAutoFPs instead.")
  (currentAutoFPs m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setFPSAuto-response>) ostream)
  "Serializes a message object of type '<setFPSAuto-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'currentAutoFPs) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setFPSAuto-response>) istream)
  "Deserializes a message object of type '<setFPSAuto-response>"
    (cl:setf (cl:slot-value msg 'currentAutoFPs) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setFPSAuto-response>)))
  "Returns string type for a service object of type '<setFPSAuto-response>"
  "ueyecam/setFPSAutoResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPSAuto-response)))
  "Returns string type for a service object of type 'setFPSAuto-response"
  "ueyecam/setFPSAutoResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setFPSAuto-response>)))
  "Returns md5sum for a message object of type '<setFPSAuto-response>"
  "ab88e3b58f1545cec00723d68863fabc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setFPSAuto-response)))
  "Returns md5sum for a message object of type 'setFPSAuto-response"
  "ab88e3b58f1545cec00723d68863fabc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setFPSAuto-response>)))
  "Returns full string definition for message of type '<setFPSAuto-response>"
  (cl:format cl:nil "bool currentAutoFPs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setFPSAuto-response)))
  "Returns full string definition for message of type 'setFPSAuto-response"
  (cl:format cl:nil "bool currentAutoFPs~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setFPSAuto-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setFPSAuto-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setFPSAuto-response
    (cl:cons ':currentAutoFPs (currentAutoFPs msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setFPSAuto)))
  'setFPSAuto-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setFPSAuto)))
  'setFPSAuto-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setFPSAuto)))
  "Returns string type for a service object of type '<setFPSAuto>"
  "ueyecam/setFPSAuto")