COMPONENT=SenseNodeAppC
CFLAGS += -I$(TINYOS_OS_DIR)/lib/printf
CFLAGS += -DNEW_PRINTF_SEMANTICS
CFLAGS += -DTH_THRESH=5
CFLAGS += -DTL_THRESH=0
CFLAGS += -DLH_THRESH=250
CFLAGS += -DLL_THRESH=0
PFLAGS += -I%T/sensorboards/mda100/cb
	
TINYOS_ROOT_DIR?=../..
include $(TINYOS_ROOT_DIR)/Makefile.include
$(call TOSMake_include_sensor,mda100)