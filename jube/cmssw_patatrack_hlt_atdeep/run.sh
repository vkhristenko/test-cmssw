#!/bin/bash

# 
WORKDIR=$1
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

# check release dir is present
[ ! -d "$RELEASE_DIR" ] && echo "$RELEASE_DIR folder does not exist!" && exit 1
cd $RELEASE_DIR/$RELEASE/src

# init 
eval `scramv1 runtime -sh`

echo $PYTHONPATH

# run
cd $WORKDIR
echo "running release $RELEASE in $WORKDIR with $NUM_CORES cores per process"
#LD_PRELOAD=/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libcuda.so.450.36.06:/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libnvidia-ptxjitcompiler.so.450.36.06 $PATATRACK_SCRIPTS/benchmark $CFG $NUM_JOBS $NUM_CORES > results.log 2>&1
$PATATRACK_SCRIPTS/benchmark $CFG $NUM_JOBS $NUM_CORES > results.log 2>&1

# parse the logs to get average throughput
input="results.log"
#counter=0
#while IFS= read -r line
#do
#    #echo "$counter --> $line"
#    if [ $counter -eq 15 ]
#    then
#        echo "average throughput = $line" # __ THIS GUY PRINTS AN AVERAGE THROUGHPUT OF 4 RUNS __
#    fi
#    counter=$((counter+1))
#done < "$input"

# print the rest of the log
echo ">>> full log"
cat $input
echo "<<< full log"
