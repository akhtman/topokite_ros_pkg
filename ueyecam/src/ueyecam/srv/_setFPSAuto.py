"""autogenerated by genmsg_py from setFPSAutoRequest.msg. Do not edit."""
import roslib.message
import struct


class setFPSAutoRequest(roslib.message.Message):
  _md5sum = "03872f67e53d848c313b3bbf1e74456b"
  _type = "ueyecam/setFPSAutoRequest"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """bool autoFPSon

"""
  __slots__ = ['autoFPSon']
  _slot_types = ['bool']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.
    
    The available fields are:
       autoFPSon
    
    @param args: complete set of field values, in .msg order
    @param kwds: use keyword arguments corresponding to message field names
    to set specific fields. 
    """
    if args or kwds:
      super(setFPSAutoRequest, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.autoFPSon is None:
        self.autoFPSon = False
    else:
      self.autoFPSon = False

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    @param buff: buffer
    @type  buff: StringIO
    """
    try:
      buff.write(_struct_B.pack(self.autoFPSon))
    except struct.error as se: self._check_types(se)
    except TypeError as te: self._check_types(te)

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    @param str: byte array of serialized message
    @type  str: str
    """
    try:
      end = 0
      start = end
      end += 1
      (self.autoFPSon,) = _struct_B.unpack(str[start:end])
      self.autoFPSon = bool(self.autoFPSon)
      return self
    except struct.error as e:
      raise roslib.message.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    @param buff: buffer
    @type  buff: StringIO
    @param numpy: numpy python module
    @type  numpy module
    """
    try:
      buff.write(_struct_B.pack(self.autoFPSon))
    except struct.error as se: self._check_types(se)
    except TypeError as te: self._check_types(te)

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    @param str: byte array of serialized message
    @type  str: str
    @param numpy: numpy python module
    @type  numpy: module
    """
    try:
      end = 0
      start = end
      end += 1
      (self.autoFPSon,) = _struct_B.unpack(str[start:end])
      self.autoFPSon = bool(self.autoFPSon)
      return self
    except struct.error as e:
      raise roslib.message.DeserializationError(e) #most likely buffer underfill

_struct_I = roslib.message.struct_I
_struct_B = struct.Struct("<B")
"""autogenerated by genmsg_py from setFPSAutoResponse.msg. Do not edit."""
import roslib.message
import struct


class setFPSAutoResponse(roslib.message.Message):
  _md5sum = "eaa2f38600b4bb1de5828d459d0a7a3a"
  _type = "ueyecam/setFPSAutoResponse"
  _has_header = False #flag to mark the presence of a Header object
  _full_text = """bool currentAutoFPs

"""
  __slots__ = ['currentAutoFPs']
  _slot_types = ['bool']

  def __init__(self, *args, **kwds):
    """
    Constructor. Any message fields that are implicitly/explicitly
    set to None will be assigned a default value. The recommend
    use is keyword arguments as this is more robust to future message
    changes.  You cannot mix in-order arguments and keyword arguments.
    
    The available fields are:
       currentAutoFPs
    
    @param args: complete set of field values, in .msg order
    @param kwds: use keyword arguments corresponding to message field names
    to set specific fields. 
    """
    if args or kwds:
      super(setFPSAutoResponse, self).__init__(*args, **kwds)
      #message fields cannot be None, assign default values for those that are
      if self.currentAutoFPs is None:
        self.currentAutoFPs = False
    else:
      self.currentAutoFPs = False

  def _get_types(self):
    """
    internal API method
    """
    return self._slot_types

  def serialize(self, buff):
    """
    serialize message into buffer
    @param buff: buffer
    @type  buff: StringIO
    """
    try:
      buff.write(_struct_B.pack(self.currentAutoFPs))
    except struct.error as se: self._check_types(se)
    except TypeError as te: self._check_types(te)

  def deserialize(self, str):
    """
    unpack serialized message in str into this message instance
    @param str: byte array of serialized message
    @type  str: str
    """
    try:
      end = 0
      start = end
      end += 1
      (self.currentAutoFPs,) = _struct_B.unpack(str[start:end])
      self.currentAutoFPs = bool(self.currentAutoFPs)
      return self
    except struct.error as e:
      raise roslib.message.DeserializationError(e) #most likely buffer underfill


  def serialize_numpy(self, buff, numpy):
    """
    serialize message with numpy array types into buffer
    @param buff: buffer
    @type  buff: StringIO
    @param numpy: numpy python module
    @type  numpy module
    """
    try:
      buff.write(_struct_B.pack(self.currentAutoFPs))
    except struct.error as se: self._check_types(se)
    except TypeError as te: self._check_types(te)

  def deserialize_numpy(self, str, numpy):
    """
    unpack serialized message in str into this message instance using numpy for array types
    @param str: byte array of serialized message
    @type  str: str
    @param numpy: numpy python module
    @type  numpy: module
    """
    try:
      end = 0
      start = end
      end += 1
      (self.currentAutoFPs,) = _struct_B.unpack(str[start:end])
      self.currentAutoFPs = bool(self.currentAutoFPs)
      return self
    except struct.error as e:
      raise roslib.message.DeserializationError(e) #most likely buffer underfill

_struct_I = roslib.message.struct_I
_struct_B = struct.Struct("<B")
class setFPSAuto(roslib.message.ServiceDefinition):
  _type          = 'ueyecam/setFPSAuto'
  _md5sum = 'ab88e3b58f1545cec00723d68863fabc'
  _request_class  = setFPSAutoRequest
  _response_class = setFPSAutoResponse