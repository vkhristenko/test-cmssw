#!/bin/bash

#SBATCH --job-name=cmssw_reco
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=viktor.khristenko@cern.ch
#SBATCH --partition=sdv
#SBATCH --nodes=1
#SBATCH --ntasks-per-node=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20gb
#SBATCH --time=01:00:00
#SBATCH --output=cmssw_reco_%j.log

pwd; hostname; date

echo "running cmssw reco job with $SLURM_NTASKS processes(tasks)/node each with $SLURM_CPUS_PER_TASK cores/process"

LAUNCHER=/homeb/zam/vkhriste/soft/test-cmssw/slurm/workflow_136.837_step3only_noDQM.sh
CMSSOFT=/cvmfs/cms.cern.ch/
CMSCONFIG=/homeb/zam/vkhriste/config
CMSSWRELEASE=/homeb/zam/vkhriste/soft/test-cmssw/jube/cmssw_reco/bench_cmssw/000003/CMSSW_10_0_0/src
INPUTDATA=filelist:/gpfs-work/zam/vkhriste/data/ZeroBias/Run2017F-v1/RAW/filelist.txt
OUTPUTDIR=/gpfs-work/zam/vkhriste/data/ZeroBias/Run2017F-v1/OUTPUT_RECO
LOGDIR=~/logs
ATTEMPT=0
NTHREADS=8
EVENTSTOTAL=10

srun\
    $LAUNCHER\
    $CMSSOFT\
    $CMSCONFIG\
    $CMSSWRELEASE\
    $INPUTDATA\
    $OUTPUTDIR\
    $LOGDIR\
    $ATTEMPT\
    $NTHREADS\
    $EVENTSTOTAL

echo "job is finished"
