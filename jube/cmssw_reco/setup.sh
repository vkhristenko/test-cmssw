#!/bin/bash

# pass directory where to setup cmssw release
WORKDIR=$1
RELEASE=CMSSW_10_0_0

# cvmfs
source /cvmfs/cms.cern.ch/cmsset_default.sh

# setup a release
cd $WORKDI
scram project CMSSW $RELEASE
cd $RELEASE/src
eval `scramv1 runtime -sh`
scram b -v -j 8
