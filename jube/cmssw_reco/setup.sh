#!/bin/bash

# pass directory where to setup cmssw release
WORKDIR=$1
RELEASE=CMSSW_10_0_0
export SCRAM_ARCH=slc7_amd64_gcc630

# cvmfs
source /cvmfs/cms.cern.ch/cmsset_default.sh

# setup a release
cd $WORKDIR
scram project CMSSW $RELEASE
cd $WORKDIR/$RELEASE/src
eval `scramv1 runtime -sh`
scram b -v -j 8
