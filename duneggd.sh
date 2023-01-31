#!/bin/bash

# duneggd - DUNE Geometries in GeGeDe
# https://github.com/DUNE/duneggd/blob/master/README.org


# Create a new directory and setup environment variables
cd /dune/app/users/mazam/working_area && mkdir work_duneggd && cd work_duneggd


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
cd /dune/app/users/mazam/working_area/work_duneggd/


# setup duneggd
git clone https://github.com/DUNE/duneggd.git
cd duneggd


# Install relevant repositories for duneggd
pip install gegede==0.4
pip install Pint==0.5.1
pip install lxml==3.3.5


# install python for configuration-only use and set its path:
# If you intend to write python code (develop builders), then use “python setup.py develop” so that any changed code is recompiled each run. If you are just changing configuration files, “python setup.py install” will skip this recompilation, drawing from the distribution created at setup instead.
python setup.py develop
export PYTHONPATH=`pwd`/python


# Now you are ready to run the geometry generation! The command is gegede-cli, and takes several arguments (type “gegede-cli -h” to see each option.) Here is the minimum command to create a geometry:
cd python/duneggd/fgt/
gegede-cli fgt.cfg -w World -o fgt.gdml
# “World” is the name of the top builder, as set in the configuration file fgt.cfg, and “fgt.gdml” is the intended output name. This will overwrite files existing in that name so be careful! The intended export format is interpreted from the -o name, in this case being GDML. Using “fgt.root” would have exported to ROOT format.


# At the command line, run chmod u+x YourScriptFileName.sh 
