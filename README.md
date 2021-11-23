# Hdmi_Passthrough_AXU7EV_Microblaze

A basic project for using hdmi-rx and hdmi-tx ip, configure by a microblaze core, port for AXU7EV.

vivado ver: 2020.1

build steps:

1. source create_and_build_proj.tcl after setenv
   
   There is a bash script "proj_build.sh" for convenience in vivado folder, if vivado installed in /opt/Xilinx/
   
2. source create_n_build_SW_proj.tcl after setenv

   There is a proj_build.sh in vitis folder for convenience.

3. run post_build.sh

   Then a download.bin can be found in output folder.

Notice:
Because it a bare microblaze project, a fsbl is needed to generate BOOT.bin and flash to board.
