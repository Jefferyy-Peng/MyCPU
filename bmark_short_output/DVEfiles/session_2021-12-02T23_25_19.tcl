# Begin_DVE_Session_Save_Info
# DVE reload session
# Saved on Thu Dec 2 23:25:19 2021
# Designs open: 1
#   V1: /home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/bmark_short_output/cachetest.vpd
# Toplevel windows open: 2
# 	TopLevel.1
# 	TopLevel.2
#   Source.1: rocketTestHarness.dut.cpu
#   Wave.1: 45 signals
#   Group count = 4
#   Group Group1 signal count = 8
#   Group Group5 signal count = 5
#   Group Group7 signal count = 6
#   Group Group8 signal count = 26
# End_DVE_Session_Save_Info

# DVE version: P-2019.06_Full64
# DVE build date: May 31 2019 21:08:21


#<Session mode="Reload" path="/home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/bmark_short_output/DVEfiles/session.tcl" type="Debug">

gui_set_loading_session_type Reload
gui_continuetime_set

# Close design
if { [gui_sim_state -check active] } {
    gui_sim_terminate
}
gui_close_db -all
gui_expr_clear_all
gui_clear_window -type Wave
gui_clear_window -type List

# Application preferences
gui_set_pref_value -key app_default_font -value {Helvetica,10,-1,5,50,0,0,0,0,0}
gui_src_preferences -tabstop 8 -maxbits 24 -windownumber 1
#<WindowLayout>

# DVE top-level session


# Create and position top-level window: TopLevel.1

set TopLevel.1 TopLevel.1

# Docked window settings
set HSPane.1 HSPane.1
set Hier.1 Hier.1
set DLPane.1 DLPane.1
set Data.1 Data.1
set Console.1 Console.1
set DriverLoad.1 DriverLoad.1
gui_sync_global -id ${TopLevel.1} -option true

# MDI window settings
set Source.1 Source.1
gui_update_layout -id ${Source.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false}}

# End MDI window settings


# Create and position top-level window: TopLevel.2

set TopLevel.2 TopLevel.2

# Docked window settings
gui_sync_global -id ${TopLevel.2} -option true

# MDI window settings
set Wave.1 Wave.1
gui_update_layout -id ${Wave.1} {{show_state maximized} {dock_state undocked} {dock_on_new_line false} {child_wave_left 536} {child_wave_right 1309} {child_wave_colname 255} {child_wave_colvalue 277} {child_wave_col1 0} {child_wave_col2 1}}

# End MDI window settings


#</WindowLayout>

#<Database>

# DVE Open design session: 

if { ![gui_is_db_opened -db {/home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/bmark_short_output/cachetest.vpd}] } {
	gui_open_db -design V1 -file /home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/bmark_short_output/cachetest.vpd -nosource
}
gui_set_precision 100fs
gui_set_time_units 100fs
#</Database>

# DVE Global setting session: 


# Global: Bus

# Global: Expressions

# Global: Signal Time Shift

# Global: Signal Compare

# Global: Signal Groups
gui_load_child_values {rocketTestHarness.dut.mem.dcache}


set _session_group_9 Group1
gui_sg_create "$_session_group_9"
set Group1 "$_session_group_9"

gui_sg_addsignal -group "$_session_group_9" { rocketTestHarness.dut.cpu.clk rocketTestHarness.dut.cpu.reset rocketTestHarness.dut.cpu.icache_addr rocketTestHarness.dut.cpu.icache_re rocketTestHarness.dut.cpu.dcache_we rocketTestHarness.dut.cpu.dcache_re rocketTestHarness.dut.cpu.stall rocketTestHarness.dut.cpu.pc0 }

set _session_group_10 Group5
gui_sg_create "$_session_group_10"
set Group5 "$_session_group_10"

gui_sg_addsignal -group "$_session_group_10" { rocketTestHarness.dut.cpu.icache_dout rocketTestHarness.dut.cpu.inst0 rocketTestHarness.dut.cpu.dcache_addr rocketTestHarness.dut.cpu.dcache_din rocketTestHarness.dut.cpu.dcache_dout }

set _session_group_11 Group7
gui_sg_create "$_session_group_11"
set Group7 "$_session_group_11"

gui_sg_addsignal -group "$_session_group_11" { {rocketTestHarness.dut.cpu.regfile.mem[15]} {rocketTestHarness.dut.cpu.regfile.mem[14]} {rocketTestHarness.dut.cpu.regfile.mem[13]} {rocketTestHarness.dut.cpu.regfile.mem[12]} {rocketTestHarness.dut.cpu.regfile.mem[8]} {rocketTestHarness.dut.cpu.regfile.mem[2]} }

set _session_group_12 Group8
gui_sg_create "$_session_group_12"
set Group8 "$_session_group_12"

gui_sg_addsignal -group "$_session_group_12" { rocketTestHarness.dut.mem.dcache.cpu_req_valid rocketTestHarness.dut.mem.dcache.cpu_req_ready rocketTestHarness.dut.mem.dcache.cpu_req_addr rocketTestHarness.dut.mem.dcache.cpu_req_data rocketTestHarness.dut.mem.dcache.cpu_req_write rocketTestHarness.dut.mem.dcache.cpu_resp_valid rocketTestHarness.dut.mem.dcache.cpu_resp_data rocketTestHarness.dut.mem.dcache.mem_req_valid rocketTestHarness.dut.mem.dcache.mem_req_ready rocketTestHarness.dut.mem.dcache.mem_req_addr rocketTestHarness.dut.mem.dcache.mem_req_rw rocketTestHarness.dut.mem.dcache.mem_req_data_valid rocketTestHarness.dut.mem.dcache.mem_req_data_ready rocketTestHarness.dut.mem.dcache.mem_req_data_bits rocketTestHarness.dut.mem.dcache.mem_req_data_mask rocketTestHarness.dut.mem.dcache.mem_resp_valid rocketTestHarness.dut.mem.dcache.mem_resp_data rocketTestHarness.dut.mem.dcache.dataA rocketTestHarness.dut.mem.dcache.dataWEB rocketTestHarness.dut.mem.dcache.dataI rocketTestHarness.dut.mem.dcache.dataO rocketTestHarness.dut.mem.dcache.byteMask rocketTestHarness.dut.mem.dcache.dataO_wire rocketTestHarness.dut.mem.dcache.curr_addr rocketTestHarness.dut.mem.dcache.state rocketTestHarness.dut.mem.dcache.cycle }

