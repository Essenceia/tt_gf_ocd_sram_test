# source librelane pdf config before applying custom sram power straps
puts "souring default openraod pdn config" 
source $::env(SCRIPTS_DIR)/openroad/common/pdn_cfg.tcl

puts "sourcing sram pnd halo config" 
source $::env(DESIGN_DIR)/pdn_3v3_sram.tcl

# connect main power grid and sram, per macro offset calculation is broken 
puts "set pdn configs, vwidth $::env(PDN_VWIDTH) offset $::env(PDN_VOFFSET) pitch $::env(PDN_VOFFSET)"
