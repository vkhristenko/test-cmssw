#!/bin/bash

# 
WORKDIR=$1
NUM_CORES=$2
RELEASE=CMSSW_11_1_3_Patatrack
CFG=/p/project/cdeep/khristenko1/cmsrun_configs/hcal/gpu.py
export SCRAM_ARCH=slc7_amd64_gcc820

source /p/project/cdeep/khristenko1/cms_env.sh

# we will work in some tmp dir
[ ! -d "$WORKDIR" ] && echo "$WORKDIR folder does not exist!" && exit 1
cd $WORKDIR/$RELEASE/src

# init 
eval `scramv1 runtime -sh`

# run
echo "running in $WORKDIR with $NUM_CORES cores per process"
LD_PRELOAD=/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libcuda.so.450.36.06:/cvmfs/cms.cern.ch/slc7_amd64_gcc820/external/cuda/11.0.1/drivers/libnvidia-ptxjitcompiler.so.450.36.06 /p/project/cdeep/khristenko1/patatrack-scripts/benchmark $CFG $NUM_CORES > results.log 2>&1

# parse the logs to get average throughput
input="results.log"
counter=0
while IFS= read -r line
do
    #echo "$counter --> $line"
    if [ $counter -eq 15 ]
    then
        echo "average throughput = $line" # __ THIS GUY PRINTS AN AVERAGE THROUGHPUT OF 4 RUNS __
    fi
    counter=$((counter+1))
done < "$input"

# print the rest of the log
echo ">>> full log"
cat $input
echo "<<< full log"