# Global: Highlighting

# Global: Stack
gui_change_stack_mode -mode list

# Post database loading setting...

# Restore C1 time
gui_set_time -C1_only 2170000



# Save global setting...

# Wave/List view global setting
gui_list_create_group_when_add -wave -enable
gui_cov_show_value -switch false

# Close all empty TopLevel windows
foreach __top [gui_ekki_get_window_ids -type TopLevel] {
    if { [llength [gui_ekki_get_window_ids -parent $__top]] == 0} {
        gui_close_window -window $__top
    }
}
gui_set_loading_session_type noSession
# DVE View/pane content session: 


# Hier 'Hier.1'
gui_show_window -window ${Hier.1}
gui_list_set_filter -id ${Hier.1} -list { {Package 1} {All 0} {Process 1} {VirtPowSwitch 0} {UnnamedProcess 1} {UDP 0} {Function 1} {Block 1} {SrsnAndSpaCell 0} {OVA Unit 1} {LeafScCell 1} {LeafVlgCell 1} {Interface 1} {LeafVhdCell 1} {$unit 1} {NamedBlock 1} {Task 1} {VlgPackage 1} {ClassDef 1} {VirtIsoCell 0} }
gui_list_set_filter -id ${Hier.1} -text {*} -force
gui_change_design -id ${Hier.1} -design V1
catch {gui_list_expand -id ${Hier.1} rocketTestHarness}
catch {gui_list_expand -id ${Hier.1} rocketTestHarness.dut}
catch {gui_list_select -id ${Hier.1} {rocketTestHarness.dut.cpu}}
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Data 'Data.1'
gui_list_set_filter -id ${Data.1} -list { {Buffer 1} {Input 1} {Others 1} {Linkage 1} {Output 1} {LowPower 1} {Parameter 1} {All 1} {Aggregate 1} {LibBaseMember 1} {Event 1} {Assertion 1} {Constant 1} {Interface 1} {BaseMembers 1} {Signal 1} {$unit 1} {Inout 1} {Variable 1} }
gui_list_set_filter -id ${Data.1} -text {*}
gui_list_show_data -id ${Data.1} {rocketTestHarness.dut.cpu}
gui_view_scroll -id ${Data.1} -vertical -set 420
gui_view_scroll -id ${Data.1} -horizontal -set 0
gui_view_scroll -id ${Hier.1} -vertical -set 0
gui_view_scroll -id ${Hier.1} -horizontal -set 0

# Source 'Source.1'
gui_src_value_annotate -id ${Source.1} -switch false
gui_set_env TOGGLE::VALUEANNOTATE 0
gui_open_source -id ${Source.1}  -replace -active rocketTestHarness.dut.cpu /home/cc/eecs151/fl21/class/eecs151-aea/risc-v_project/src/Riscv151.v
gui_view_scroll -id ${Source.1} -vertical -set 1035
gui_src_set_reusable -id ${Source.1}

# View 'Wave.1'
gui_wv_sync -id ${Wave.1} -switch false
set groupExD [gui_get_pref_value -category Wave -key exclusiveSG]
gui_set_pref_value -category Wave -key exclusiveSG -value {false}
set origWaveHeight [gui_get_pref_value -category Wave -key waveRowHeight]
gui_list_set_height -id Wave -height 25
set origGroupCreationState [gui_list_create_group_when_add -wave]
gui_list_create_group_when_add -wave -disable
gui_wv_zoom_timerange -id ${Wave.1} 1746008 2819667
gui_list_add_group -id ${Wave.1} -after {New Group} {Group1}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group5}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group7}
gui_list_add_group -id ${Wave.1} -after {New Group} {Group8}
gui_list_select -id ${Wave.1} {rocketTestHarness.dut.mem.dcache.cpu_resp_valid }
gui_seek_criteria -id ${Wave.1} {Rising}



gui_set_env TOGGLE::DEFAULT_WAVE_WINDOW ${Wave.1}
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
gui_list_set_insertion_bar  -id ${Wave.1} -group Group8  -position in

gui_marker_move -id ${Wave.1} {C1} 2170000
gui_view_scroll -id ${Wave.1} -vertical -set 0
gui_show_grid -id ${Wave.1} -enable false

# DriverLoad 'DriverLoad.1'
gui_get_drivers -session -id ${DriverLoad.1} -signal {rocketTestHarness.dut.cpu.icache_dout[31:0]} -time 2610000 -starttime 2610000
# Restore toplevel window zorder
# The toplevel window could be closed if it has no view/pane
if {[gui_exist_window -window ${TopLevel.2}]} {
	gui_set_active_window -window ${TopLevel.2}
	gui_set_active_window -window ${Wave.1}
}
if {[gui_exist_window -window ${TopLevel.1}]} {
	gui_set_active_window -window ${TopLevel.1}
	gui_set_active_window -window ${Source.1}
}
#</Session>

