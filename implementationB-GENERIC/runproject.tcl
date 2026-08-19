#### Template Script for RTL->Gate-Level Flow (generated from GENUS 17.10-p007_1) 

if {[file exists /proc/cpuinfo]} {
  sh grep "model name" /proc/cpuinfo
  sh grep "cpu MHz"    /proc/cpuinfo
}


puts "Hostname : [info hostname]"

##############################################################################
## Preset global variables and attributes
##############################################################################

########## Set your Design Name 
set DESIGN top
set GEN_EFF medium
set MAP_OPT_EFF high
set DATE [clock format [clock seconds] -format "%b%d-%T"] 
set _OUTPUTS_PATH outputs_${DATE}
set _REPORTS_PATH reports_${DATE}
set _LOG_PATH logs_${DATE}

##set ET_WORKDIR <ET work directory>
##set_db / .init_lib_search_path  {. /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB}
##set_db / .init_lib_search_path {/eda/tech/asap7sc7p5t_28/LIB/CCS}
##set_db / .script_search_path {. <path>} 

########################### STE ON XXXXXXX your up, your file name on home
#set_db / .init_hdl_search_path  {. /home/npapage/Documents/TEST/RTL}

##Uncomment and specify machine names to enable super-threading.
##set_db / .super_thread_servers {<machine names>} 
##For design size of 1.5M - 5M gates, use 8 to 16 CPUs. For designs > 5M gates, use 16 to 32 CPUs
##set_db / .max_cpus_per_server 8

##Default undriven/unconnected setting is 'none'.  
##set_db / .hdl_unconnected_input_port_value 0 | 1 | x | none 
##set_db / .hdl_undriven_output_port_value   0 | 1 | x | none
##set_db / .hdl_undriven_signal_value        0 | 1 | x | none 


##set_db / .wireload_mode <value> 
set_db / .information_level 7 

###############################################################
## Library setup
###############################################################

##read_libs {asap7sc7p5t_SIMPLE_RVT_TT_ccs_211120.lib asap7sc7p5t_INVBUF_RVT_SS_ccs_220122.lib asap7sc7p5t_SEQ_RVT_TT_ccs_220123.lib}
set_db / .library {/eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v0_basicCells.lib   /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v0_extvdd1v0_extvddb1v2.lib   /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v0_extvdd1v0.lib     /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v0_extvdd1v2.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v0_multibitsDFF.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v2_basicCells.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v2_extvdd1v0.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v2_extvdd1v2.lib   /eda/tech/gsclib045_all_v4.7/gsclib045/timing/fast_vdd1v2_multibitsDFF.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_basicCells.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_extvdd1v0_extvddb1v2.lib   /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_extvdd1v0.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_extvdd1v2.lib    /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v0_multibitsDFF.lib /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v2_basicCells.lib /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v2_extvdd1v0.lib /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v2_extvdd1v2.lib /eda/tech/gsclib045_all_v4.7/gsclib045/timing/slow_vdd1v2_multibitsDFF.lib  /eda/tech/gsclib045_all_v4.7/gsclib045_backbias/timing/fast_vdd1v0_dNW0v0_basicCells_backbias.lib /eda/tech/gsclib045_all_v4.7/gsclib045_backbias/timing/fast_vdd1v0_dNW0v3_basicCells_backbias.lib /eda/tech/gsclib045_all_v4.7/gsclib045_backbias/timing/slow_vdd1v0_dNW0v0_basicCells_backbias.lib   /eda/tech/gsclib045_all_v4.7/gsclib045_backbias/timing/slow_vdd1v0_dNW0v3_basicCells_backbias.lib  /eda/tech/gsclib045_all_v4.7/gsclib045_hvt/timing/fast_vdd1v0_basicCells_hvt.lib  /eda/tech/gsclib045_all_v4.7/gsclib045_hvt/timing/slow_vdd1v0_basicCells_hvt.lib  /eda/tech/gsclib045_all_v4.7/gsclib045_lvt/timing/fast_vdd1v0_basicCells_lvt.lib /eda/tech/gsclib045_all_v4.7/gsclib045_lvt/timing/slow_vdd1v0_basicCells_lvt.lib}
##set_db / .library {/eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB/slow.lib /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB/pll.lib /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB/CDK_S128x16.lib /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB/CDK_S256x16.lib /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LIB/CDK_R512x16.lib}
## PLE
set_db / .lef_library {/eda/tech/gsclib045_all_v4.7/gsclib045/lef/gsclib045_macro.lef /eda/tech/gsclib045_all_v4.7/gsclib045/lef/gsclib045_multibitsDFF.lef  /eda/tech/gsclib045_all_v4.7/gsclib045/lef/gsclib045_tech.lef  }
##set_db / .lef_library  {/eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/gsclib045_tech.lef  /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/gsclib045_macro.lef  /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/pll.lef   /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/CDK_S128x16.lef  /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/CDK_S256x16.lef /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/LEF/CDK_R512x16.lef}
## Provide either cap_table_file or the qrc_tech_file
##set_db / .cap_table_file <file> 
#set_db / .qrc_tech_file <file>

##set_db / .lp_insert_clock_gating true 

####################################################################
## Load Design
####################################################################

set_db / .hdl_enable_real_support true

