; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setROI-request.msg.html

(cl:defclass <setROI-request> (roslisp-msg-protocol:ros-message)
  ((width
    :reader width
    :initarg :width
    :type cl:fixnum
    :initform 0)
   (height
    :reader height
    :initarg :height
    :type cl:fixnum
    :initform 0)
   (x_offset
    :reader x_offset
    :initarg :x_offset
    :type cl:fixnum
    :initform 0)
   (y_offset
    :reader y_offset
    :initarg :y_offset
    :type cl:fixnum
    :initform 0))
)

(cl:defclass setROI-request (<setROI-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setROI-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setROI-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setROI-request> is deprecated: use ueyecam-srv:setROI-request instead.")))

(cl:ensure-generic-function 'width-val :lambda-list '(m))
(cl:defmethod width-val ((m <setROI-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:width-val is deprecated.  Use ueyecam-srv:width instead.")
  (width m))

(cl:ensure-generic-function 'height-val :lambda-list '(m))
(cl:defmethod height-val ((m <setROI-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:height-val is deprecated.  Use ueyecam-srv:height instead.")
  (height m))

(cl:ensure-generic-function 'x_offset-val :lambda-list '(m))
(cl:defmethod x_offset-val ((m <setROI-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:x_offset-val is deprecated.  Use ueyecam-srv:x_offset instead.")
  (x_offset m))

(cl:ensure-generic-function 'y_offset-val :lambda-list '(m))
(cl:defmethod y_offset-val ((m <setROI-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:y_offset-val is deprecated.  Use ueyecam-srv:y_offset instead.")
  (y_offset m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setROI-request>) ostream)
  "Serializes a message object of type '<setROI-request>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'x_offset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'x_offset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'y_offset)) ostream)
  (cl:write-byte (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'y_offset)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setROI-request>) istream)
  "Deserializes a message object of type '<setROI-request>"
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'width)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'height)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'x_offset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'x_offset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 0) (cl:slot-value msg 'y_offset)) (cl:read-byte istream))
    (cl:setf (cl:ldb (cl:byte 8 8) (cl:slot-value msg 'y_offset)) (cl:read-byte istream))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setROI-request>)))
  "Returns string type for a service object of type '<setROI-request>"
  "ueyecam/setROIRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROI-request)))
  "Returns string type for a service object of type 'setROI-request"
  "ueyecam/setROIRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setROI-request>)))
  "Returns md5sum for a message object of type '<setROI-request>"
  "cf3c8c4ab295b27e17a9ef4348c69945")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setROI-request)))
  "Returns md5sum for a message object of type 'setROI-request"
  "cf3c8c4ab295b27e17a9ef4348c69945")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setROI-request>)))
  "Returns full string definition for message of type '<setROI-request>"
  (cl:format cl:nil "uint16 width~%uint16 height~%uint16 x_offset~%uint16 y_offset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setROI-request)))
  "Returns full string definition for message of type 'setROI-request"
  (cl:format cl:nil "uint16 width~%uint16 height~%uint16 x_offset~%uint16 y_offset~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setROI-request>))
  (cl:+ 0
     2
     2
     2
     2
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setROI-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setROI-request
    (cl:cons ':width (width msg))
    (cl:cons ':height (height msg))
    (cl:cons ':x_offset (x_offset msg))
    (cl:cons ':y_offset (y_offset msg))
))
;//! \htmlinclude setROI-response.msg.html

(cl:defclass <setROI-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass setROI-response (<setROI-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setROI-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setROI-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setROI-response> is deprecated: use ueyecam-srv:setROI-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setROI-response>) ostream)
  "Serializes a message object of type '<setROI-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setROI-response>) istream)
  "Deserializes a message object of type '<setROI-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setROI-response>)))
  "Returns string type for a service object of type '<setROI-response>"
  "ueyecam/setROIResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROI-response)))
  "Returns string type for a service object of type 'setROI-response"
  "ueyecam/setROIResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setROI-response>)))
  "Returns md5sum for a message object of type '<setROI-response>"
  "cf3c8c4ab295b27e17a9ef4348c69945")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setROI-response)))
  "Returns md5sum for a message object of type 'setROI-response"
  "cf3c8c4ab295b27e17a9ef4348c69945")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setROI-response>)))
  "Returns full string definition for message of type '<setROI-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setROI-response)))
  "Returns full string definition for message of type 'setROI-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setROI-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setROI-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setROI-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setROI)))
  'setROI-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setROI)))
  'setROI-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setROI)))
  "Returns string type for a service object of type '<setROI>"
  "ueyecam/setROI")