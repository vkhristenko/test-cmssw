#!/bin/bash

# 
WORKDIR=$1
NUM_CORES=$2
RELEASE=CMSSW_11_1_0_pre8_Patatrack
export SCRAM_ARCH=slc7_amd64_gcc820

source /cvmfs/cms.cern.ch/cmsset_default.sh

# we will work in some tmp dir
cd $WORKDIR

# check out a release
scram project CMSSW $RELEASE
cd $WORKDIR/$RELEASE/src
eval `scramv1 runtime -sh`
git cms-init -x cms-patatrack

# bring the current release branch up to the head
git checkout cms-patatrack/CMSSW_11_1_X_Patatrack
git diff $CMSSW_VERSION --name-only --no-renames | cut -d/ -f-2 | sort -u | xargs -r git cms-addpkg
git cms-checkdeps -a

# build
scram b -v -j $NUM_CORES
