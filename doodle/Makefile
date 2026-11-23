PROJECT_NAME=doodle
LOGO_PATH=images/doodle.jpeg

HEIGTH=50
WIDTH=${HEIGTH}

MAKEFILE_DIR := $(shell dirname $(realpath $(firstword $(MAKEFILE_LIST))))

PDK_ROOT ?= $(MAKEFILE_DIR)/../../gf180mcu
PDK ?= gf180mcuD

all: logo drc
.PHONY: all

logo:
	python3 script/make_gds.py ${LOGO_PATH} gds/${PROJECT_NAME}.gds --cellname ${PROJECT_NAME} --invert --merge --pixel-size 0.75 --width ${WIDTH} --height ${HEIGTH} --foreground "34/0" "36/0" "42/0" "46/0" "81/0" --boundary "0/0" "152/5"
.PHONY: logo

drc:
	PDK_ROOT=${PDK_ROOT} PDK=${PDK} klayout -b -zz -r ${PDK_ROOT}/${PDK}/libs.tech/klayout/tech/drc/gf180mcu.drc -rd input=gds/${PROJECT_NAME}.gds -rd report=report.lyrdb -rd feol=false -rd beol=true
.PHONY: drc

clean:
	rm -f ./gds/*
	rm -f ./lef/*
	rm -f ./lib/*
.PHONEY:clean
