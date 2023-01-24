# Begin_DVE_Session_Save_Info
# DVE view(Wave.1 ) session
# Saved on Thu Dec 2 23:26:22 2021
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Wave.1: 45 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="View" path="/home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/bmark_short_output/session.cachetest.vpd.tcl" type="Debug">

#<Database>

gui_set_time_units 100fs
#</Database>

# DVE View/pane content session: 

# Begin_DVE_Session_Save_Info (Wave.1)
# DVE wave signals session
# Saved on Thu Dec 2 23:26:22 2021
# 45 signals
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#Add ncecessay scopes
gui_load_child_values {rocketTestHarness.dut.mem.dcache}

gui_set_time_units 100fs

set _wave_session_group_1 Group1
if {[gui_sg_is_group -name "$_wave_session_group_1"]} {
    set _wave_session_group_1 [gui_sg_generate_new_name]
}
set Group1 "$_wave_session_group_1"

gui_sg_addsignal -group "$_wave_session_group_1" { {V1:rocketTestHarness.dut.cpu.clk} {V1:rocketTestHarness.dut.cpu.reset} {V1:rocketTestHarness.dut.cpu.icache_addr} {V1:rocketTestHarness.dut.cpu.icache_re} {V1:rocketTestHarness.dut.cpu.dcache_we} {V1:rocketTestHarness.dut.cpu.dcache_re} {V1:rocketTestHarness.dut.cpu.stall} {V1:rocketTestHarness.dut.cpu.pc0} }

set _wave_session_group_2 Group5
if {[gui_sg_is_group -name "$_wave_session_group_2"]} {
    set _wave_session_group_2 [gui_sg_generate_new_name]
}
set Group2 "$_wave_session_group_2"

gui_sg_addsignal -group "$_wave_session_group_2" { {V1:rocketTestHarness.dut.cpu.icache_dout} {V1:rocketTestHarness.dut.cpu.inst0} {V1:rocketTestHarness.dut.cpu.dcache_addr} {V1:rocketTestHarness.dut.cpu.dcache_din} {V1:rocketTestHarness.dut.cpu.dcache_dout} }

set _wave_session_group_3 Group7
if {[gui_sg_is_group -name "$_wave_session_group_3"]} {
    set _wave_session_group_3 [gui_sg_generate_new_name]
}
set Group3 "$_wave_session_group_3"

gui_sg_addsignal -group "$_wave_session_group_3" { {V1:rocketTestHarness.dut.cpu.regfile.mem[15]} {V1:rocketTestHarness.dut.cpu.regfile.mem[14]} {V1:rocketTestHarness.dut.cpu.regfile.mem[13]} {V1:rocketTestHarness.dut.cpu.regfile.mem[12]} {V1:rocketTestHarness.dut.cpu.regfile.mem[8]} {V1:rocketTestHarness.dut.cpu.regfile.mem[2]} }

set _wave_session_group_4 Group8
if {[gui_sg_is_group -name "$_wave_session_group_4"]} {
    set _wave_session_group_4 [gui_sg_generate_new_name]
}
set Group4 "$_wave_session_group_4"

gui_sg_addsignal -group "$_wave_session_group_4" { {V1:rocketTestHarness.dut.mem.dcache.cpu_req_valid} {V1:rocketTestHarness.dut.mem.dcache.cpu_req_ready} {V1:rocketTestHarness.dut.mem.dcache.cpu_req_addr} {V1:rocketTestHarness.dut.mem.dcache.cpu_req_data} {V1:rocketTestHarness.dut.mem.dcache.cpu_req_write} {V1:rocketTestHarness.dut.mem.dcache.cpu_resp_valid} {V1:rocketTestHarness.dut.mem.dcache.cpu_resp_data} {V1:rocketTestHarness.dut.mem.dcache.mem_req_valid} {V1:rocketTestHarness.dut.mem.dcache.mem_req_ready} {V1:rocketTestHarness.dut.mem.dcache.mem_req_addr} {V1:rocketTestHarness.dut.mem.dcache.mem_req_rw} {V1:rocketTestHarness.dut.mem.dcache.mem_req_data_valid} {V1:rocketTestHarness.dut.mem.dcache.mem_req_data_ready} {V1:rocketTestHarness.dut.mem.dcache.mem_req_data_bits} {V1:rocketTestHarness.dut.mem.dcache.mem_req_data_mask} {V1:rocketTestHarness.dut.mem.dcache.mem_resp_valid} {V1:rocketTestHarness.dut.mem.dcache.mem_resp_data} {V1:rocketTestHarness.dut.mem.dcache.dataA} {V1:rocketTestHarness.dut.mem.dcache.dataWEB} {V1:rocketTestHarness.dut.mem.dcache.dataI} {V1:rocketTestHarness.dut.mem.dcache.dataO} {V1:rocketTestHarness.dut.mem.dcache.byteMask} {V1:rocketTestHarness.dut.mem.dcache.dataO_wire} {V1:rocketTestHarness.dut.mem.dcache.curr_addr} {V1:rocketTestHarness.dut.mem.dcache.state} {V1:rocketTestHarness.dut.mem.dcache.cycle} }
if {![info exists useOldWindow]} { 
	set useOldWindow true
}
if {$useOldWindow && [string first "Wave" [gui_get_current_window -view]]==0} { 
	set Wave.1 [gui_get_current_window -view] 
} else {
	set Wave.1 [lindex [gui_get_window_ids -type Wave] 0]
if {[string first "Wave" ${Wave.1}]!=0} {
gui_open_window Wave
set Wave.1 [ gui_get_current_window -view ]
}
}

set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_marker_create -id ${Wave.1} M1 3630117
gui_marker_create -id ${Wave.1} M2 2169974
gui_marker_set_ref -id ${Wave.1}  C1
gui_wv_zoom_timerange -id ${Wave.1} 1746008 2819667
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group1}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group2}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group3}]
gui_list_add_group -id ${Wave.1} -after {New Group} [list ${Group4}]
gui_list_select -id ${Wave.1} {rocketTestHarness.dut.mem.dcache.cpu_resp_valid }
gui_seek_criteria -id ${Wave.1} {Rising}


gui_set_pref_value -category Wave -key exclusiveSG -value $groupExD
gui_list_set_height -id Wave -height $origWaveHeight
if {$origGroupCreationState} {
	gui_list_create_group_when_add -wave -enable
}
if { $groupExD } {
 gui_msg_report -code DVWW028
}
gui_list_set_filter -id ${Wave.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Wave.1} -text {*}
gui_list_set_insertion_bar  -id ${Wave.1} -group ${Group4}  -position in

gui_marker_move -id ${Wave.1} {C1} 2170000
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false
#</Session>

