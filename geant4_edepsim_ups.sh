#!/bin/bash

# Create a new directory and setup environment variables

cd /dune/app/users/mazam/working_area && mkdir work_geant4_edepsim && cd work_geant4_edepsim

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh 
setup duneutil v09_42_02_00 -q e20:prof 
setup_fnal_security 

setup cmake v3_24_0
setup root v6_22_08d -q e20:p392:prof
setup geant4 v4_11_0_p01c -q e20:prof
setup edepsim v3_2_0 -q e20:prof

cp /dune/app/users/mazam/gdml_files/* /dune/app/users/mazam/working_area/work_geant4_edepsim

cp /dune/app/users/mazam/edepsim_mac_files/* /dune/app/users/mazam/working_area/work_geant4_edepsim

edep-sim -o my-output.root -g example.gdml -u -e 100 muon-10000.mac

