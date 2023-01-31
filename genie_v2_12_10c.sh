#!/bin/bash

# Create a new directory and setup environment variables for GENIE v2.12.10c

cd /dune/app/users/mazam/working_area && mkdir work_genie_v2_12_10c && cd work_genie_v2_12_10c

# cd /dune/app/users/mazam/working_area/proposal/genie_v2_12_10c

export LANGUAGE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8


source /cvmfs/dune.opensciencegrid.org/products/dune/setup_dune.sh
setup duneutil v08_38_00 -q e17:prof 
setup_fnal_security 


setup ifdhc
setup jobsub_client
setup pycurl
setup cmake	v3_24_0
setup gcc v9_3_0
setup root v6_18_04b -q e17:prof:py3
setup geant4 v4_10_3_p03e -q e17:prof
setup edepsim v2_0_1 -q e17:prof
setup genie v2_12_10c -q e17:prof
setup genie_xsec v2_12_10 -q DefaultPlusValenciaMEC
setup genie_phyopt v2_12_10 -q dkcharmtau
setup nutools v2_27_11 -q e17:prof
setup dk2nugenie v01_06_01f -q e17:prof


                       
# Path to geometry file or whatever (.root is okay too)
export GEOMETRY="/dune/app/users/mazam/gdml_files/nd_hall_with_lar_tms_nosand.gdml" 


# top volume in which to generate
export TOPVOL="volArgonCubeDetector"


# file naming prefix
export GPREFIX="genieV21210c"


# default generator list (no MEC) or see https://cdcvs.fnal.gov/redmine/projects/genie/wiki/Running_gevgen_fnal
# but might be "Default+CCMEC+NCMEC" or some such
# "Default+CCMEC" does not work for Genie v3 (http://www.genie-mc.org/load.php?include=releases)
export GENLIST="Default+CCMEC"


# for GENIE v3 and beyond you  must also specify a tune
# if you setup a genie_xsec product you can use
#export TUNE_FLAG="--tune ${GENIE_XSEC_TUNE}"


# edep-sim needs to know where a certain GEANT .cmake file is...
G4_cmake_file=`find ${GEANT4_FQ_DIR}/lib64 -name 'Geant4Config.cmake'`
export Geant4_DIR=`dirname $G4_cmake_file`
export PATH=$PATH:$GEANT4_FQ_DIR/bin


# setup environment which probably defines $GXMLPATH to some combination of locations
# export GXMLPATH=$GXMLPATH:/dune/app/users/kordosky/nd_sim/event_gen
export GXMLPATH=$GXMLPATH:/dune/app/users/mazam/working_area/proposal/genie_v2_12_10c


# The line below gets rid of errors like this when running genie
# Error in cling::AutoloadingVisitor::InsertIntoAutoloadingState:
#	Missing FileEntry for ReWeight/GReWeightI.h
#	requested to autoload type genie::rew::GSyst
export ROOT_INCLUDE_PATH=$ROOT_INCLUDE_PATH:$GENIE_INC/GENIE


# Path to flux files
export FLUXFILE="/cvmfs/dune.osgstorage.org/pnfs/fnal.gov/usr/dune/persistent/stash/Flux/g4lbne/v3r5p4/QGSP_BERT/OptimizedEngineeredNov2017/neutrino/gsimpleND/gsimple_DUNEND_g4lbne_v3r5p4_QGSP_BERT_OptimizedEngineeredNov2017_neutrino_00250_00248.root"


# This is not relevant for gsimple flux files but needs to be non-blank
export DETLOC="DUNE_ND_HALL"					   


# arbitrary run number
export run=12345

# One can either run for 
#   a fixed # of protons-on-target (for a sensible flux file)
#   a fixed # of generated events
# but not both 
# export EXPOSURE="-e 7.5e13"   # POT exposure
export EXPOSURE="-n 10000"	# number of events


