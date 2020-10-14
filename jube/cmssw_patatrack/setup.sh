#!/bin/bash

echo "PYTHONPATH = $PYTHONPATH"

# 
WORKDIR=$1
NUM_CORES=$2
#RELEASE=CMSSW_11_1_0_pre8_Patatrack
RELEASE=CMSSW_11_1_3_Patatrack
export SCRAM_ARCH=slc7_amd64_gcc820

#source /cvmfs/cms.cern.ch/cmsset_default.sh
source /p/project/cdeep/khristenko1/cmssoft/cmsset_default.sh

# we will work in some tmp dir
[ -d "$WORKDIR" ] && rm -rf $WORKDIR
mkdir $WORKDIR
cd $WORKDIR

# check out a release
scram project CMSSW $RELEASE
cd $WORKDIR/$RELEASE/src
eval `scramv1 runtime -sh`
git cms-init -x cms-patatrack

# bring the current release branch up to the head
#git checkout CMSSW_11_1_X_Patatrack
#git diff $CMSSW_VERSION --name-only --no-renames | cut -d/ -f-2 | sort -u | xargs -r git cms-addpkg
#git cms-checkdeps -a

echo "PYTHONPATH = $PYTHONPATH"

# build
scram b -v -j $NUM_CORES

echo "PYTHONPATH = $PYTHONPATH"
