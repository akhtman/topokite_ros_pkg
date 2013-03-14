; Auto-generated. Do not edit!


(cl:in-package ueyecam-srv)


;//! \htmlinclude setEdgeEnhancement-request.msg.html

(cl:defclass <setEdgeEnhancement-request> (roslisp-msg-protocol:ros-message)
  ((edgeEnhancementSet
    :reader edgeEnhancementSet
    :initarg :edgeEnhancementSet
    :type cl:fixnum
    :initform 0))
)

(cl:defclass setEdgeEnhancement-request (<setEdgeEnhancement-request>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setEdgeEnhancement-request>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setEdgeEnhancement-request)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setEdgeEnhancement-request> is deprecated: use ueyecam-srv:setEdgeEnhancement-request instead.")))

(cl:ensure-generic-function 'edgeEnhancementSet-val :lambda-list '(m))
(cl:defmethod edgeEnhancementSet-val ((m <setEdgeEnhancement-request>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:edgeEnhancementSet-val is deprecated.  Use ueyecam-srv:edgeEnhancementSet instead.")
  (edgeEnhancementSet m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setEdgeEnhancement-request>) ostream)
  "Serializes a message object of type '<setEdgeEnhancement-request>"
  (cl:let* ((signed (cl:slot-value msg 'edgeEnhancementSet)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setEdgeEnhancement-request>) istream)
  "Deserializes a message object of type '<setEdgeEnhancement-request>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edgeEnhancementSet) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setEdgeEnhancement-request>)))
  "Returns string type for a service object of type '<setEdgeEnhancement-request>"
  "ueyecam/setEdgeEnhancementRequest")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEdgeEnhancement-request)))
  "Returns string type for a service object of type 'setEdgeEnhancement-request"
  "ueyecam/setEdgeEnhancementRequest")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setEdgeEnhancement-request>)))
  "Returns md5sum for a message object of type '<setEdgeEnhancement-request>"
  "6c12de1e51a773b0295489ad2b111707")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setEdgeEnhancement-request)))
  "Returns md5sum for a message object of type 'setEdgeEnhancement-request"
  "6c12de1e51a773b0295489ad2b111707")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setEdgeEnhancement-request>)))
  "Returns full string definition for message of type '<setEdgeEnhancement-request>"
  (cl:format cl:nil "int8 edgeEnhancementSet~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setEdgeEnhancement-request)))
  "Returns full string definition for message of type 'setEdgeEnhancement-request"
  (cl:format cl:nil "int8 edgeEnhancementSet~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setEdgeEnhancement-request>))
  (cl:+ 0
     1
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setEdgeEnhancement-request>))
  "Converts a ROS message object to a list"
  (cl:list 'setEdgeEnhancement-request
    (cl:cons ':edgeEnhancementSet (edgeEnhancementSet msg))
))
;//! \htmlinclude setEdgeEnhancement-response.msg.html

(cl:defclass <setEdgeEnhancement-response> (roslisp-msg-protocol:ros-message)
  ((edgeEnhancementGet
    :reader edgeEnhancementGet
    :initarg :edgeEnhancementGet
    :type cl:fixnum
    :initform 0)
   (edgeEnhancementGetString
    :reader edgeEnhancementGetString
    :initarg :edgeEnhancementGetString
    :type cl:string
    :initform ""))
)

(cl:defclass setEdgeEnhancement-response (<setEdgeEnhancement-response>)
  ())

(cl:defmethod cl:initialize-instance :after ((m <setEdgeEnhancement-response>) cl:&rest args)
  (cl:declare (cl:ignorable args))
  (cl:unless (cl:typep m 'setEdgeEnhancement-response)
    (roslisp-msg-protocol:msg-deprecation-warning "using old message class name ueyecam-srv:<setEdgeEnhancement-response> is deprecated: use ueyecam-srv:setEdgeEnhancement-response instead.")))

(cl:ensure-generic-function 'edgeEnhancementGet-val :lambda-list '(m))
(cl:defmethod edgeEnhancementGet-val ((m <setEdgeEnhancement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:edgeEnhancementGet-val is deprecated.  Use ueyecam-srv:edgeEnhancementGet instead.")
  (edgeEnhancementGet m))

(cl:ensure-generic-function 'edgeEnhancementGetString-val :lambda-list '(m))
(cl:defmethod edgeEnhancementGetString-val ((m <setEdgeEnhancement-response>))
  (roslisp-msg-protocol:msg-deprecation-warning "Using old-style slot reader ueyecam-srv:edgeEnhancementGetString-val is deprecated.  Use ueyecam-srv:edgeEnhancementGetString instead.")
  (edgeEnhancementGetString m))
(cl:defmethod roslisp-msg-protocol:serialize ((msg <setEdgeEnhancement-response>) ostream)
  "Serializes a message object of type '<setEdgeEnhancement-response>"
  (cl:let* ((signed (cl:slot-value msg 'edgeEnhancementGet)) (unsigned (cl:if (cl:< signed 0) (cl:+ signed 256) signed)))
    (cl:write-byte (cl:ldb (cl:byte 8 0) unsigned) ostream)
    )
  (cl:let ((__ros_str_len (cl:length (cl:slot-value msg 'edgeEnhancementGetString))))
    (cl:write-byte (cl:ldb (cl:byte 8 0) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 8) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 16) __ros_str_len) ostream)
    (cl:write-byte (cl:ldb (cl:byte 8 24) __ros_str_len) ostream))
  (cl:map cl:nil #'(cl:lambda (c) (cl:write-byte (cl:char-code c) ostream)) (cl:slot-value msg 'edgeEnhancementGetString))
)
(cl:defmethod roslisp-msg-protocol:deserialize ((msg <setEdgeEnhancement-response>) istream)
  "Deserializes a message object of type '<setEdgeEnhancement-response>"
    (cl:let ((unsigned 0))
      (cl:setf (cl:ldb (cl:byte 8 0) unsigned) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edgeEnhancementGet) (cl:if (cl:< unsigned 128) unsigned (cl:- unsigned 256))))
    (cl:let ((__ros_str_len 0))
      (cl:setf (cl:ldb (cl:byte 8 0) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 8) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 16) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:ldb (cl:byte 8 24) __ros_str_len) (cl:read-byte istream))
      (cl:setf (cl:slot-value msg 'edgeEnhancementGetString) (cl:make-string __ros_str_len))
      (cl:dotimes (__ros_str_idx __ros_str_len msg)
        (cl:setf (cl:char (cl:slot-value msg 'edgeEnhancementGetString) __ros_str_idx) (cl:code-char (cl:read-byte istream)))))
  msg
)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql '<setEdgeEnhancement-response>)))
  "Returns string type for a service object of type '<setEdgeEnhancement-response>"
  "ueyecam/setEdgeEnhancementResponse")
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEdgeEnhancement-response)))
  "Returns string type for a service object of type 'setEdgeEnhancement-response"
  "ueyecam/setEdgeEnhancementResponse")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql '<setEdgeEnhancement-response>)))
  "Returns md5sum for a message object of type '<setEdgeEnhancement-response>"
  "6c12de1e51a773b0295489ad2b111707")
(cl:defmethod roslisp-msg-protocol:md5sum ((type (cl:eql 'setEdgeEnhancement-response)))
  "Returns md5sum for a message object of type 'setEdgeEnhancement-response"
  "6c12de1e51a773b0295489ad2b111707")
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql '<setEdgeEnhancement-response>)))
  "Returns full string definition for message of type '<setEdgeEnhancement-response>"
  (cl:format cl:nil "int8 edgeEnhancementGet~%string edgeEnhancementGetString~%~%~%"))
(cl:defmethod roslisp-msg-protocol:message-definition ((type (cl:eql 'setEdgeEnhancement-response)))
  "Returns full string definition for message of type 'setEdgeEnhancement-response"
  (cl:format cl:nil "int8 edgeEnhancementGet~%string edgeEnhancementGetString~%~%~%"))
(cl:defmethod roslisp-msg-protocol:serialization-length ((msg <setEdgeEnhancement-response>))
  (cl:+ 0
     1
     4 (cl:length (cl:slot-value msg 'edgeEnhancementGetString))
))
(cl:defmethod roslisp-msg-protocol:ros-message-to-list ((msg <setEdgeEnhancement-response>))
  "Converts a ROS message object to a list"
  (cl:list 'setEdgeEnhancement-response
    (cl:cons ':edgeEnhancementGet (edgeEnhancementGet msg))
    (cl:cons ':edgeEnhancementGetString (edgeEnhancementGetString msg))
))
(cl:defmethod roslisp-msg-protocol:service-request-type ((msg (cl:eql 'setEdgeEnhancement)))
  'setEdgeEnhancement-request)
(cl:defmethod roslisp-msg-protocol:service-response-type ((msg (cl:eql 'setEdgeEnhancement)))
  'setEdgeEnhancement-response)
(cl:defmethod roslisp-msg-protocol:ros-datatype ((msg (cl:eql 'setEdgeEnhancement)))
  "Returns string type for a service object of type '<setEdgeEnhancement>"
  "ueyecam/setEdgeEnhancement")