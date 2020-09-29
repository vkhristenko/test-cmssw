#!/bin/bash

# 
WORKDIR=$1
TMP_WORKDIR=/scratch/khristenko1
RELEASE_DIR=$2
NUM_JOBS=$3
NUM_CORES=$4
RELEASE=CMSSW_11_1_3_Patatrack
CFG=/p/project/cdeep/khristenko1/cmsrun_configs/opendata_hlt/hlt_rawinput_cpu.py
#CFG=/p/project/cdeep/khristenko1/cmsrun_configs/opendata_hlt/hlt_rawinput_gpu.py
PATATRACK_SCRIPTS=/p/project/cdeep/khristenko1/patatrack/patatrack-scripts
export SCRAM_ARCH=slc7_amd64_gcc820

source /p/project/cdeep/khristenko1/cms_env.sh

# we will work in some tmp dir
[ -d "$WORKDIR" ] && rm -rf $WORKDIR
mkdir $WORKDIR

[ -d "$TMP_WORKDIR" ] && rm -rf $TMP_WORKDIR
mkdir $TMP_WORKDIR

# check release dir is present
[ ! -d "$RELEASE_DIR" ] && echo "$RELEASE_DIR folder does not exist!" && exit 1
cd $RELEASE_DIR/$RELEASE/src

# init 
eval `scramv1 runtime -sh`

echo $PYTHONPATH

# run
cd $TMP_WORKDIR
echo "running release $RELEASE in $TMP_WORKDIR with $NUM_CORES cores per process"
#LD_PRELOAD=/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libcuda.so.450.36.06:/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libnvidia-ptxjitcompiler.so.450.36.06 $PATATRACK_SCRIPTS/benchmark $CFG $NUM_JOBS $NUM_CORES > results.log 2>&1
$PATATRACK_SCRIPTS/benchmark $CFG $NUM_JOBS $NUM_CORES > results.log 2>&1

# copy the logs
cp -r $TMP_WORKDIR/* $WORKDIR/
