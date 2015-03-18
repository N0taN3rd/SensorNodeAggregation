#
# This class is automatically generated by mig. DO NOT EDIT THIS FILE.
# This class implements a Python interface to the 'sensMsg'
# message type.
#

import tinyos.message.Message

# The default size of this message type in bytes.
DEFAULT_MESSAGE_SIZE = 18

# The Active Message type associated with this message.
AM_TYPE = 6

class sensMsg(tinyos.message.Message.Message):
    # Create a new sensMsg of size 18.
    def __init__(self, data="", addr=None, gid=None, base_offset=0, data_length=18):
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
        s = "Message <sensMsg> \n"
        try:
            s += "  [rawT=0x%x]\n" % (self.get_rawT())
        except:
            pass
        try:
            s += "  [rawL=0x%x]\n" % (self.get_rawL())
        except:
            pass
        try:
            s += "  [tVal=0x%x]\n" % (self.get_tVal())
        except:
            pass
        try:
            s += "  [lVal=0x%x]\n" % (self.get_lVal())
        except:
            pass
        try:
            s += "  [msgNum=0x%x]\n" % (self.get_msgNum())
        except:
            pass
        try:
            s += "  [tStamp=0x%x]\n" % (self.get_tStamp())
        except:
            pass
        try:
            s += "  [nId=0x%x]\n" % (self.get_nId())
        except:
            pass
        try:
            s += "  [vals=0x%x]\n" % (self.get_vals())
        except:
            pass
        try:
            s += "  [tErr=0x%x]\n" % (self.get_tErr())
        except:
            pass
        try:
            s += "  [lErr=0x%x]\n" % (self.get_lErr())
        except:
            pass
        return s

    # Message-type-specific access methods appear below.

    #
    # Accessor methods for field: rawT
    #   Field type: int
    #   Offset (bits): 0
    #   Size (bits): 16
    #

    #
    # Return whether the field 'rawT' is signed (False).
    #
    def isSigned_rawT(self):
        return False
    
    #
    # Return whether the field 'rawT' is an array (False).
    #
    def isArray_rawT(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'rawT'
    #
    def offset_rawT(self):
        return (0 / 8)
    
    #
    # Return the offset (in bits) of the field 'rawT'
    #
    def offsetBits_rawT(self):
        return 0
    
    #
    # Return the value (as a int) of the field 'rawT'
    #
    def get_rawT(self):
        return self.getUIntElement(self.offsetBits_rawT(), 16, 1)
    
    #
    # Set the value of the field 'rawT'
    #
    def set_rawT(self, value):
        self.setUIntElement(self.offsetBits_rawT(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'rawT'
    #
    def size_rawT(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'rawT'
    #
    def sizeBits_rawT(self):
        return 16
    
    #
    # Accessor methods for field: rawL
    #   Field type: int
    #   Offset (bits): 16
    #   Size (bits): 16
    #

    #
    # Return whether the field 'rawL' is signed (False).
    #
    def isSigned_rawL(self):
        return False
    
    #
    # Return whether the field 'rawL' is an array (False).
    #
    def isArray_rawL(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'rawL'
    #
    def offset_rawL(self):
        return (16 / 8)
    
    #
    # Return the offset (in bits) of the field 'rawL'
    #
    def offsetBits_rawL(self):
        return 16
    
    #
    # Return the value (as a int) of the field 'rawL'
    #
    def get_rawL(self):
        return self.getUIntElement(self.offsetBits_rawL(), 16, 1)
    
    #
    # Set the value of the field 'rawL'
    #
    def set_rawL(self, value):
        self.setUIntElement(self.offsetBits_rawL(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'rawL'
    #
    def size_rawL(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'rawL'
    #
    def sizeBits_rawL(self):
        return 16
    
    #
    # Accessor methods for field: tVal
    #   Field type: int
    #   Offset (bits): 32
    #   Size (bits): 16
    #

    #
    # Return whether the field 'tVal' is signed (False).
    #
    def isSigned_tVal(self):
        return False
    
    #
    # Return whether the field 'tVal' is an array (False).
    #
    def isArray_tVal(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'tVal'
    #
    def offset_tVal(self):
        return (32 / 8)
    
    #
    # Return the offset (in bits) of the field 'tVal'
    #
    def offsetBits_tVal(self):
        return 32
    
    #
    # Return the value (as a int) of the field 'tVal'
    #
    def get_tVal(self):
        return self.getUIntElement(self.offsetBits_tVal(), 16, 1)
    
    #
    # Set the value of the field 'tVal'
    #
    def set_tVal(self, value):
        self.setUIntElement(self.offsetBits_tVal(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'tVal'
    #
    def size_tVal(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'tVal'
    #
    def sizeBits_tVal(self):
        return 16
    
    #
    # Accessor methods for field: lVal
    #   Field type: int
    #   Offset (bits): 48
    #   Size (bits): 16
    #

    #
    # Return whether the field 'lVal' is signed (False).
    #
    def isSigned_lVal(self):
        return False
    
    #
    # Return whether the field 'lVal' is an array (False).
    #
    def isArray_lVal(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'lVal'
    #
    def offset_lVal(self):
        return (48 / 8)
    
    #
    # Return the offset (in bits) of the field 'lVal'
    #
    def offsetBits_lVal(self):
        return 48
    
    #
    # Return the value (as a int) of the field 'lVal'
    #
    def get_lVal(self):
        return self.getUIntElement(self.offsetBits_lVal(), 16, 1)
    
    #
    # Set the value of the field 'lVal'
    #
    def set_lVal(self, value):
        self.setUIntElement(self.offsetBits_lVal(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'lVal'
    #
    def size_lVal(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'lVal'
    #
    def sizeBits_lVal(self):
        return 16
    
    #
    # Accessor methods for field: msgNum
    #   Field type: int
    #   Offset (bits): 64
    #   Size (bits): 16
    #

    #
    # Return whether the field 'msgNum' is signed (False).
    #
    def isSigned_msgNum(self):
        return False
    
    #
    # Return whether the field 'msgNum' is an array (False).
    #
    def isArray_msgNum(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'msgNum'
    #
    def offset_msgNum(self):
        return (64 / 8)
    
    #
    # Return the offset (in bits) of the field 'msgNum'
    #
    def offsetBits_msgNum(self):
        return 64
    
    #
    # Return the value (as a int) of the field 'msgNum'
    #
    def get_msgNum(self):
        return self.getUIntElement(self.offsetBits_msgNum(), 16, 1)
    
    #
    # Set the value of the field 'msgNum'
    #
    def set_msgNum(self, value):
        self.setUIntElement(self.offsetBits_msgNum(), 16, value, 1)
    
    #
    # Return the size, in bytes, of the field 'msgNum'
    #
    def size_msgNum(self):
        return (16 / 8)
    
    #
    # Return the size, in bits, of the field 'msgNum'
    #
    def sizeBits_msgNum(self):
        return 16
    
    #
    # Accessor methods for field: tStamp
    #   Field type: long
    #   Offset (bits): 80
    #   Size (bits): 32
    #

    #
    # Return whether the field 'tStamp' is signed (False).
    #
    def isSigned_tStamp(self):
        return False
    
    #
    # Return whether the field 'tStamp' is an array (False).
    #
    def isArray_tStamp(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'tStamp'
    #
    def offset_tStamp(self):
        return (80 / 8)
    
    #
    # Return the offset (in bits) of the field 'tStamp'
    #
    def offsetBits_tStamp(self):
        return 80
    
    #
    # Return the value (as a long) of the field 'tStamp'
    #
    def get_tStamp(self):
        return self.getUIntElement(self.offsetBits_tStamp(), 32, 1)
    
    #
    # Set the value of the field 'tStamp'
    #
    def set_tStamp(self, value):
        self.setUIntElement(self.offsetBits_tStamp(), 32, value, 1)
    
    #
    # Return the size, in bytes, of the field 'tStamp'
    #
    def size_tStamp(self):
        return (32 / 8)
    
    #
    # Return the size, in bits, of the field 'tStamp'
    #
    def sizeBits_tStamp(self):
        return 32
    
    #
    # Accessor methods for field: nId
    #   Field type: short
    #   Offset (bits): 112
    #   Size (bits): 8
    #

    #
    # Return whether the field 'nId' is signed (False).
    #
    def isSigned_nId(self):
        return False
    
    #
    # Return whether the field 'nId' is an array (False).
    #
    def isArray_nId(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'nId'
    #
    def offset_nId(self):
        return (112 / 8)
    
    #
    # Return the offset (in bits) of the field 'nId'
    #
    def offsetBits_nId(self):
        return 112
    
    #
    # Return the value (as a short) of the field 'nId'
    #
    def get_nId(self):
        return self.getUIntElement(self.offsetBits_nId(), 8, 1)
    
    #
    # Set the value of the field 'nId'
    #
    def set_nId(self, value):
        self.setUIntElement(self.offsetBits_nId(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'nId'
    #
    def size_nId(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'nId'
    #
    def sizeBits_nId(self):
        return 8
    
    #
    # Accessor methods for field: vals
    #   Field type: short
    #   Offset (bits): 120
    #   Size (bits): 8
    #

    #
    # Return whether the field 'vals' is signed (False).
    #
    def isSigned_vals(self):
        return False
    
    #
    # Return whether the field 'vals' is an array (False).
    #
    def isArray_vals(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'vals'
    #
    def offset_vals(self):
        return (120 / 8)
    
    #
    # Return the offset (in bits) of the field 'vals'
    #
    def offsetBits_vals(self):
        return 120
    
    #
    # Return the value (as a short) of the field 'vals'
    #
    def get_vals(self):
        return self.getUIntElement(self.offsetBits_vals(), 8, 1)
    
    #
    # Set the value of the field 'vals'
    #
    def set_vals(self, value):
        self.setUIntElement(self.offsetBits_vals(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'vals'
    #
    def size_vals(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'vals'
    #
    def sizeBits_vals(self):
        return 8
    
    #
    # Accessor methods for field: tErr
    #   Field type: short
    #   Offset (bits): 128
    #   Size (bits): 8
    #

    #
    # Return whether the field 'tErr' is signed (False).
    #
    def isSigned_tErr(self):
        return False
    
    #
    # Return whether the field 'tErr' is an array (False).
    #
    def isArray_tErr(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'tErr'
    #
    def offset_tErr(self):
        return (128 / 8)
    
    #
    # Return the offset (in bits) of the field 'tErr'
    #
    def offsetBits_tErr(self):
        return 128
    
    #
    # Return the value (as a short) of the field 'tErr'
    #
    def get_tErr(self):
        return self.getUIntElement(self.offsetBits_tErr(), 8, 1)
    
    #
    # Set the value of the field 'tErr'
    #
    def set_tErr(self, value):
        self.setUIntElement(self.offsetBits_tErr(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'tErr'
    #
    def size_tErr(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'tErr'
    #
    def sizeBits_tErr(self):
        return 8
    
    #
    # Accessor methods for field: lErr
    #   Field type: short
    #   Offset (bits): 136
    #   Size (bits): 8
    #

    #
    # Return whether the field 'lErr' is signed (False).
    #
    def isSigned_lErr(self):
        return False
    
    #
    # Return whether the field 'lErr' is an array (False).
    #
    def isArray_lErr(self):
        return False
    
    #
    # Return the offset (in bytes) of the field 'lErr'
    #
    def offset_lErr(self):
        return (136 / 8)
    
    #
    # Return the offset (in bits) of the field 'lErr'
    #
    def offsetBits_lErr(self):
        return 136
    
    #
    # Return the value (as a short) of the field 'lErr'
    #
    def get_lErr(self):
        return self.getUIntElement(self.offsetBits_lErr(), 8, 1)
    
    #
    # Set the value of the field 'lErr'
    #
    def set_lErr(self, value):
        self.setUIntElement(self.offsetBits_lErr(), 8, value, 1)
    
    #
    # Return the size, in bytes, of the field 'lErr'
    #
    def size_lErr(self):
        return (8 / 8)
    
    #
    # Return the size, in bits, of the field 'lErr'
    #
    def sizeBits_lErr(self):
        return 8
    
