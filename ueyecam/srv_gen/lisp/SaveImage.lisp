; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude SaveImage-request.msg.html

(cl:defclass <SaveImage-request> (roslisp-msg-protocol:ros-message)
  ((filename
    :reader filename
    :initarg :filename
    :type cl:string
    :initform ""))
)

(cl:defclass SaveImage-request (<SaveImage-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveImage-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveImage-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<SaveImage-request> is deprecated: use ueyecam-srv:SaveImage-request instead.")))

(cl:ensure-generic-function 'filename-val :lambda-list '(m))
(cl:defmethod filename-val ((m <SaveImage-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:filename-val is deprecated.  Use ueyecam-srv:filename instead.")
  (filename m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveImage-request>) ostream)
  "Serializes a message object of type '<SaveImage-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'filename))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'filename))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveImage-request>) istream)
  "Deserializes a message object of type '<SaveImage-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'filename) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'filename) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveImage-request>)))
  "Returns string type for a service object of type '<SaveImage-request>"
  "ueyecam/SaveImageRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveImage-request)))
  "Returns string type for a service object of type 'SaveImage-request"
  "ueyecam/SaveImageRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveImage-request>)))
  "Returns md5sum for a message object of type '<SaveImage-request>"
  "93a4bc4c60dc17e2a69e3fcaaa25d69d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveImage-request)))
  "Returns md5sum for a message object of type 'SaveImage-request"
  "93a4bc4c60dc17e2a69e3fcaaa25d69d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveImage-request>)))
  "Returns full string definition for message of type '<SaveImage-request>"
  (cl:format cl:nil "string filename~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveImage-request)))
  "Returns full string definition for message of type 'SaveImage-request"
  (cl:format cl:nil "string filename~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveImage-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'filename))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveImage-request>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveImage-request
    (cl:cons ':filename (filename msg))
))
;//! \htmlinclude SaveImage-response.msg.html

(cl:defclass <SaveImage-response> (roslisp-msg-protocol:ros-message)
  ((success
    :reader success
    :initarg :success
    :type cl:boolean
    :initform cl:nil))
)

(cl:defclass SaveImage-response (<SaveImage-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <SaveImage-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'SaveImage-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<SaveImage-response> is deprecated: use ueyecam-srv:SaveImage-response instead.")))

(cl:ensure-generic-function 'success-val :lambda-list '(m))
(cl:defmethod success-val ((m <SaveImage-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:success-val is deprecated.  Use ueyecam-srv:success instead.")
  (success m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <SaveImage-response>) ostream)
  "Serializes a message object of type '<SaveImage-response>"
  (cl:write-byte (cl:ldb (cl:byte 8 0) (cl:if (cl:slot-value msg 'success) 1 0)) ostream)
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <SaveImage-response>) istream)
  "Deserializes a message object of type '<SaveImage-response>"
    (cl:setf (cl:slot-value msg 'success) (cl:not (cl:zerop (cl:read-byte istream))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<SaveImage-response>)))
  "Returns string type for a service object of type '<SaveImage-response>"
  "ueyecam/SaveImageResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveImage-response)))
  "Returns string type for a service object of type 'SaveImage-response"
  "ueyecam/SaveImageResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<SaveImage-response>)))
  "Returns md5sum for a message object of type '<SaveImage-response>"
  "93a4bc4c60dc17e2a69e3fcaaa25d69d")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'SaveImage-response)))
  "Returns md5sum for a message object of type 'SaveImage-response"
  "93a4bc4c60dc17e2a69e3fcaaa25d69d")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<SaveImage-response>)))
  "Returns full string definition for message of type '<SaveImage-response>"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'SaveImage-response)))
  "Returns full string definition for message of type 'SaveImage-response"
  (cl:format cl:nil "bool success~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <SaveImage-response>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <SaveImage-response>))
  "Converts a ROS message object to a list"
  (cl:list 'SaveImage-response
    (cl:cons ':success (success msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'SaveImage)))
  'SaveImage-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'SaveImage)))
  'SaveImage-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'SaveImage)))
  "Returns string type for a service object of type '<SaveImage>"
  "ueyecam/SaveImage")