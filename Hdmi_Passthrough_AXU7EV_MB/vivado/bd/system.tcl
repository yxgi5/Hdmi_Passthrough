
################################################################
# This is a generated script based on design: system
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

namespace eval _tcl {
proc get_script_folder {} {
   set script_path [file normalize [info script]]
   set script_folder [file dirname $script_path]
   return $script_folder
}
}
variable script_folder
set script_folder [_tcl::get_script_folder]

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2017.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   catch {common::send_msg_id "BD_TCL-109" "ERROR" "This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."}

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source system_script.tcl


# The design that will be created by this Tcl script contains the following 
# module references:
# aud_pat_gen, hdmi_acr_ctrl

# Please add the sources of those modules before sourcing this Tcl script.

# If there is no project opened, this script will create a
# project, but make sure you do not have an existing project
# <./myproj/project_1.xpr> in the current working folder.

set list_projs [get_projects -quiet]
if { $list_projs eq "" } {
   create_project project_1 myproj -part xczu7ev-ffvc1156-2-i
}


# CHANGE DESIGN NAME HERE
variable design_name
set design_name system

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      common::send_msg_id "BD_TCL-001" "INFO" "Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   common::send_msg_id "BD_TCL-002" "INFO" "Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   common::send_msg_id "BD_TCL-003" "INFO" "Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   common::send_msg_id "BD_TCL-004" "INFO" "Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

common::send_msg_id "BD_TCL-005" "INFO" "Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   catch {common::send_msg_id "BD_TCL-114" "ERROR" $errMsg}
   return $nRet
}

set bCheckIPsPassed 1
##################################################################
# CHECK IPs
##################################################################
set bCheckIPs 1
if { $bCheckIPs == 1 } {
   set list_check_ips "\ 
xilinx.com:ip:axis_register_slice:1.1\
xilinx.com:ip:util_vector_logic:2.0\
xilinx.com:ip:v_hdmi_rx_ss:3.0\
xilinx.com:ip:v_hdmi_tx_ss:3.0\
xilinx.com:ip:xlconstant:1.1\
xilinx.com:ip:vid_phy_controller:2.1\
xilinx.com:ip:clk_wiz:5.4\
xilinx.com:ip:axi_intc:4.1\
xilinx.com:ip:axi_uartlite:2.0\
xilinx.com:ip:lmb_bram_if_cntlr:4.0\
xilinx.com:ip:lmb_v10:3.0\
xilinx.com:ip:axi_iic:2.0\
xilinx.com:ip:blk_mem_gen:8.4\
xilinx.com:ip:microblaze:10.0\
xilinx.com:ip:mdm:3.2\
xilinx.com:ip:proc_sys_reset:5.0\
xilinx.com:ip:xlconcat:2.1\
xilinx.com:ip:axi_gpio:2.0\
xilinx.com:ip:v_tpg:7.0\
"

   set list_ips_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following IPs exist in the project's IP catalog: $list_check_ips ."

   foreach ip_vlnv $list_check_ips {
      set ip_obj [get_ipdefs -all $ip_vlnv]
      if { $ip_obj eq "" } {
         lappend list_ips_missing $ip_vlnv
      }
   }

   if { $list_ips_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following IPs are not found in the IP Catalog:\n  $list_ips_missing\n\nResolution: Please add the repository containing the IP(s) to the project." }
      set bCheckIPsPassed 0
   }

}

##################################################################
# CHECK Modules
##################################################################
set bCheckModules 1
if { $bCheckModules == 1 } {
   set list_check_mods "\ 
aud_pat_gen\
hdmi_acr_ctrl\
"

   set list_mods_missing ""
   common::send_msg_id "BD_TCL-006" "INFO" "Checking if the following modules exist in the project's sources: $list_check_mods ."

   foreach mod_vlnv $list_check_mods {
      if { [can_resolve_reference $mod_vlnv] == 0 } {
         lappend list_mods_missing $mod_vlnv
      }
   }

   if { $list_mods_missing ne "" } {
      catch {common::send_msg_id "BD_TCL-115" "ERROR" "The following module(s) are not found in the project: $list_mods_missing" }
      common::send_msg_id "BD_TCL-008" "INFO" "Please add source files for the missing module(s) above."
      set bCheckIPsPassed 0
   }
}

if { $bCheckIPsPassed != 1 } {
  common::send_msg_id "BD_TCL-1003" "WARNING" "Will not continue with creation of design due to the error(s) above."
  return 3
}

##################################################################
# DESIGN PROCs
##################################################################


# Hierarchical cell: v_tpg_ss_0
proc create_hier_cell_v_tpg_ss_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_v_tpg_ss_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_GPIO
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S_AXI_TPG
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 m_axis_video
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 s_axis_video

  # Create pins
  create_bd_pin -dir I -type clk ap_clk
  create_bd_pin -dir I -type rst m_axi_aresetn

  # Create instance: axi_gpio, and set properties
  set axi_gpio [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_gpio:2.0 axi_gpio ]
  set_property -dict [ list \
   CONFIG.C_ALL_OUTPUTS {1} \
   CONFIG.C_GPIO_WIDTH {1} \
 ] $axi_gpio

  # Create instance: v_tpg, and set properties
  set v_tpg [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:7.0 v_tpg ]
  set_property -dict [ list \
   CONFIG.COLOR_SWEEP {0} \
   CONFIG.DISPLAY_PORT {0} \
   CONFIG.FOREGROUND {0} \
   CONFIG.HAS_AXI4S_SLAVE {1} \
   CONFIG.MAX_DATA_WIDTH {8} \
   CONFIG.RAMP {0} \
   CONFIG.SAMPLES_PER_CLOCK {2} \
   CONFIG.SOLID_COLOR {0} \
   CONFIG.ZONE_PLATE {0} \
 ] $v_tpg

  # Create interface connections
  connect_bd_intf_net -intf_net intf_net_bdry_in_S_AXI_GPIO [get_bd_intf_pins S_AXI_GPIO] [get_bd_intf_pins axi_gpio/S_AXI]
  connect_bd_intf_net -intf_net intf_net_bdry_in_S_AXI_TPG [get_bd_intf_pins S_AXI_TPG] [get_bd_intf_pins v_tpg/s_axi_CTRL]
  connect_bd_intf_net -intf_net intf_net_bdry_in_s_axis_video [get_bd_intf_pins s_axis_video] [get_bd_intf_pins v_tpg/s_axis_video]
  connect_bd_intf_net -intf_net intf_net_v_tpg_m_axis_video [get_bd_intf_pins m_axis_video] [get_bd_intf_pins v_tpg/m_axis_video]

  # Create port connections
  connect_bd_net -net net_axi_gpio_gpio_io_o [get_bd_pins axi_gpio/gpio_io_o] [get_bd_pins v_tpg/ap_rst_n]
  connect_bd_net -net net_bdry_in_ap_clk [get_bd_pins ap_clk] [get_bd_pins axi_gpio/s_axi_aclk] [get_bd_pins v_tpg/ap_clk]
  connect_bd_net -net net_bdry_in_m_axi_aresetn [get_bd_pins m_axi_aresetn] [get_bd_pins axi_gpio/s_axi_aresetn]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: mb_ss_0
