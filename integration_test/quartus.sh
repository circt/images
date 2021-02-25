#!/bin/bash
# Downloads and installs Quartus and ModelSimAE into $/ext
# Includes the license file free device libraries and the
# license file free, restricted functionality ModelSim/Questa

cd /tmp
mkdir intel
cd intel

wget https://download.altera.com/akdlm/software/acdsinst/20.4/72/ib_tar/Quartus-pro-20.4.0.72-linux.tar
wget https://download.altera.com/akdlm/software/acdsinst/20.4/72/ib_tar/Quartus-pro-20.4.0.72-devices-3.tar

tar -xf Quartus-pro-20.4.0.72-linux.tar
tar -xf Quartus-pro-20.4.0.72-devices-3.tar

./setup_pro.sh --mode unattended --installdir /usr/local/intelFPGA_pro/20.4 --accept_eula 1 --disable-components quartus_help,devinfo,quartus_update,modelsim_ae

#Allowed: quartus quartus_help devinfo arria_lite cyclone cyclone10lp cyclonev max max10 quartus_update modelsim_ase modelsim_ae

cd /tmp
rm -r intel

