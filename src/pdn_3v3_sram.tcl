# SRAM macros power delivery 
# PDN file originally copied from: waffer space project template written by mole99, released under Appache 2.0 
# https://github.com/wafer-space/gf180mcu-project-template/blob/main/librelane/pdn/pdn_3v3_sram.tcl

puts "setting up pdn halo on horizental $::env(PDN_HORIZONTAL_HALO) vertical $::env(PDN_VERTICAL_HALO)"
puts "assuming pdn horizental layer is $::env(PDN_HORIZONTAL_LAYER) is and vertical layer is $::env(PDN_VERTICAL_LAYER)"

# sram macro power is on metal 3, I just need to link metal4 to metal 3

define_pdn_grid \
    -macro \
    -instances m_sram \
    -name sram_macros_NS \
    -starts_with POWER \
    -halo "1.0 1.0"

add_pdn_connect \
    -grid sram_macros_NS \
    -layers "$::env(PDN_VERTICAL_LAYER) $::env(PDN_HORIZONTAL_LAYER)"

add_pdn_connect \
    -grid sram_macros_NS \
    -layers "$::env(PDN_VERTICAL_LAYER) Metal3"

# Add stripes on W/E edges of SRAM
add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 1.36 \
    -offset 0.68 \
    -spacing 0.28 \
    -pitch 298.30 \
    -starts_with GROUND \
    -number_of_straps 2

# Since the above stripes block the top level PDN at Metal4, add some more stripes
# to improve the PDN's integrity and ensure a better connection for the macro.
add_pdn_stripe \
    -grid sram_macros_NS \
    -layer Metal4 \
    -width 4.00 \
    -offset 50.80 \
    -spacing 0.28 \
    -pitch 48.86 \
    -starts_with GROUND \
    -number_of_straps 5