proc create_hier_cell_mb_ss_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_mb_ss_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 IIC_0
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M00_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M01_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M02_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M05_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M06_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:aximm_rtl:1.0 M08_AXI
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 UART
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_diff_clock

  # Create pins
  create_bd_pin -dir O -type clk clk_out2
  create_bd_pin -dir O -from 0 -to 0 dcm_locked
  create_bd_pin -dir I -type rst ext_reset_in
  create_bd_pin -dir I hdmi_rx_irq
  create_bd_pin -dir I hdmi_tx_irq
  create_bd_pin -dir O -from 0 -to 0 -type rst peripheral_aresetn
  create_bd_pin -dir O -type clk s_axi_aclk
  create_bd_pin -dir I vphy_irq

  # Create instance: axi_intc, and set properties
  set axi_intc [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_intc:4.1 axi_intc ]

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {10} \
 ] $axi_interconnect

  # Create instance: axi_uartlite, and set properties
  set axi_uartlite [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_uartlite:2.0 axi_uartlite ]
  set_property -dict [ list \
   CONFIG.C_BAUDRATE {115200} \
   CONFIG.UARTLITE_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $axi_uartlite

  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.4 clk_wiz ]
  set_property -dict [ list \
   CONFIG.CLKIN1_JITTER_PS {50.0} \
   CONFIG.CLKOUT1_JITTER {106.024} \
   CONFIG.CLKOUT1_PHASE_ERROR {82.655} \
   CONFIG.CLKOUT2_JITTER {85.855} \
   CONFIG.CLKOUT2_PHASE_ERROR {82.655} \
   CONFIG.CLKOUT2_REQUESTED_OUT_FREQ {300.000} \
   CONFIG.CLKOUT2_USED {true} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {6.000} \
   CONFIG.MMCM_CLKIN1_PERIOD {5.000} \
   CONFIG.MMCM_CLKIN2_PERIOD {10.0} \
   CONFIG.MMCM_CLKOUT1_DIVIDE {4} \
   CONFIG.MMCM_DIVCLK_DIVIDE {1} \
   CONFIG.NUM_OUT_CLKS {2} \
   CONFIG.PRIM_IN_FREQ {200} \
   CONFIG.PRIM_SOURCE {Differential_clock_capable_pin} \
 ] $clk_wiz

  # Create instance: dlmb_bram_if_cntlr, and set properties
  set dlmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 dlmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $dlmb_bram_if_cntlr

  # Create instance: dlmb_v10, and set properties
  set dlmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 dlmb_v10 ]
  set_property -dict [ list \
   CONFIG.C_LMB_NUM_SLAVES {1} \
 ] $dlmb_v10

  # Create instance: fmch_axi_iic, and set properties
  set fmch_axi_iic [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 fmch_axi_iic ]
  set_property -dict [ list \
   CONFIG.IIC_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $fmch_axi_iic

  # Create instance: fmch_axi_iic1, and set properties
  set fmch_axi_iic1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_iic:2.0 fmch_axi_iic1 ]
  set_property -dict [ list \
   CONFIG.IIC_BOARD_INTERFACE {Custom} \
   CONFIG.USE_BOARD_FLOW {true} \
 ] $fmch_axi_iic1

  # Create instance: ilmb_bram_if_cntlr, and set properties
  set ilmb_bram_if_cntlr [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_bram_if_cntlr:4.0 ilmb_bram_if_cntlr ]
  set_property -dict [ list \
   CONFIG.C_ECC {0} \
 ] $ilmb_bram_if_cntlr

  # Create instance: ilmb_v10, and set properties
  set ilmb_v10 [ create_bd_cell -type ip -vlnv xilinx.com:ip:lmb_v10:3.0 ilmb_v10 ]
  set_property -dict [ list \
   CONFIG.C_LMB_NUM_SLAVES {1} \
 ] $ilmb_v10

  # Create instance: lmb_bram, and set properties
  set lmb_bram [ create_bd_cell -type ip -vlnv xilinx.com:ip:blk_mem_gen:8.4 lmb_bram ]
  set_property -dict [ list \
   CONFIG.Enable_B {Use_ENB_Pin} \
   CONFIG.Memory_Type {True_Dual_Port_RAM} \
   CONFIG.Port_B_Clock {100} \
   CONFIG.Port_B_Enable_Rate {100} \
   CONFIG.Port_B_Write_Rate {50} \
   CONFIG.Use_RSTB_Pin {true} \
   CONFIG.use_bram_block {BRAM_Controller} \
 ] $lmb_bram

  # Create instance: mblaze, and set properties
  set mblaze [ create_bd_cell -type ip -vlnv xilinx.com:ip:microblaze:10.0 mblaze ]
  set_property -dict [ list \
   CONFIG.C_DEBUG_ENABLED {1} \
   CONFIG.C_D_AXI {1} \
   CONFIG.C_D_LMB {1} \
   CONFIG.C_I_AXI {0} \
   CONFIG.C_I_LMB {1} \
 ] $mblaze

  # Create instance: mdm, and set properties
  set mdm [ create_bd_cell -type ip -vlnv xilinx.com:ip:mdm:3.2 mdm ]

  # Create instance: rst_processor_1_100M, and set properties
  set rst_processor_1_100M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processor_1_100M ]

  # Create instance: rst_processor_1_300M, and set properties
  set rst_processor_1_300M [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 rst_processor_1_300M ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: xlconcat, and set properties
  set xlconcat [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconcat:2.1 xlconcat ]
  set_property -dict [ list \
   CONFIG.NUM_PORTS {3} \
 ] $xlconcat

  # Create interface connections
  connect_bd_intf_net -intf_net Conn1 [get_bd_intf_pins sys_diff_clock] [get_bd_intf_pins clk_wiz/CLK_IN1_D]
  connect_bd_intf_net -intf_net Conn2 [get_bd_intf_pins IIC_0] [get_bd_intf_pins fmch_axi_iic1/IIC]
  connect_bd_intf_net -intf_net axi_interconnect_M09_AXI [get_bd_intf_pins axi_interconnect/M09_AXI] [get_bd_intf_pins fmch_axi_iic1/S_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_intc_interrupt [get_bd_intf_pins axi_intc/interrupt] [get_bd_intf_pins mblaze/INTERRUPT]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M00_AXI [get_bd_intf_pins M00_AXI] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M01_AXI [get_bd_intf_pins M01_AXI] [get_bd_intf_pins axi_interconnect/M01_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M02_AXI [get_bd_intf_pins M02_AXI] [get_bd_intf_pins axi_interconnect/M02_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M03_AXI [get_bd_intf_pins axi_interconnect/M03_AXI] [get_bd_intf_pins axi_uartlite/S_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M04_AXI [get_bd_intf_pins axi_interconnect/M04_AXI] [get_bd_intf_pins fmch_axi_iic/S_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M05_AXI [get_bd_intf_pins M05_AXI] [get_bd_intf_pins axi_interconnect/M05_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M06_AXI [get_bd_intf_pins M06_AXI] [get_bd_intf_pins axi_interconnect/M06_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M07_AXI [get_bd_intf_pins axi_intc/s_axi] [get_bd_intf_pins axi_interconnect/M07_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M08_AXI [get_bd_intf_pins M08_AXI] [get_bd_intf_pins axi_interconnect/M08_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_uartlite_UART [get_bd_intf_pins UART] [get_bd_intf_pins axi_uartlite/UART]
  connect_bd_intf_net -intf_net intf_net_dlmb_bram_if_cntlr_BRAM_PORT [get_bd_intf_pins dlmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTA]
  connect_bd_intf_net -intf_net intf_net_dlmb_v10_LMB_Sl_0 [get_bd_intf_pins dlmb_bram_if_cntlr/SLMB] [get_bd_intf_pins dlmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net intf_net_fmch_axi_iic_IIC [get_bd_intf_pins IIC] [get_bd_intf_pins fmch_axi_iic/IIC]
  connect_bd_intf_net -intf_net intf_net_ilmb_bram_if_cntlr_BRAM_PORT [get_bd_intf_pins ilmb_bram_if_cntlr/BRAM_PORT] [get_bd_intf_pins lmb_bram/BRAM_PORTB]
  connect_bd_intf_net -intf_net intf_net_ilmb_v10_LMB_Sl_0 [get_bd_intf_pins ilmb_bram_if_cntlr/SLMB] [get_bd_intf_pins ilmb_v10/LMB_Sl_0]
  connect_bd_intf_net -intf_net intf_net_mblaze_DLMB [get_bd_intf_pins dlmb_v10/LMB_M] [get_bd_intf_pins mblaze/DLMB]
  connect_bd_intf_net -intf_net intf_net_mblaze_ILMB [get_bd_intf_pins ilmb_v10/LMB_M] [get_bd_intf_pins mblaze/ILMB]
  connect_bd_intf_net -intf_net intf_net_mblaze_M_AXI_DP [get_bd_intf_pins axi_interconnect/S00_AXI] [get_bd_intf_pins mblaze/M_AXI_DP]
  connect_bd_intf_net -intf_net intf_net_mdm_MBDEBUG_0 [get_bd_intf_pins mblaze/DEBUG] [get_bd_intf_pins mdm/MBDEBUG_0]

  # Create port connections
  connect_bd_net -net net_bdry_in_ext_reset_in [get_bd_pins ext_reset_in] [get_bd_pins clk_wiz/reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net net_bdry_in_hdmi_rx_irq [get_bd_pins hdmi_rx_irq] [get_bd_pins xlconcat/In1]
  connect_bd_net -net net_bdry_in_hdmi_tx_irq [get_bd_pins hdmi_tx_irq] [get_bd_pins xlconcat/In2]
  connect_bd_net -net net_bdry_in_vphy_irq [get_bd_pins vphy_irq] [get_bd_pins xlconcat/In0]
  connect_bd_net -net net_clk_wiz_clk_out1 [get_bd_pins s_axi_aclk] [get_bd_pins axi_intc/s_axi_aclk] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/M02_ACLK] [get_bd_pins axi_interconnect/M03_ACLK] [get_bd_pins axi_interconnect/M04_ACLK] [get_bd_pins axi_interconnect/M06_ACLK] [get_bd_pins axi_interconnect/M07_ACLK] [get_bd_pins axi_interconnect/M09_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins axi_uartlite/s_axi_aclk] [get_bd_pins clk_wiz/clk_out1] [get_bd_pins dlmb_bram_if_cntlr/LMB_Clk] [get_bd_pins dlmb_v10/LMB_Clk] [get_bd_pins fmch_axi_iic/s_axi_aclk] [get_bd_pins fmch_axi_iic1/s_axi_aclk] [get_bd_pins ilmb_bram_if_cntlr/LMB_Clk] [get_bd_pins ilmb_v10/LMB_Clk] [get_bd_pins mblaze/Clk] [get_bd_pins rst_processor_1_100M/slowest_sync_clk]
  connect_bd_net -net net_clk_wiz_clk_out2 [get_bd_pins clk_out2] [get_bd_pins axi_interconnect/M05_ACLK] [get_bd_pins axi_interconnect/M08_ACLK] [get_bd_pins clk_wiz/clk_out2] [get_bd_pins rst_processor_1_300M/slowest_sync_clk]
  connect_bd_net -net net_clk_wiz_locked [get_bd_pins clk_wiz/locked] [get_bd_pins rst_processor_1_100M/aux_reset_in] [get_bd_pins rst_processor_1_100M/dcm_locked] [get_bd_pins rst_processor_1_300M/aux_reset_in] [get_bd_pins rst_processor_1_300M/dcm_locked]
  connect_bd_net -net net_mdm_Debug_SYS_Rst [get_bd_pins mdm/Debug_SYS_Rst] [get_bd_pins rst_processor_1_100M/mb_debug_sys_rst]
  connect_bd_net -net net_rst_processor_1_100M_bus_struct_reset [get_bd_pins dlmb_bram_if_cntlr/LMB_Rst] [get_bd_pins dlmb_v10/SYS_Rst] [get_bd_pins ilmb_bram_if_cntlr/LMB_Rst] [get_bd_pins ilmb_v10/SYS_Rst] [get_bd_pins rst_processor_1_100M/bus_struct_reset]
  connect_bd_net -net net_rst_processor_1_100M_interconnect_aresetn [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins rst_processor_1_100M/interconnect_aresetn]
  connect_bd_net -net net_rst_processor_1_100M_mb_reset [get_bd_pins mblaze/Reset] [get_bd_pins rst_processor_1_100M/mb_reset]
  connect_bd_net -net net_rst_processor_1_100M_peripheral_aresetn [get_bd_pins peripheral_aresetn] [get_bd_pins axi_intc/s_axi_aresetn] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins axi_interconnect/M03_ARESETN] [get_bd_pins axi_interconnect/M04_ARESETN] [get_bd_pins axi_interconnect/M06_ARESETN] [get_bd_pins axi_interconnect/M07_ARESETN] [get_bd_pins axi_interconnect/M09_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins axi_uartlite/s_axi_aresetn] [get_bd_pins fmch_axi_iic/s_axi_aresetn] [get_bd_pins fmch_axi_iic1/s_axi_aresetn] [get_bd_pins rst_processor_1_100M/peripheral_aresetn]
  connect_bd_net -net net_rst_processor_1_300M_interconnect_aresetn [get_bd_pins axi_interconnect/M05_ARESETN] [get_bd_pins axi_interconnect/M08_ARESETN] [get_bd_pins rst_processor_1_300M/interconnect_aresetn]
  connect_bd_net -net net_rst_processor_1_300M_peripheral_aresetn [get_bd_pins dcm_locked] [get_bd_pins rst_processor_1_300M/peripheral_aresetn]
  connect_bd_net -net net_xlconcat_dout [get_bd_pins axi_intc/intr] [get_bd_pins xlconcat/dout]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins rst_processor_1_100M/ext_reset_in] [get_bd_pins rst_processor_1_300M/ext_reset_in] [get_bd_pins util_vector_logic_0/Res]

  # Restore current instance
  current_bd_instance $oldCurInst
}

# Hierarchical cell: audio_ss_0
proc create_hier_cell_audio_ss_0 { parentCell nameHier } {

  variable script_folder

  if { $parentCell eq "" || $nameHier eq "" } {
     catch {common::send_msg_id "BD_TCL-102" "ERROR" "create_hier_cell_audio_ss_0() - Empty argument(s)!"}
     return
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj

  # Create cell and set as current instance
  set hier_obj [create_bd_cell -type hier $nameHier]
  current_bd_instance $hier_obj

  # Create interface pins
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:aximm_rtl:1.0 S00_AXI
  create_bd_intf_pin -mode Slave -vlnv xilinx.com:interface:axis_rtl:1.0 axis_audio_in
  create_bd_intf_pin -mode Master -vlnv xilinx.com:interface:axis_rtl:1.0 axis_audio_out

  # Create pins
  create_bd_pin -dir I -type clk ACLK
  create_bd_pin -dir I -type rst ARESETN
  create_bd_pin -dir I -from 19 -to 0 aud_acr_cts_in
  create_bd_pin -dir O -from 19 -to 0 aud_acr_cts_out
  create_bd_pin -dir I -from 19 -to 0 aud_acr_n_in
  create_bd_pin -dir O -from 19 -to 0 aud_acr_n_out
  create_bd_pin -dir I aud_acr_valid_in
  create_bd_pin -dir O aud_acr_valid_out
  create_bd_pin -dir O -type rst aud_rstn
  create_bd_pin -dir O -type clk audio_clk
  create_bd_pin -dir I -type clk hdmi_clk

  # Create instance: aud_pat_gen, and set properties
  set block_name aud_pat_gen
  set block_cell_name aud_pat_gen
  if { [catch {set aud_pat_gen [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $aud_pat_gen eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.MAX_BURST_LENGTH {1} \
 ] [get_bd_intf_pins /audio_ss_0/aud_pat_gen/axi]

  # Create instance: axi_interconnect, and set properties
  set axi_interconnect [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect ]
  set_property -dict [ list \
   CONFIG.NUM_MI {3} \
 ] $axi_interconnect

  # Create instance: clk_wiz, and set properties
  set clk_wiz [ create_bd_cell -type ip -vlnv xilinx.com:ip:clk_wiz:5.4 clk_wiz ]
  set_property -dict [ list \
   CONFIG.CLKOUT1_DRIVES {BUFG} \
   CONFIG.CLKOUT1_JITTER {130.958} \
   CONFIG.CLKOUT1_PHASE_ERROR {98.575} \
   CONFIG.CLKOUT2_DRIVES {Buffer} \
   CONFIG.CLKOUT3_DRIVES {Buffer} \
   CONFIG.CLKOUT4_DRIVES {Buffer} \
   CONFIG.CLKOUT5_DRIVES {Buffer} \
   CONFIG.CLKOUT6_DRIVES {Buffer} \
   CONFIG.CLKOUT7_DRIVES {Buffer} \
   CONFIG.MMCM_CLKFBOUT_MULT_F {12.000} \
   CONFIG.MMCM_CLKOUT0_DIVIDE_F {12.000} \
   CONFIG.MMCM_COMPENSATION {AUTO} \
   CONFIG.PHASESHIFT_MODE {WAVEFORM} \
   CONFIG.PRIM_SOURCE {No_buffer} \
   CONFIG.USE_DYN_RECONFIG {true} \
 ] $clk_wiz

  # Create instance: hdmi_acr_ctrl, and set properties
  set block_name hdmi_acr_ctrl
  set block_cell_name hdmi_acr_ctrl
  if { [catch {set hdmi_acr_ctrl [create_bd_cell -type module -reference $block_name $block_cell_name] } errmsg] } {
     catch {common::send_msg_id "BD_TCL-105" "ERROR" "Unable to add referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   } elseif { $hdmi_acr_ctrl eq "" } {
     catch {common::send_msg_id "BD_TCL-106" "ERROR" "Unable to referenced block <$block_name>. Please add the files for ${block_name}'s definition into the project."}
     return 1
   }
  
  set_property -dict [ list \
   CONFIG.SUPPORTS_NARROW_BURST {0} \
   CONFIG.NUM_READ_OUTSTANDING {1} \
   CONFIG.NUM_WRITE_OUTSTANDING {1} \
   CONFIG.MAX_BURST_LENGTH {1} \
 ] [get_bd_intf_pins /audio_ss_0/hdmi_acr_ctrl/axi]

  # Create interface connections
  connect_bd_intf_net -intf_net intf_net_aud_pat_gen_axis_audio_out [get_bd_intf_pins axis_audio_out] [get_bd_intf_pins aud_pat_gen/axis_audio_out]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M00_AXI [get_bd_intf_pins aud_pat_gen/axi] [get_bd_intf_pins axi_interconnect/M00_AXI]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M01_AXI [get_bd_intf_pins axi_interconnect/M01_AXI] [get_bd_intf_pins hdmi_acr_ctrl/axi]
  connect_bd_intf_net -intf_net intf_net_axi_interconnect_M02_AXI [get_bd_intf_pins axi_interconnect/M02_AXI] [get_bd_intf_pins clk_wiz/s_axi_lite]
  connect_bd_intf_net -intf_net intf_net_bdry_in_S00_AXI [get_bd_intf_pins S00_AXI] [get_bd_intf_pins axi_interconnect/S00_AXI]
  connect_bd_intf_net -intf_net intf_net_bdry_in_axis_audio_in [get_bd_intf_pins axis_audio_in] [get_bd_intf_pins aud_pat_gen/axis_audio_in]

  # Create port connections
  connect_bd_net -net net_bdry_in_ACLK [get_bd_pins ACLK] [get_bd_pins aud_pat_gen/axi_aclk] [get_bd_pins axi_interconnect/ACLK] [get_bd_pins axi_interconnect/M00_ACLK] [get_bd_pins axi_interconnect/M01_ACLK] [get_bd_pins axi_interconnect/M02_ACLK] [get_bd_pins axi_interconnect/S00_ACLK] [get_bd_pins clk_wiz/clk_in1] [get_bd_pins clk_wiz/s_axi_aclk] [get_bd_pins hdmi_acr_ctrl/axi_aclk]
  connect_bd_net -net net_bdry_in_ARESETN [get_bd_pins ARESETN] [get_bd_pins aud_pat_gen/axi_aresetn] [get_bd_pins axi_interconnect/ARESETN] [get_bd_pins axi_interconnect/M00_ARESETN] [get_bd_pins axi_interconnect/M01_ARESETN] [get_bd_pins axi_interconnect/M02_ARESETN] [get_bd_pins axi_interconnect/S00_ARESETN] [get_bd_pins clk_wiz/s_axi_aresetn] [get_bd_pins hdmi_acr_ctrl/axi_aresetn]
  connect_bd_net -net net_bdry_in_aud_acr_cts_in [get_bd_pins aud_acr_cts_in] [get_bd_pins hdmi_acr_ctrl/aud_acr_cts_in]
  connect_bd_net -net net_bdry_in_aud_acr_n_in [get_bd_pins aud_acr_n_in] [get_bd_pins hdmi_acr_ctrl/aud_acr_n_in]
  connect_bd_net -net net_bdry_in_aud_acr_valid_in [get_bd_pins aud_acr_valid_in] [get_bd_pins hdmi_acr_ctrl/aud_acr_valid_in]
  connect_bd_net -net net_bdry_in_hdmi_clk [get_bd_pins hdmi_clk] [get_bd_pins hdmi_acr_ctrl/hdmi_clk]
  connect_bd_net -net net_clk_wiz_clk_out1 [get_bd_pins audio_clk] [get_bd_pins aud_pat_gen/aud_clk] [get_bd_pins aud_pat_gen/axis_clk] [get_bd_pins clk_wiz/clk_out1] [get_bd_pins hdmi_acr_ctrl/aud_clk]
  connect_bd_net -net net_clk_wiz_locked [get_bd_pins clk_wiz/locked] [get_bd_pins hdmi_acr_ctrl/pll_lock_in]
  connect_bd_net -net net_hdmi_acr_ctrl_aud_acr_cts_out [get_bd_pins aud_acr_cts_out] [get_bd_pins hdmi_acr_ctrl/aud_acr_cts_out]
  connect_bd_net -net net_hdmi_acr_ctrl_aud_acr_n_out [get_bd_pins aud_acr_n_out] [get_bd_pins hdmi_acr_ctrl/aud_acr_n_out]
  connect_bd_net -net net_hdmi_acr_ctrl_aud_acr_valid_out [get_bd_pins aud_acr_valid_out] [get_bd_pins hdmi_acr_ctrl/aud_acr_valid_out]
  connect_bd_net -net net_hdmi_acr_ctrl_aud_resetn_out [get_bd_pins aud_rstn] [get_bd_pins aud_pat_gen/axis_resetn] [get_bd_pins hdmi_acr_ctrl/aud_resetn_out]

  # Restore current instance
  current_bd_instance $oldCurInst
}


# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  variable script_folder
  variable design_name

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     catch {common::send_msg_id "BD_TCL-100" "ERROR" "Unable to find parent cell <$parentCell>!"}
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     catch {common::send_msg_id "BD_TCL-101" "ERROR" "Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."}
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set RX_DDC_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 RX_DDC_OUT ]
  set TX_DDC_OUT [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 TX_DDC_OUT ]
  set iic_dp159 [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_dp159 ]
  set iic_hdmi_clock [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:iic_rtl:1.0 iic_hdmi_clock ]
  set rs232_uart [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:uart_rtl:1.0 rs232_uart ]
  set sys_diff_clock [ create_bd_intf_port -mode Slave -vlnv xilinx.com:interface:diff_clock_rtl:1.0 sys_diff_clock ]
  set_property -dict [ list \
   CONFIG.FREQ_HZ {200000000} \
   ] $sys_diff_clock

  # Create ports
  set HDMI_RX_CLK_N_IN [ create_bd_port -dir I HDMI_RX_CLK_N_IN ]
  set HDMI_RX_CLK_P_IN [ create_bd_port -dir I HDMI_RX_CLK_P_IN ]
  set HDMI_RX_DAT_N_IN [ create_bd_port -dir I -from 2 -to 0 HDMI_RX_DAT_N_IN ]
  set HDMI_RX_DAT_P_IN [ create_bd_port -dir I -from 2 -to 0 HDMI_RX_DAT_P_IN ]
  set HDMI_TX_CLK_N_OUT [ create_bd_port -dir O HDMI_TX_CLK_N_OUT ]
  set HDMI_TX_CLK_P_OUT [ create_bd_port -dir O HDMI_TX_CLK_P_OUT ]
  set HDMI_TX_DAT_N_OUT [ create_bd_port -dir O -from 2 -to 0 HDMI_TX_DAT_N_OUT ]
  set HDMI_TX_DAT_P_OUT [ create_bd_port -dir O -from 2 -to 0 HDMI_TX_DAT_P_OUT ]
  set IDT_8T49N241_LOL_IN [ create_bd_port -dir I IDT_8T49N241_LOL_IN ]
  set RX_DET_IN [ create_bd_port -dir I RX_DET_IN ]
  set RX_HPD_OUT [ create_bd_port -dir O -from 0 -to 0 RX_HPD_OUT ]
  set RX_REFCLK_N_OUT [ create_bd_port -dir O RX_REFCLK_N_OUT ]
  set RX_REFCLK_P_OUT [ create_bd_port -dir O RX_REFCLK_P_OUT ]
  set TX_EN_OUT [ create_bd_port -dir O -from 0 -to 0 TX_EN_OUT ]
  set TX_HPD_IN [ create_bd_port -dir I TX_HPD_IN ]
  set TX_REFCLK_N_IN [ create_bd_port -dir I TX_REFCLK_N_IN ]
  set TX_REFCLK_P_IN [ create_bd_port -dir I TX_REFCLK_P_IN ]
  set hdmi_clock_rst [ create_bd_port -dir O -from 0 -to 0 hdmi_clock_rst ]
  set reset [ create_bd_port -dir I -type rst reset ]
  set_property -dict [ list \
   CONFIG.POLARITY {ACTIVE_HIGH} \
 ] $reset

  # Create instance: audio_ss_0
  create_hier_cell_audio_ss_0 [current_bd_instance .] audio_ss_0

  # Create instance: mb_ss_0
  create_hier_cell_mb_ss_0 [current_bd_instance .] mb_ss_0

  # Create instance: rx_video_axis_reg_slice, and set properties
  set rx_video_axis_reg_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 rx_video_axis_reg_slice ]

  # Create instance: tx_video_axis_reg_slice, and set properties
  set tx_video_axis_reg_slice [ create_bd_cell -type ip -vlnv xilinx.com:ip:axis_register_slice:1.1 tx_video_axis_reg_slice ]

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
   CONFIG.C_OPERATION {not} \
   CONFIG.C_SIZE {1} \
   CONFIG.LOGO_FILE {data/sym_notgate.png} \
 ] $util_vector_logic_0

  # Create instance: v_hdmi_rx_ss, and set properties
  set v_hdmi_rx_ss [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_rx_ss:3.0 v_hdmi_rx_ss ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {10} \
   CONFIG.C_CD_INVERT {true} \
   CONFIG.C_EDID_RAM_SIZE {256} \
   CONFIG.C_EXDES_NIDRU {true} \
   CONFIG.C_EXDES_RX_PLL_SELECTION {3} \
   CONFIG.C_EXDES_TOPOLOGY {0} \
   CONFIG.C_EXDES_TX_PLL_SELECTION {0} \
   CONFIG.C_HDMI_FAST_SWITCH {true} \
   CONFIG.C_HDMI_VERSION {2} \
   CONFIG.C_HPD_INVERT {false} \
   CONFIG.C_INCLUDE_HDCP_1_4 {false} \
   CONFIG.C_INCLUDE_HDCP_2_2 {false} \
   CONFIG.C_INCLUDE_LOW_RESO_VID {false} \
   CONFIG.C_INCLUDE_YUV420_SUP {false} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
   CONFIG.C_VALIDATION_ENABLE {false} \
   CONFIG.C_VID_INTERFACE {0} \
 ] $v_hdmi_rx_ss

  # Create instance: v_hdmi_tx_ss, and set properties
  set v_hdmi_tx_ss [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_hdmi_tx_ss:3.0 v_hdmi_tx_ss ]
  set_property -dict [ list \
   CONFIG.C_ADDR_WIDTH {10} \
   CONFIG.C_EXDES_RX_PLL_SELECTION {3} \
   CONFIG.C_EXDES_TX_PLL_SELECTION {0} \
   CONFIG.C_HDMI_FAST_SWITCH {true} \
   CONFIG.C_HDMI_VERSION {2} \
   CONFIG.C_HPD_INVERT {false} \
   CONFIG.C_HYSTERESIS_LEVEL {12} \
   CONFIG.C_INCLUDE_HDCP_1_4 {false} \
   CONFIG.C_INCLUDE_HDCP_2_2 {false} \
   CONFIG.C_INCLUDE_LOW_RESO_VID {false} \
   CONFIG.C_INCLUDE_YUV420_SUP {false} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_MAX_BITS_PER_COMPONENT {8} \
   CONFIG.C_VALIDATION_ENABLE {false} \
   CONFIG.C_VID_INTERFACE {0} \
 ] $v_hdmi_tx_ss

  # Create instance: v_tpg_ss_0
  create_hier_cell_v_tpg_ss_0 [current_bd_instance .] v_tpg_ss_0

  # Create instance: vcc_const, and set properties
  set vcc_const [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 vcc_const ]
  set_property -dict [ list \
   CONFIG.CONST_VAL {1} \
 ] $vcc_const

  # Create instance: vid_phy_controller, and set properties
  set vid_phy_controller [ create_bd_cell -type ip -vlnv xilinx.com:ip:vid_phy_controller:2.1 vid_phy_controller ]
  set_property -dict [ list \
   CONFIG.CHANNEL_ENABLE {X0Y12 X0Y13 X0Y14} \
   CONFIG.CHANNEL_SITE {X0Y12} \
   CONFIG.C_INPUT_PIXELS_PER_CLOCK {2} \
   CONFIG.C_INT_HDMI_VER_CMPTBLE {2} \
   CONFIG.C_NIDRU {false} \
   CONFIG.C_NIDRU_REFCLK_SEL {0} \
   CONFIG.C_RX_PLL_SELECTION {6} \
   CONFIG.C_RX_REFCLK_SEL {0} \
   CONFIG.C_Rx_No_Of_Channels {3} \
   CONFIG.C_Rx_Outclk_Buffer {bufg} \
   CONFIG.C_Rx_Protocol {HDMI} \
   CONFIG.C_TX_PLL_SELECTION {0} \
   CONFIG.C_TX_REFCLK_SEL {1} \
   CONFIG.C_Tx_No_Of_Channels {3} \
   CONFIG.C_Tx_Outclk_Buffer {bufg} \
   CONFIG.C_Tx_Protocol {HDMI} \
   CONFIG.C_Tx_Refclk_Fabric_Buffer {bufg} \
   CONFIG.C_Tx_Tmds_Clk_Buffer {none} \
   CONFIG.C_Txrefclk_Rdy_Invert {true} \
   CONFIG.C_Use_Oddr_for_Tmds_Clkout {true} \
   CONFIG.C_vid_phy_rx_axi4s_ch_TDATA_WIDTH {40} \
   CONFIG.C_vid_phy_rx_axi4s_ch_TUSER_WIDTH {1} \
   CONFIG.C_vid_phy_tx_axi4s_ch_TDATA_WIDTH {40} \
   CONFIG.C_vid_phy_tx_axi4s_ch_TUSER_WIDTH {1} \
   CONFIG.DRPCLK_FREQ {100.0} \
   CONFIG.Rx_GT_Line_Rate {5.94} \
   CONFIG.Rx_GT_Ref_Clock_Freq {297} \
   CONFIG.Rx_Max_GT_Line_Rate {5.94} \
   CONFIG.Transceiver {GTHE4} \
   CONFIG.Transceiver_Width {4} \
   CONFIG.Tx_Buffer_Bypass {true} \
   CONFIG.Tx_GT_Line_Rate {5.94} \
   CONFIG.Tx_GT_Ref_Clock_Freq {297} \
   CONFIG.Tx_Max_GT_Line_Rate {5.94} \
   CONFIG.check_pll_selection {0} \
 ] $vid_phy_controller

  # Create interface connections
  connect_bd_intf_net -intf_net intf_net_audio_ss_0_axis_audio_out [get_bd_intf_pins audio_ss_0/axis_audio_out] [get_bd_intf_pins v_hdmi_tx_ss/AUDIO_IN]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_IIC [get_bd_intf_ports iic_dp159] [get_bd_intf_pins mb_ss_0/IIC]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M00_AXI [get_bd_intf_pins mb_ss_0/M00_AXI] [get_bd_intf_pins vid_phy_controller/vid_phy_axi4lite]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M01_AXI [get_bd_intf_pins mb_ss_0/M01_AXI] [get_bd_intf_pins v_hdmi_rx_ss/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M02_AXI [get_bd_intf_pins mb_ss_0/M02_AXI] [get_bd_intf_pins v_hdmi_tx_ss/S_AXI_CPU_IN]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M05_AXI [get_bd_intf_pins mb_ss_0/M05_AXI] [get_bd_intf_pins v_tpg_ss_0/S_AXI_TPG]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M06_AXI [get_bd_intf_pins audio_ss_0/S00_AXI] [get_bd_intf_pins mb_ss_0/M06_AXI]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_M08_AXI [get_bd_intf_pins mb_ss_0/M08_AXI] [get_bd_intf_pins v_tpg_ss_0/S_AXI_GPIO]
  connect_bd_intf_net -intf_net intf_net_mb_ss_0_UART [get_bd_intf_ports rs232_uart] [get_bd_intf_pins mb_ss_0/UART]
  connect_bd_intf_net -intf_net intf_net_rx_video_axis_reg_slice_M_AXIS [get_bd_intf_pins rx_video_axis_reg_slice/M_AXIS] [get_bd_intf_pins v_tpg_ss_0/s_axis_video]
  connect_bd_intf_net -intf_net intf_net_tx_video_axis_reg_slice_M_AXIS [get_bd_intf_pins tx_video_axis_reg_slice/M_AXIS] [get_bd_intf_pins v_hdmi_tx_ss/VIDEO_IN]
  connect_bd_intf_net -intf_net intf_net_v_hdmi_rx_ss_AUDIO_OUT [get_bd_intf_pins audio_ss_0/axis_audio_in] [get_bd_intf_pins v_hdmi_rx_ss/AUDIO_OUT]
  connect_bd_intf_net -intf_net intf_net_v_hdmi_rx_ss_DDC_OUT [get_bd_intf_ports RX_DDC_OUT] [get_bd_intf_pins v_hdmi_rx_ss/DDC_OUT]
  connect_bd_intf_net -intf_net intf_net_v_hdmi_rx_ss_VIDEO_OUT [get_bd_intf_pins rx_video_axis_reg_slice/S_AXIS] [get_bd_intf_pins v_hdmi_rx_ss/VIDEO_OUT]
  connect_bd_intf_net -intf_net intf_net_v_hdmi_tx_ss_DDC_OUT [get_bd_intf_ports TX_DDC_OUT] [get_bd_intf_pins v_hdmi_tx_ss/DDC_OUT]
  connect_bd_intf_net -intf_net intf_net_v_hdmi_tx_ss_LINK_DATA0_OUT [get_bd_intf_pins v_hdmi_tx_ss/LINK_DATA0_OUT] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch0]
  connect_bd_intf_net -intf_net intf_net_v_tpg_ss_0_m_axis_video [get_bd_intf_pins tx_video_axis_reg_slice/S_AXIS] [get_bd_intf_pins v_tpg_ss_0/m_axis_video]
  connect_bd_intf_net -intf_net intf_net_vid_phy_controller_vid_phy_rx_axi4s_ch0 [get_bd_intf_pins v_hdmi_rx_ss/LINK_DATA0_IN] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch0]
  connect_bd_intf_net -intf_net intf_net_vid_phy_controller_vid_phy_status_sb_rx [get_bd_intf_pins v_hdmi_rx_ss/SB_STATUS_IN] [get_bd_intf_pins vid_phy_controller/vid_phy_status_sb_rx]
  connect_bd_intf_net -intf_net intf_net_vid_phy_controller_vid_phy_status_sb_tx [get_bd_intf_pins v_hdmi_tx_ss/SB_STATUS_IN] [get_bd_intf_pins vid_phy_controller/vid_phy_status_sb_tx]
  connect_bd_intf_net -intf_net mb_ss_0_IIC_0 [get_bd_intf_ports iic_hdmi_clock] [get_bd_intf_pins mb_ss_0/IIC_0]
  connect_bd_intf_net -intf_net sys_diff_clock_1 [get_bd_intf_ports sys_diff_clock] [get_bd_intf_pins mb_ss_0/sys_diff_clock]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_LINK_DATA1_OUT [get_bd_intf_pins v_hdmi_tx_ss/LINK_DATA1_OUT] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch1]
  connect_bd_intf_net -intf_net v_hdmi_tx_ss_LINK_DATA2_OUT [get_bd_intf_pins v_hdmi_tx_ss/LINK_DATA2_OUT] [get_bd_intf_pins vid_phy_controller/vid_phy_tx_axi4s_ch2]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_rx_axi4s_ch1 [get_bd_intf_pins v_hdmi_rx_ss/LINK_DATA1_IN] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch1]
  connect_bd_intf_net -intf_net vid_phy_controller_vid_phy_rx_axi4s_ch2 [get_bd_intf_pins v_hdmi_rx_ss/LINK_DATA2_IN] [get_bd_intf_pins vid_phy_controller/vid_phy_rx_axi4s_ch2]

  # Create port connections
  connect_bd_net -net net_audio_ss_0_aud_acr_cts_out [get_bd_pins audio_ss_0/aud_acr_cts_out] [get_bd_pins v_hdmi_tx_ss/acr_cts]
  connect_bd_net -net net_audio_ss_0_aud_acr_n_out [get_bd_pins audio_ss_0/aud_acr_n_out] [get_bd_pins v_hdmi_tx_ss/acr_n]
  connect_bd_net -net net_audio_ss_0_aud_acr_valid_out [get_bd_pins audio_ss_0/aud_acr_valid_out] [get_bd_pins v_hdmi_tx_ss/acr_valid]
  connect_bd_net -net net_audio_ss_0_aud_rstn [get_bd_pins audio_ss_0/aud_rstn] [get_bd_pins v_hdmi_rx_ss/s_axis_audio_aresetn] [get_bd_pins v_hdmi_tx_ss/s_axis_audio_aresetn]
  connect_bd_net -net net_audio_ss_0_audio_clk [get_bd_pins audio_ss_0/audio_clk] [get_bd_pins v_hdmi_rx_ss/s_axis_audio_aclk] [get_bd_pins v_hdmi_tx_ss/s_axis_audio_aclk]
  connect_bd_net -net net_bdry_in_HDMI_RX_CLK_N_IN [get_bd_ports HDMI_RX_CLK_N_IN] [get_bd_pins vid_phy_controller/mgtrefclk0_pad_n_in]
  connect_bd_net -net net_bdry_in_HDMI_RX_CLK_P_IN [get_bd_ports HDMI_RX_CLK_P_IN] [get_bd_pins vid_phy_controller/mgtrefclk0_pad_p_in]
  connect_bd_net -net net_bdry_in_HDMI_RX_DAT_N_IN [get_bd_ports HDMI_RX_DAT_N_IN] [get_bd_pins vid_phy_controller/phy_rxn_in]
  connect_bd_net -net net_bdry_in_HDMI_RX_DAT_P_IN [get_bd_ports HDMI_RX_DAT_P_IN] [get_bd_pins vid_phy_controller/phy_rxp_in]
  connect_bd_net -net net_bdry_in_RX_DET_IN [get_bd_ports RX_DET_IN] [get_bd_pins v_hdmi_rx_ss/cable_detect]
  connect_bd_net -net net_bdry_in_SI5324_LOL_IN [get_bd_ports IDT_8T49N241_LOL_IN] [get_bd_pins vid_phy_controller/tx_refclk_rdy]
  connect_bd_net -net net_bdry_in_TX_HPD_IN [get_bd_ports TX_HPD_IN] [get_bd_pins v_hdmi_tx_ss/hpd]
  connect_bd_net -net net_bdry_in_TX_REFCLK_N_IN [get_bd_ports TX_REFCLK_N_IN] [get_bd_pins vid_phy_controller/mgtrefclk1_pad_n_in]
  connect_bd_net -net net_bdry_in_TX_REFCLK_P_IN [get_bd_ports TX_REFCLK_P_IN] [get_bd_pins vid_phy_controller/mgtrefclk1_pad_p_in]
  connect_bd_net -net net_mb_ss_0_clk_out2 [get_bd_pins mb_ss_0/clk_out2] [get_bd_pins rx_video_axis_reg_slice/aclk] [get_bd_pins tx_video_axis_reg_slice/aclk] [get_bd_pins v_hdmi_rx_ss/s_axis_video_aclk] [get_bd_pins v_hdmi_tx_ss/s_axis_video_aclk] [get_bd_pins v_tpg_ss_0/ap_clk]
  connect_bd_net -net net_mb_ss_0_dcm_locked [get_bd_pins mb_ss_0/dcm_locked] [get_bd_pins rx_video_axis_reg_slice/aresetn] [get_bd_pins tx_video_axis_reg_slice/aresetn] [get_bd_pins v_hdmi_rx_ss/s_axis_video_aresetn] [get_bd_pins v_hdmi_tx_ss/s_axis_video_aresetn] [get_bd_pins v_tpg_ss_0/m_axi_aresetn]
  connect_bd_net -net net_mb_ss_0_peripheral_aresetn [get_bd_pins audio_ss_0/ARESETN] [get_bd_pins mb_ss_0/peripheral_aresetn] [get_bd_pins v_hdmi_rx_ss/s_axi_cpu_aresetn] [get_bd_pins v_hdmi_tx_ss/s_axi_cpu_aresetn] [get_bd_pins vid_phy_controller/vid_phy_axi4lite_aresetn] [get_bd_pins vid_phy_controller/vid_phy_sb_aresetn]
  connect_bd_net -net net_mb_ss_0_s_axi_aclk [get_bd_pins audio_ss_0/ACLK] [get_bd_pins mb_ss_0/s_axi_aclk] [get_bd_pins v_hdmi_rx_ss/s_axi_cpu_aclk] [get_bd_pins v_hdmi_tx_ss/s_axi_cpu_aclk] [get_bd_pins vid_phy_controller/drpclk] [get_bd_pins vid_phy_controller/vid_phy_axi4lite_aclk] [get_bd_pins vid_phy_controller/vid_phy_sb_aclk]
  connect_bd_net -net net_v_hdmi_rx_ss_acr_cts [get_bd_pins audio_ss_0/aud_acr_cts_in] [get_bd_pins v_hdmi_rx_ss/acr_cts]
  connect_bd_net -net net_v_hdmi_rx_ss_acr_n [get_bd_pins audio_ss_0/aud_acr_n_in] [get_bd_pins v_hdmi_rx_ss/acr_n]
  connect_bd_net -net net_v_hdmi_rx_ss_acr_valid [get_bd_pins audio_ss_0/aud_acr_valid_in] [get_bd_pins v_hdmi_rx_ss/acr_valid]
  connect_bd_net -net net_v_hdmi_rx_ss_fid [get_bd_pins v_hdmi_rx_ss/fid] [get_bd_pins v_hdmi_tx_ss/fid]
  connect_bd_net -net net_v_hdmi_rx_ss_hpd [get_bd_ports RX_HPD_OUT] [get_bd_pins v_hdmi_rx_ss/hpd]
  connect_bd_net -net net_v_hdmi_rx_ss_irq [get_bd_pins mb_ss_0/hdmi_rx_irq] [get_bd_pins v_hdmi_rx_ss/irq]
  connect_bd_net -net net_v_hdmi_tx_ss_irq [get_bd_pins mb_ss_0/hdmi_tx_irq] [get_bd_pins v_hdmi_tx_ss/irq]
  connect_bd_net -net net_vcc_const_dout [get_bd_ports TX_EN_OUT] [get_bd_ports hdmi_clock_rst] [get_bd_pins vcc_const/dout] [get_bd_pins vid_phy_controller/vid_phy_rx_axi4s_aresetn] [get_bd_pins vid_phy_controller/vid_phy_tx_axi4s_aresetn]
  connect_bd_net -net net_vid_phy_controller_irq [get_bd_pins mb_ss_0/vphy_irq] [get_bd_pins vid_phy_controller/irq]
  connect_bd_net -net net_vid_phy_controller_phy_txn_out [get_bd_ports HDMI_TX_DAT_N_OUT] [get_bd_pins vid_phy_controller/phy_txn_out]
  connect_bd_net -net net_vid_phy_controller_phy_txp_out [get_bd_ports HDMI_TX_DAT_P_OUT] [get_bd_pins vid_phy_controller/phy_txp_out]
  connect_bd_net -net net_vid_phy_controller_rx_tmds_clk_n [get_bd_ports RX_REFCLK_N_OUT] [get_bd_pins vid_phy_controller/rx_tmds_clk_n]
  connect_bd_net -net net_vid_phy_controller_rx_tmds_clk_p [get_bd_ports RX_REFCLK_P_OUT] [get_bd_pins vid_phy_controller/rx_tmds_clk_p]
  connect_bd_net -net net_vid_phy_controller_rx_video_clk [get_bd_pins v_hdmi_rx_ss/video_clk] [get_bd_pins vid_phy_controller/rx_video_clk]
  connect_bd_net -net net_vid_phy_controller_rxoutclk [get_bd_pins v_hdmi_rx_ss/link_clk] [get_bd_pins vid_phy_controller/rxoutclk] [get_bd_pins vid_phy_controller/vid_phy_rx_axi4s_aclk]
  connect_bd_net -net net_vid_phy_controller_tx_tmds_clk [get_bd_pins audio_ss_0/hdmi_clk] [get_bd_pins vid_phy_controller/tx_tmds_clk]
  connect_bd_net -net net_vid_phy_controller_tx_tmds_clk_n [get_bd_ports HDMI_TX_CLK_N_OUT] [get_bd_pins vid_phy_controller/tx_tmds_clk_n]
  connect_bd_net -net net_vid_phy_controller_tx_tmds_clk_p [get_bd_ports HDMI_TX_CLK_P_OUT] [get_bd_pins vid_phy_controller/tx_tmds_clk_p]
  connect_bd_net -net net_vid_phy_controller_tx_video_clk [get_bd_pins v_hdmi_tx_ss/video_clk] [get_bd_pins vid_phy_controller/tx_video_clk]
  connect_bd_net -net net_vid_phy_controller_txoutclk [get_bd_pins v_hdmi_tx_ss/link_clk] [get_bd_pins vid_phy_controller/txoutclk] [get_bd_pins vid_phy_controller/vid_phy_tx_axi4s_aclk]
  connect_bd_net -net reset_1 [get_bd_ports reset] [get_bd_pins util_vector_logic_0/Op1]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins mb_ss_0/ext_reset_in] [get_bd_pins util_vector_logic_0/Res]

  # Create address segments
  create_bd_addr_seg -range 0x00010000 -offset 0x80000000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs audio_ss_0/aud_pat_gen/axi/reg0] SEG_aud_pat_gen_reg0
  create_bd_addr_seg -range 0x00010000 -offset 0x40000000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs v_tpg_ss_0/axi_gpio/S_AXI/Reg] SEG_axi_gpio_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x41200000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs mb_ss_0/axi_intc/S_AXI/Reg] SEG_axi_intc_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40600000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs mb_ss_0/axi_uartlite/S_AXI/Reg] SEG_axi_uartlite_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A10000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs audio_ss_0/clk_wiz/s_axi_lite/Reg] SEG_clk_wiz_Reg
  create_bd_addr_seg -range 0x00040000 -offset 0x00000000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs mb_ss_0/dlmb_bram_if_cntlr/SLMB/Mem] SEG_dlmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x40810000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs mb_ss_0/fmch_axi_iic1/S_AXI/Reg] SEG_fmch_axi_iic1_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x40800000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs mb_ss_0/fmch_axi_iic/S_AXI/Reg] SEG_fmch_axi_iic_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0xC0000000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs audio_ss_0/hdmi_acr_ctrl/axi/reg0] SEG_hdmi_acr_ctrl_reg0
  create_bd_addr_seg -range 0x00040000 -offset 0x00000000 [get_bd_addr_spaces mb_ss_0/mblaze/Instruction] [get_bd_addr_segs mb_ss_0/ilmb_bram_if_cntlr/SLMB/Mem] SEG_ilmb_bram_if_cntlr_Mem
  create_bd_addr_seg -range 0x00010000 -offset 0x44A00000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs v_hdmi_rx_ss/S_AXI_CPU_IN/Reg] SEG_v_hdmi_rx_ss_Reg
  create_bd_addr_seg -range 0x00020000 -offset 0x44A20000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs v_hdmi_tx_ss/S_AXI_CPU_IN/Reg] SEG_v_hdmi_tx_ss_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A40000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs v_tpg_ss_0/v_tpg/s_axi_CTRL/Reg] SEG_v_tpg_Reg
  create_bd_addr_seg -range 0x00010000 -offset 0x44A50000 [get_bd_addr_spaces mb_ss_0/mblaze/Data] [get_bd_addr_segs vid_phy_controller/vid_phy_axi4lite/Reg] SEG_vid_phy_controller_Reg


  # Restore current instance
  current_bd_instance $oldCurInst

  validate_bd_design
  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


