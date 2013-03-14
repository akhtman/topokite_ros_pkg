; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setEncoding-request.msg.html

(cl:defclass <setEncoding-request> (roslisp-msg-protocol:ros-message)
  ((encoding
    :reader encoding
    :initarg :encoding
    :type cl:string
    :initform ""))
)

(cl:defclass setEncoding-request (<setEncoding-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setEncoding-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setEncoding-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setEncoding-request> is deprecated: use ueyecam-srv:setEncoding-request instead.")))

(cl:ensure-generic-function 'encoding-val :lambda-list '(m))
(cl:defmethod encoding-val ((m <setEncoding-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:encoding-val is deprecated.  Use ueyecam-srv:encoding instead.")
  (encoding m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setEncoding-request>) ostream)
  "Serializes a message object of type '<setEncoding-request>"
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'encoding))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'encoding))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setEncoding-request>) istream)
  "Deserializes a message object of type '<setEncoding-request>"
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'encoding) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'encoding) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setEncoding-request>)))
  "Returns string type for a service object of type '<setEncoding-request>"
  "ueyecam/setEncodingRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEncoding-request)))
  "Returns string type for a service object of type 'setEncoding-request"
  "ueyecam/setEncodingRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setEncoding-request>)))
  "Returns md5sum for a message object of type '<setEncoding-request>"
  "fe0aa0e3bb3f44bd4e5c8adc26ab7fcc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setEncoding-request)))
  "Returns md5sum for a message object of type 'setEncoding-request"
  "fe0aa0e3bb3f44bd4e5c8adc26ab7fcc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setEncoding-request>)))
  "Returns full string definition for message of type '<setEncoding-request>"
  (cl:format cl:nil "string encoding~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setEncoding-request)))
  "Returns full string definition for message of type 'setEncoding-request"
  (cl:format cl:nil "string encoding~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setEncoding-request>))
  (cl:+ 0
     4 (cl:length (cl:slot-value msg 'encoding))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setEncoding-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setEncoding-request
    (cl:cons ':encoding (encoding msg))
))
;//! \htmlinclude setEncoding-response.msg.html

(cl:defclass <setEncoding-response> (roslisp-msg-protocol:ros-message)
  ()
)

(cl:defclass setEncoding-response (<setEncoding-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setEncoding-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setEncoding-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setEncoding-response> is deprecated: use ueyecam-srv:setEncoding-response instead.")))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setEncoding-response>) ostream)
  "Serializes a message object of type '<setEncoding-response>"
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setEncoding-response>) istream)
  "Deserializes a message object of type '<setEncoding-response>"
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setEncoding-response>)))
  "Returns string type for a service object of type '<setEncoding-response>"
  "ueyecam/setEncodingResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEncoding-response)))
  "Returns string type for a service object of type 'setEncoding-response"
  "ueyecam/setEncodingResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setEncoding-response>)))
  "Returns md5sum for a message object of type '<setEncoding-response>"
  "fe0aa0e3bb3f44bd4e5c8adc26ab7fcc")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setEncoding-response)))
  "Returns md5sum for a message object of type 'setEncoding-response"
  "fe0aa0e3bb3f44bd4e5c8adc26ab7fcc")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setEncoding-response>)))
  "Returns full string definition for message of type '<setEncoding-response>"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setEncoding-response)))
  "Returns full string definition for message of type 'setEncoding-response"
  (cl:format cl:nil "~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setEncoding-response>))
  (cl:+ 0
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setEncoding-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setEncoding-response
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setEncoding)))
  'setEncoding-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setEncoding)))
  'setEncoding-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEncoding)))
  "Returns string type for a service object of type '<setEncoding>"
  "ueyecam/setEncoding")