#read_hdl " pllclk.v accum_stat.v alu_32.v arb.v data_bus_mach.v data_sample_mux.v decode_i.v decoder.v \
	#digit_reg.v conv_subreg.v dma.v dtmf_recvr_core.v execute_i.v m16x16.v mult_32_dp.v \
	#port_bus_mach.v prog_bus_mach.v ram_128x16_test.v ram_256x16_test.v results_conv.v spi.v \
	#tdsp_core_glue.v tdsp_core_mach.v tdsp_core.v tdsp_data_mux.v tdsp_ds_cs.v test_control.v \
	#ulaw_lin_conv.v power_manager.v "
read_hdl -language vhdl {top.vhd PU_n.vhd mux2to1.vhd mod_n_adder.vhd FA_n.vhd FA.vhd QD.vhd}
elaborate $DESIGN
puts "Runtime & Memory after 'read_hdl'"
time_info Elaboration

check_design
check_design -unresolved

####################################################################
## Constraints Setup
####################################################################

#################### Set your Correct Path of the SDC file 
read_sdc /eda/tech/vlsi2/Genus_LAB/Genus_CUI_RAK/genus.sdc
puts "The number of exceptions is [llength [vfind "design:$DESIGN" -exception *]]"

create_clock -name clk -period 4 [get_ports clk]

#set_db "design:$DESIGN" .force_wireload <wireload name> 

if {![file exists ${_LOG_PATH}]} {
  file mkdir ${_LOG_PATH}
  puts "Creating directory ${_LOG_PATH}"
}


if {![file exists ${_OUTPUTS_PATH}]} {
  file mkdir ${_OUTPUTS_PATH}
  puts "Creating directory ${_OUTPUTS_PATH}"
}

if {![file exists ${_REPORTS_PATH}]} {
  file mkdir ${_REPORTS_PATH}
  puts "Creating directory ${_REPORTS_PATH}"
}


#### To turn off sequential merging on the design 
#### uncomment & use the following attributes.
##set_db / .optimize_merge_flops false 
##set_db / .optimize_merge_latches false 
#### For a particular instance use attribute 'optimize_merge_seqs' to turn off sequential merging. 



####################################################################################################
## Synthesizing to generic 
####################################################################################################
#set_load 3.0 [all_outputs]
set_db / .syn_generic_effort $GEN_EFF
syn_generic
puts "Runtime & Memory after 'syn_generic'"
time_info GENERIC
report_dp > $_REPORTS_PATH/generic/${DESIGN}_datapath.rpt
write_snapshot -outdir $_REPORTS_PATH -tag generic
report_summary -directory $_REPORTS_PATH





####################################################################################################
## Synthesizing to gates
####################################################################################################


set_db / .syn_map_effort $MAP_OPT_EFF
syn_map
puts "Runtime & Memory after 'syn_map'"
time_info MAPPED
write_snapshot -outdir $_REPORTS_PATH -tag map
report_summary -directory $_REPORTS_PATH
report_dp > $_REPORTS_PATH/map/${DESIGN}_datapath.rpt



write_do_lec -revised_design fv_map -logfile ${_LOG_PATH}/rtl2intermediate.lec.log > ${_OUTPUTS_PATH}/rtl2intermediate.lec.do

## ungroup -threshold <value>

#######################################################################################################
## Optimize Netlist
#######################################################################################################

## Uncomment to remove assigns & insert tiehilo cells during Incremental synthesis
##set_db / .remove_assigns true 
##set_remove_assign_options -buffer_or_inverter <libcell> -design <design|subdesign> 
##set_db / .use_tiehilo_for_const <none|duplicate|unique> 
set_db / .syn_opt_effort $MAP_OPT_EFF
syn_opt
write_snapshot -outdir $_REPORTS_PATH -tag syn_opt
report_summary -directory $_REPORTS_PATH

puts "Runtime & Memory after 'syn_opt'"
time_info OPT



#write_snapshot -outdir $_REPORTS_PATH -tag final
#report_summary -directory $_REPORTS_PATH
##write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
## write_script > ${_OUTPUTS_PATH}/${DESIGN}_m.script
write_sdc > ${_OUTPUTS_PATH}/${DESIGN}_m.sdc

#################################
### write_do_lec
#################################

write_design -innovus $DESIGN
write_snapshot -outdir $_REPORTS_PATH -tag final
report_summary -directory $_REPORTS_PATH
write_hdl  > ${_OUTPUTS_PATH}/${DESIGN}_m.v
write_sdf -setuphold split \
          -recrem split \
          > ${_OUTPUTS_PATH}/${DESIGN}_m.sdf
write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

#write_do_lec -golden_design fv_map -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile  ${_LOG_PATH}/intermediate2final.lec.log > ${_OUTPUTS_PATH}/intermediate2final.lec.do
##Uncomment if the RTL is to be compared with the final netlist..
##write_do_lec -revised_design ${_OUTPUTS_PATH}/${DESIGN}_m.v -logfile ${_LOG_PATH}/rtl2final.lec.log > ${_OUTPUTS_PATH}/rtl2final.lec.do

puts "Final Runtime & Memory."
time_info FINAL
puts "============================"
puts "Synthesis Finished ........."
puts "============================"

#file copy [get_db / .stdout_log] ${_LOG_PATH}

##quit
