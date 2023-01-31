#!/bin/bash

# Create a new directory and setup environment variables

cd /dune/app/users/mazam/working_area && mkdir work_dunendggd && cd work_dunendggd

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8

# To install gegede, we will need virtualenv:
wget https://pypi.python.org/packages/source/v/virtualenv/virtualenv-1.11.tar.gz --no-check-certificate
tar -xf virtualenv-1.11.tar.gz
python virtualenv-1.11/virtualenv.py ggdvenv


# activate your virtual envoronment
source ggdvenv/bin/activate


# Move to the original directory
cd /dune/app/users/mazam/working_area/work_dunendggd/


git clone https://github.com/gyang9/dunendggd.git
cd dunendggd/


# Install relevant repositories for duneggd
pip install gegede==0.4
pip install Pint==0.5.1
pip install lxml==3.3.5

# install python for configuration-only use and set its path:
# If you intend to write python code (develop builders), then use “python setup.py develop” so that any changed code is recompiled each run. If you are just changing configuration files, “python setup.py install” will skip this recompilation, drawing from the distribution created at setup instead.
python setup.py develop
export PYTHONPATH=`pwd`/python


# In dunendggd, a script has been already provided to generate the geometry (as shown below) with the ND Hall (as of 27th Sept 2019) with the ND detectors (ArgonCube + ND-GAr + 3DST-S/K). Simply execute:
./build_hall.sh


# Copy all the geometry files
cp /dune/app/users/mazam/gdml_files/* /dune/app/users/mazam/working_area/work_dunendggd/dunendggd

# Setup root
source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh 
setup duneutil v09_42_02_00 -q e20:prof 
setup_fnal_security 

setup root v6_22_08d -q e20:p392:prof




# root -l 'geoDisplay.C("nd_hall_no_dets.gdml")'
# root -l 'geoDisplay.C("anti_fiducial_nd_hall_with_lar_gar_nosand.gdml")' 
# root -l 'geoDisplay.C("nd_hall_with_lar_garlite_nosand.gdml")'
# root -l 'geoDisplay.C(anti_fiducial_nd_hall_with_lar_garlite_nosand.gdml)'
# root -l 'geoDisplay.C(nd_hall_with_lar_garlite_sand.gdml)'
# root -l 'geoDisplay.C(anti_fiducial_nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'geoDisplay.C(nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'geoDisplay.C(nd_hall_with_lar_gar_nosand.gdml)'
# root -l 'geoDisplay.C(nd_hall_with_lar_tms_sand.gdml)'
root -l 'geoDisplay.C(nd_hall_with_lar_gar_sand.gdml)'


# The geometries can be viewed with the root script hallDisplay.C

# root -l 'hallDisplay.C("nd_hall_no_dets.gdml")'
# root -l 'hallDisplay.C("anti_fiducial_nd_hall_with_lar_gar_nosand.gdml")' 
# root -l 'hallDisplay.C("nd_hall_with_lar_garlite_nosand.gdml")'
# root -l 'hallDisplay.C(anti_fiducial_nd_hall_with_lar_garlite_nosand.gdml)'
# root -l 'hallDisplay.C(nd_hall_with_lar_garlite_sand.gdml)'
# root -l 'hallDisplay.C(anti_fiducial_nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'hallDisplay.C(nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'hallDisplay.C(nd_hall_with_lar_gar_nosand.gdml)'
# root -l 'hallDisplay.C(nd_hall_with_lar_tms_sand.gdml)'
# root -l 'hallDisplay.C(nd_hall_with_lar_gar_sand.gdml)'



# root -l 'generalDisplay.C("nd_hall_no_dets.gdml")'
# root -l 'generalDisplay.C("anti_fiducial_nd_hall_with_lar_gar_nosand.gdml")' 
# root -l 'generalDisplay.C("nd_hall_with_lar_garlite_nosand.gdml")'
# root -l 'generalDisplay.C(anti_fiducial_nd_hall_with_lar_garlite_nosand.gdml)'
# root -l 'generalDisplay.C(nd_hall_with_lar_garlite_sand.gdml)'
# root -l 'generalDisplay.C(anti_fiducial_nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'generalDisplay.C(nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'generalDisplay.C(nd_hall_with_lar_gar_nosand.gdml)'
# root -l 'generalDisplay.C(nd_hall_with_lar_tms_sand.gdml)'
# root -l 'generalDisplay.C(nd_hall_with_lar_gar_sand.gdml)'



# root -l 'materialDisplay.C("nd_hall_no_dets.gdml")'
# root -l 'materialDisplay.C("anti_fiducial_nd_hall_with_lar_gar_nosand.gdml")' 
# root -l 'materialDisplay.C("nd_hall_with_lar_garlite_nosand.gdml")'
# root -l 'materialDisplay.C(anti_fiducial_nd_hall_with_lar_garlite_nosand.gdml)'
# root -l 'materialDisplay.C(nd_hall_with_lar_garlite_sand.gdml)'
# root -l 'materialDisplay.C(anti_fiducial_nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'materialDisplay.C(nd_hall_with_lar_tms_nosand.gdml)'
# root -l 'materialDisplay.C(nd_hall_with_lar_gar_nosand.gdml)'
# root -l 'materialDisplay.C(nd_hall_with_lar_tms_sand.gdml)'
# root -l 'materialDisplay.C(nd_hall_with_lar_gar_sand.gdml)'



# At the command line, run chmod u+x YourScriptFileName.sh
