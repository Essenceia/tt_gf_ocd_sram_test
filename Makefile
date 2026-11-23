PROJECT_NAME=tt_um_essen

SRAM_TYPE=gf180mcu_ocd_ip_sram__sram256x8m8wm1

SRC_DIR=src
SRAM_BLACKBOX_PATH=${SRC_DIR}/sram/cells/${SRAM_TYPE}/${SRAM_TYPE}.blackbox.v
RTL_DEPS=${SRC_DIR}/tt_um_essen.v	

lint:  
	verilator --lint-only --no-timing $(RTL_DEPS) ${SRAM_BLACKBOX_PATH} --top $(PROJECT_NAME)
.PHONY: lint

