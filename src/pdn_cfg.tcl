# source librelane pdf config before applying custom sram power straps
puts "souring default openraod pdn config" 
source $::env(SCRIPTS_DIR)/openroad/common/pdn_cfg.tcl

puts "sourcing sram pnd halo config" 
source $::env(DESIGN_DIR)/pdn_3v3_sram.tcl

