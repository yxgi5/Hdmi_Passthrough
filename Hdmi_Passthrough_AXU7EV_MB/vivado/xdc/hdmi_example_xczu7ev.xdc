#####
##XCZU7EV Pins
##(0)
set_property PACKAGE_PIN AJ9 [get_ports sys_diff_clock_clk_p]
set_property IOSTANDARD DIFF_SSTL15 [get_ports sys_diff_clock_clk_p]
set_property PACKAGE_PIN J9 [get_ports reset]
set_property IOSTANDARD LVCMOS33 [get_ports reset]
#
#set_property PACKAGE_PIN N9 [get_ports rs232_uart_rxd]
#set_property PACKAGE_PIN N8 [get_ports rs232_uart_txd]
set_property PACKAGE_PIN N8 [get_ports rs232_uart_rxd]
set_property PACKAGE_PIN N9 [get_ports rs232_uart_txd]
set_property IOSTANDARD LVCMOS33 [get_ports rs232_uart_rxd]
set_property IOSTANDARD LVCMOS33 [get_ports rs232_uart_txd]
##(1)HDMI RX,GT is at  X0Y12£¬GT bank---226
set_property PACKAGE_PIN V8 [get_ports HDMI_RX_CLK_P_IN]
#297MHz
#create_clock -name rx_mgt_refclk -period 3.367 [get_ports HDMI_RX_CLK_P_IN]
#-------rx_tmds_clk_p
set_property PACKAGE_PIN AP18 [get_ports RX_REFCLK_P_OUT]
set_property IOSTANDARD LVDS [get_ports RX_REFCLK_P_OUT]
#
##
#set_property PACKAGE_PIN W10 [get_ports DRU_CLK_IN_clk_p]
#
set_property PACKAGE_PIN B1 [get_ports {RX_HPD_OUT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {RX_HPD_OUT[0]}]
##
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_OUT_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports RX_DDC_OUT_sda_io]
set_property PACKAGE_PIN C2 [get_ports RX_DDC_OUT_scl_io]
set_property PACKAGE_PIN C1 [get_ports RX_DDC_OUT_sda_io]
##
set_property IOSTANDARD LVCMOS33 [get_ports RX_DET_IN]
set_property PACKAGE_PIN D2 [get_ports RX_DET_IN]
#(2)HDMI TX,GT is at  X0Y12£¬GT bank---226
set_property PACKAGE_PIN U10 [get_ports TX_REFCLK_P_IN]
#297MHz
#create_clock -name tx_mgt_refclk -period 3.367 [get_ports TX_REFCLK_P_IN]
#
set_property IOSTANDARD LVDS [get_ports HDMI_TX_CLK_P_OUT]
set_property PACKAGE_PIN AH18 [get_ports HDMI_TX_CLK_P_OUT]
##
set_property PACKAGE_PIN V4 [get_ports {HDMI_RX_DAT_P_IN[0]}]
set_property PACKAGE_PIN U6 [get_ports {HDMI_TX_DAT_P_OUT[0]}]
set_property PACKAGE_PIN U2 [get_ports {HDMI_RX_DAT_P_IN[1]}]
set_property PACKAGE_PIN T4 [get_ports {HDMI_TX_DAT_P_OUT[1]}]
set_property PACKAGE_PIN R2 [get_ports {HDMI_RX_DAT_P_IN[2]}]
set_property PACKAGE_PIN R6 [get_ports {HDMI_TX_DAT_P_OUT[2]}]
#
set_property IOSTANDARD LVCMOS33 [get_ports TX_HPD_IN]
set_property PACKAGE_PIN D1 [get_ports TX_HPD_IN]
#
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_OUT_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports TX_DDC_OUT_sda_io]
set_property PACKAGE_PIN E2 [get_ports TX_DDC_OUT_scl_io]
set_property PACKAGE_PIN E1 [get_ports TX_DDC_OUT_sda_io]
#
# TBD
# set_property PACKAGE_PIN G8 [get_ports tmds_clk_out]
# set_property IOSTANDARD LVCMOS33 [get_ports tmds_clk_out]
##(3)others
set_property PACKAGE_PIN F5 [get_ports {hdmi_clock_rst[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {hdmi_clock_rst[0]}]
#CLK_REC_SCL  CLK_REC_SDA
set_property PACKAGE_PIN J6 [get_ports iic_hdmi_clock_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_hdmi_clock_scl_io]
set_property PACKAGE_PIN J7 [get_ports iic_hdmi_clock_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_hdmi_clock_sda_io]
##DP159 is  hdmi  tx IC
set_property PACKAGE_PIN E4 [get_ports iic_dp159_scl_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_dp159_scl_io]
set_property PACKAGE_PIN D4 [get_ports iic_dp159_sda_io]
set_property IOSTANDARD LVCMOS33 [get_ports iic_dp159_sda_io]
##--8T49N24 is PLL IC
set_property PACKAGE_PIN D6 [get_ports IDT_8T49N241_LOL_IN]
set_property IOSTANDARD LVCMOS33 [get_ports IDT_8T49N241_LOL_IN]
##
set_property PACKAGE_PIN E3 [get_ports {TX_EN_OUT[0]}]
set_property IOSTANDARD LVCMOS33 [get_ports {TX_EN_OUT[0]}]
# TBD - not needed as it is duplicated of TX_EN_OUT
# set_property PACKAGE_PIN C2 [get_ports {RX_LS_OE[0]}]
# set_property IOSTANDARD LVCMOS33 [get_ports {RX_LS_OE[0]}]
#set_property PACKAGE_PIN M11 [get_ports reset]
#set_property IOSTANDARD LVCMOS33 [get_ports reset]





