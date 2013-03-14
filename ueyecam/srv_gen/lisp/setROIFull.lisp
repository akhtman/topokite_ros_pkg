; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setROIFull-request.msg.html

(cl:defclass <setROIFull-request> (roslisp-msg-protocol:ros-message)
  ((fullON
    :reader fullON
    :initarg :fullON
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass setROIFull-request (<setROIFull-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setROIFull-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setROIFull-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setROIFull-request> is deprecated: use ueyecam-srv:setROIFull-request instead.")))

(cl:ensure-generic-function 'fullON-val :lambda-list '(m))
(cl:defmethod fullON-val ((m <setROIFull-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:fullON-val is deprecated.  Use ueyecam-srv:fullON instead.")
  (fullON m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setROIFull-request>) ostream)
  "Serializes a message object of type '<setROIFull-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'fullON) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setROIFull-request>) istream)
  "Deserializes a message object of type '<setROIFull-request>"
    (cl:setf (cl:slot-value msg 'fullON) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setROIFull-request>)))
  "Returns string type for a service object of type '<setROIFull-request>"
  "ueyecam/setROIFullRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROIFull-request)))
  "Returns string type for a service object of type 'setROIFull-request"
  "ueyecam/setROIFullRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setROIFull-request>)))
  "Returns md5sum for a message object of type '<setROIFull-request>"
  "16d2ed52ec05b432671f3d0db1025dd1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setROIFull-request)))
  "Returns md5sum for a message object of type 'setROIFull-request"
  "16d2ed52ec05b432671f3d0db1025dd1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setROIFull-request>)))
  "Returns full string definition for message of type '<setROIFull-request>"
  (cl:format cl:nil "bool fullON~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setROIFull-request)))
  "Returns full string definition for message of type 'setROIFull-request"
  (cl:format cl:nil "bool fullON~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setROIFull-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setROIFull-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setROIFull-request
    (cl:cons ':fullON (fullON msg))
))
;//! \htmlinclude setROIFull-response.msg.html

(cl:defclass <setROIFull-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass setROIFull-response (<setROIFull-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setROIFull-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setROIFull-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setROIFull-response> is deprecated: use ueyecam-srv:setROIFull-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setROIFull-response>) ostream)
  "Serializes a message object of type '<setROIFull-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setROIFull-response>) istream)
  "Deserializes a message object of type '<setROIFull-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setROIFull-response>)))
  "Returns string type for a service object of type '<setROIFull-response>"
  "ueyecam/setROIFullResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROIFull-response)))
  "Returns string type for a service object of type 'setROIFull-response"
  "ueyecam/setROIFullResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setROIFull-response>)))
  "Returns md5sum for a message object of type '<setROIFull-response>"
  "16d2ed52ec05b432671f3d0db1025dd1")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setROIFull-response)))
  "Returns md5sum for a message object of type 'setROIFull-response"
  "16d2ed52ec05b432671f3d0db1025dd1")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setROIFull-response>)))
  "Returns full string definition for message of type '<setROIFull-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setROIFull-response)))
  "Returns full string definition for message of type 'setROIFull-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setROIFull-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setROIFull-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setROIFull-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setROIFull)))
  'setROIFull-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setROIFull)))
  'setROIFull-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROIFull)))
  "Returns string type for a service object of type '<setROIFull>"
  "ueyecam/setROIFull")