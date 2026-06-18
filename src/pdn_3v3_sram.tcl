# SRAM macros power delivery 
# PDN file originally copied from: waffer space project template written by mole99, released under Appache 2.0 
# https://github.com/wafer-space/gf180mcu-project-template/blob/main/librelane/pdn/pdn_3v3_sram.tcl

# sram macro power is on metal 3, I just need to link metal4 to metal 3
define_pdn_grid \
    -macro \
    -instances m_sram \
    -name sram_macros_NS \
    -starts_with POWER 
#	-halo "0.0 0.0"

add_pdn_connect \
    -grid sram_macros_NS \
    -layers "Metal4 Metal3"

add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 6.0 \
    -offset 150.0 \
    -spacing 2.0 \
    -pitch 139.5 \
    -starts_with POWER \
    -number_of_straps 2

add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 6.0 \
    -offset 0.0 \
    -spacing 1.0 \
    -pitch 100.0 \
    -starts_with POWER \
    -number_of_straps 2