# The verbosity level is controlled with an XML file allowing users to customize the threshold of each message stream. The XML schema can be seen in ‘$ GENIE/config/Messenger.xml’. The ‘Messenger.xml’ file contains the default thresholds used by GENIE. The ‘Messenger_laconic.xml’ and ‘Messenger_rambling.xml’ files define, correspondingly, less and more verbose configurations.
# This file should either be in a genie_xsec or genie_phyopt added path as part of $GXMLPATH cascade of locations
export MSGLVL=Messenger_production.xml
# export MSGLVL=Messenger_laconic.xml
# export MSGLVL=Messenger_whisper.xml
#export MSGLVL="/dune/app/users/mazam/gdml_files/Messenger_production.xml"


# The following will generate a file named mysetup.maxpl.xml by running 25000 flux rays through the geometry. This will then be used as input for all further generation.
# -f Specifies the input neutrino flux
# -g Specifies the input detector geometry
# -t Specifies the input top volume for event generation
# -m Specifies an XML file with the maximum density-weighted path-lengths for each nuclear target in the input geometry
# -S Number of rays to use to scan geometry for max path length
# -L Specifies the input geometry length units
# -D Specifies the input geometry density units
# -n Specifies the number of events
# --seed Specifies the random number seed for the current job
# -r Specifies the MC run number
# -o Sets the prefix of the output event file
# --cross-sections Specifies the name (incl. full path) of an input XML file with pre-computed neutrino cross-sections
# --event-generator-list Specifies the list of event generators to use in the MC job
# --message-thresholds Specifies the GENIE verbosity level
# event-record-print-level It allows users to set the level of information shown when the event 94 record is printed in the screen. See GHepRecord::Print() for allowed settings.

gevgen_fnal \
   -f ${FLUXFILE},${DETLOC} \				
   -g ${GEOMETRY} \					
   -t ${TOPVOL} \					
   -m "mysetup.maxpl.xml" \
   -S "+25000" \					
   -L "cm" -D "g_cm3" \					
   -n 10000 \						
   --seed ${run} \					
   -r 9999 \						
   -o xyzzy \						
   --cross-sections ${GENIEXSECFILE} \			
   --event-generator-list ${GENLIST} ${TUNE_FLAG} \ 	
   --message-thresholds ${MSGLVL} |& tee /dune/app/users/mazam/working_area/proposal/genie_v2_12_10c/gevgenfnal_input.txt


# Running the Executable to Generate Event Sample
gevgen_fnal \
   -f ${FLUXFILE},${DETLOC} \
   -g ${GEOMETRY} \
   -t ${TOPVOL} \
   -m "mysetup.maxpl.xml" \
   -L "cm" -D "g_cm3" \
   ${EXPOSURE} \
   --seed ${run} \
   -r ${run} \
   -o ${GPREFIX} \
   --cross-sections ${GENIEXSECFILE} \
   --event-generator-list ${GENLIST} ${TUNE_FLAG} \
   --message-thresholds ${MSGLVL} \
   --event-record-print-level 0 |& tee /dune/app/users/mazam/working_area/proposal/genie_v2_12_10c/gevgenfnal_output.txt	
# The output file will take the form ${GPREFIX}.gntp.${run}.ghep.root


# To print all the events 
gevdump -f genieV21210c.12345.ghep.root |& tee /dune/app/users/mazam/working_area/proposal/genie_v2_12_10c/gevgenfnal_allEvents.txt


# Once the script has been run completely. Use gntpc to convert the native GENIE GHEP event file to the GST (Genie Summary Tree) format: Use the following set of commands:
gntpc -i genieV21210c.12345.ghep.root -f gst -n 10000 -o genieV2out.root
# root genieV2out.root
# gst->Draw("nf")

#gntpc
#-i input_file_name
#-f format_of_output_file
#[-v format_version_number]
#[-c copy_MC_job_metadata?]
#[-o output_file_name]
#[-n number_of_events_to_convert]
#where [] denotes an optional argument.



#To save the histogram in png, use the following commands
#	TCanvas *nf = new TCanvas();
#	gst->Draw("nf");
#	nf->Print("genieV2_total_multiplicity.png");


