################################################
# Configurations for building TOP

TOP = top

OBJ_DIR = ./obj_dir

VERILATOR_ROOT ?= /opt/homebrew/
VERILATOR = $(VERILATOR_ROOT)/bin/verilator

VL_FLAGS += --binary
VL_FLAGS += --top-module $(TOP) $(TOP).sv
VL_FLAGS += -I. # Add additional source directories here
VL_FLAGS += --trace
VL_FLAGS += -O2 --language 1800-2009 --assert -Wall -Wpedantic
VL_FLAGS += -Wno-DECLFILENAME -Wno-REDEFMACRO
VL_FLAGS += --x-initial unique --x-assign unique
VL_FLAGS += --Mdir $(OBJ_DIR)

ifdef DEBUG
VERILATOR = $(VERILATOR_ROOT)/bin/verilator_bin_dbg
CXXFLAGS += -g -O0
endif

################################################

.PHONY: default build run clean $(OBJ_DIR)

$(OBJ_DIR): $(TOP.sv)
	@echo 
	@echo "### VERILATE ###"
	$(VERILATOR) $(VL_FLAGS) $<

run: $(OBJ_DIR)
	@echo
	@echo "### RUN ###"
	./$(OBJ_DIR)/V$(TOP)

waves: trace.vcd
	@echo
	@echo "### TRACE ###"
	gtkwave -o trace.vcd &

clean:
	@echo
	@echo "### Clean ###"
	@rm -rvf $(OBJ_DIR) *.vcd