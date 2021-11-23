#!/bin/bash


source /opt/Xilinx/SDK/2017.4/settings64.sh
#updatemem -meminfo system_wrapper.mmi -data ../../Debug/vitis_proj.elf -proc system_i/microblaze_0 -bit system_wrapper.bit -out download.bit -force

#mkdir -p ../flash
#echo -e "the_ROM_image:\n{\n$PWD/download.bit\n}\n" > ../flash/bootimage.bif
#echo "bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi"
#bootgen -arch fpga -image ../flash/bootimage.bif -w -o ../flash/BOOT.bin -interface spi

#cd -
mkdir -p output
rm -rf output/*
#cp ./sdk_workspace/vitis_proj/_ide/flash/BOOT.bin ./output/app.bin
#cp ./sdk_workspace/vitis_proj/_ide/bitstream/download.bit ./output/
#cp ./sdk_workspace/system_wrapper/export/system_wrapper/sw/system_wrapper/boot/fsbl.elf ./output/

updatemem -meminfo ./sdk_workspace/system_wrapper/system_wrapper.mmi -data ./sdk_workspace/sdk_proj/Debug/sdk_proj.elf -proc system_i/mb_ss_0/mblaze -bit ./sdk_workspace/system_wrapper/system_wrapper.bit -out ./output/download.bit -force

#echo -e "//arch = zynq; split = false; format = BIN\nthe_ROM_image:\n{\n	[bootloader]$PWD/output/fsbl.elf\n	$PWD/output/download.bit\n}\n" > ./output/bootimage.bif
#bootgen -arch zynq -image ./output/bootimage.bif -o ./output/BOOT.bin -w on

