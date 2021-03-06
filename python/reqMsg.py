#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'reqMsg'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 2

# The Active Message type associated with this message.
AM_TYPE = 7

class reqMsg(tinyos.message.Message.Message):
    # Create a new reqMsg of size 2.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=2):
        tinyos.message.Message.Message.__init__(self, data, addr, gid, base_offset, data_length)
        self.amTypeSet(AM_TYPE)
    
    # Get AM_TYPE
    def get_amType(cls):
        return AM_TYPE
    
    get_amType = classmethod(get_amType)
    
    #
    # Return a String representation of this message. Includes the
    # message type name and the non-indexed field values.
    #
    def __str__(self):
        s = "Message <reqMsg> \n"
        try:
            s += "  [reqNod=0x%x]\n" % (self.get_reqNod())
        except:
            pass
        try:
            s += "  [valsWanted=0x%x]\n" % (self.get_valsWanted())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: reqNod
    #   Field type: short
    #   Offset (bits): 0
    #   Size (bits): 8
    #

    #
    # Return whether the field 'reqNod' is signed (False).
    #
    def isSigned_reqNod(self):
        return False
    
    #
    # Return whether the field 'reqNod' is an array (False).
    #
    def isArray_reqNod(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'reqNod'
    #
    def offset_reqNod(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'reqNod'
    #
    def offsetBits_reqNod(self):
        return 0
    
    #
    # Return the value (as a short) of the field 'reqNod'
    #
    def get_reqNod(self):
        return self.getUIntElement(self.offsetBits_reqNod(), 8, 1)
    
    #
    # Set the value of the field 'reqNod'
    #
    def set_reqNod(self, value):
        self.setUIntElement(self.offsetBits_reqNod(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'reqNod'
    #
    def size_reqNod(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'reqNod'
    #
    def sizeBits_reqNod(self):
        return 8
    
    #
    # Accessor methods for field: valsWanted
    #   Field type: short
    #   Offset (bits): 8
    #   Size (bits): 8
    #

    #
    # Return whether the field 'valsWanted' is signed (False).
    #
    def isSigned_valsWanted(self):
        return False
    
    #
    # Return whether the field 'valsWanted' is an array (False).
    #
    def isArray_valsWanted(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'valsWanted'
    #
    def offset_valsWanted(self):
        return (8 / 8)
    
    #
    # Return the offset (in bits) of the field 'valsWanted'
    #
    def offsetBits_valsWanted(self):
        return 8
    
    #
    # Return the value (as a short) of the field 'valsWanted'
    #
    def get_valsWanted(self):
        return self.getUIntElement(self.offsetBits_valsWanted(), 8, 1)
    
    #
    # Set the value of the field 'valsWanted'
    #
    def set_valsWanted(self, value):
        self.setUIntElement(self.offsetBits_valsWanted(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'valsWanted'
    #
    def size_valsWanted(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'valsWanted'
    #
    def sizeBits_valsWanted(self):
        return 8
    
