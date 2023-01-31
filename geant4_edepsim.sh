#!/bin/bash

# Install GEANT4 and EDEP-SIM
# https://geant4-userdoc.web.cern.ch/UsersGuides/InstallationGuide/html/installguide.html

# Create a new directory and setup environment variables

cd /dune/app/users/mazam && mkdir work_geant4_edepsim && cd work_geant4_edepsim

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh 
setup duneutil v09_42_02_00 -q e20:prof 
setup_fnal_security 

setup root v6_16_00 -q e17:prof

wget https://geant4-data.web.cern.ch/releases/geant4-v11.0.3.tar.gz --no-check-certificate

tar -xf geant4-v11.0.3.tar.gz
rm -r geant4-v11.0.3.tar.gz

git clone https://github.com/ClarkMcGrew/edep-sim.git

setup geant4 v4_11_0_p01c -q e20:prof

cd /dune/app/users/mazam/work_geant4_edepsim

mkdir geant4-v11.0.3-build
cd geant4-v11.0.3-build

setup cmake v3_24_0

cmake -DCMAKE_INSTALL_PREFIX=/dune/app/users/mazam/work_geant4_edepsim/geant4-v11.0.3-build /dune/app/users/mazam/work_geant4_edepsim/geant4-v11.0.3

cmake -DGEANT4_USE_GDML=ON
cmake -DGEANT4_INSTALL_DATA=ON

make -j4

make install


cd /dune/app/users/mazam/work_geant4_edepsim/ && mkdir edep_sim && cd edep_sim

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh 
setup duneutil v09_42_02_00 -q e20:prof 
setup_fnal_security 

setup root v6_16_00 -q e17:prof

cd /dune/app/users/mazam/work_geant4_edepsim/geant4-v11.0.3-build

make install DESTDIR=/dune/app/users/mazam/work_geant4_edepsim/edep_sim

cd /dune/app/users/mazam/work_geant4_edepsim/edep-edep_sim

source /dune/app/users/mazam/work_geant4_edepsim/geant4-v11.0.3-build/bin/geant4.sh

. setup.sh

cmake -DGEANT4_USE_GDML=ON
cmake -DGEANT4_INSTALL_DATA=ON



# edep-sim -o my-output.root -g nd_hall_with_lar_tms_sand.gdml -u -e 100 muon-10000.mac

# edep-sim -o my-output.root -g anti_fiducial_nd_hall_with_lar_garlite_nosand.gdml -u -e 100 muon-10000.mac

edep-sim -o my-output.root -g example.gdml -u -e 100 muon-10000.mac
