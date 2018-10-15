#!/bin/bash

# arrange the CLI args
CMSDISTR=$1
CMSSITECONF=$2
CMSRELEASE=$3
CMSDATAIN=$4
CMSDATAOUT=$5
CMSLOG=$6
ATTEMPTID=$7
NTHREADS=$8
NEVENTS=$9

echo "CMSDISTR = $CMSDISTR"
echo "CMSSITECONF = $CMSSITECONF"
echo "CMSRELEASE = $CMSRELEASE"
echo "CMSDATAIN = $CMSDATAIN"
echo "CMSDATAOUT = $CMSDATAOUT"
echo "CMSLOG = $CMSLOG"
echo "ATTEMPTID = $ATTEMPTID"
echo "NTHREADS = $NTHREADS"
echo "NEVENTS = $NEVENTS"

# set aux variables
TASKID=$SLURM_PROCID
JOBID=$SLURM_JOB_ID
SKIPEVENTS=$((NEVENTS * TASKID))

# just an echo
echo "Hello from TASK: ${TASKID} JOB: ${JOBID} ATTEMPT: ${ATTEMPTID}"

# verify the number of threads to use
echo "Number of Threads per cmsRun cmd: ${NTHREADS}"

# go to the CMSSW release and init the env vars
#source /homeb/zam/vkhriste/releases/slc7_amd64_gcc630/init_vars.sh
#export SCRAM_ARCH=slc7_amd64_gcc630
#echo "SCRAM_ARCH=$SCRAM_ARCH"
source $CMSDISTR/cmsset_default.sh
#source /cvmfs/cms.cern.ch/cmsset_default.sh
#export CMS_PATH=$PATH_TO_CONFIG
export CMS_PATH=$CMSSITECONF
#CMSSW_TO_USE=$WORKDIR/releases/${SCRAM_ARCH}/${RELEASE}/src
cd $CMSRELEASE
eval `scramv1 runtime -sh`

# generate the config to use
echo "Running the cmsDriver.py cmd"
cmsDriver.py step3_${JOBID}_${TASKID}_${ATTEMPTID}_${NTHREADS}  --conditions auto:run2_data_promptlike -s RAW2DIGI,L1Reco,RECO,EI,PAT --runUnscheduled  --process reRECO --data  --era Run2_2017 --eventcontent RECO,MINIAOD --hltProcess HLT --scenario pp --datatier RECO,MINIAOD --customise Configuration/DataProcessing/RecoTLR.customisePostEra_Run2_2017 -n $NEVENTS --nThreads $NTHREADS --filein $CMSDATAIN --fileout $CMSDATAOUT/output_${JOBID}_${TASKID}_${ATTEMPTID}_${NTHREADS}.root --no_exec >> ${CMSLOG}/benchmark_${JOBID}_${TASKID}_${ATTEMPTID}_${NTHREADS}.log 2>&1

# set the name of the cmsRun config file, sitting in the cded directory
CFG=step3_${JOBID}_${TASKID}_${ATTEMPTID}_${NTHREADS}_RAW2DIGI_L1Reco_RECO_EI_PAT.py

# skip TASKID*NEVENTS events from the first one
echo "updating the skipEvents parameter"
echo "process.source.skipEvents = cms.untracked.uint32($SKIPEVENTS)" >> ${CFG}

# TODO: Do we really need this for DATA? or this is just for MC (Simulations)
echo "turn off the duplicateCheckMode"
echo "process.source.duplicateCheckMode = cms.untracked.string('noDuplicateCheck')" >> ${CFG}

# launch the job
echo "Starting the cmsRun command"
cmsRun ${CFG} >> $CMSLOG/benchmark_${JOBID}_${TASKID}_${ATTEMPTID}_${NTHREADS}.log 2>&1
echo "Finished the cmsRun command"
