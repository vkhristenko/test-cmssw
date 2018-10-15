#!/bin/bash

#SBATCH --job-name=cmssw_reco
#SBATCH --mail-type=END,FAIL
#SBATCH --main-user=viktor.khristenko@cern.ch
#SBATCH --ntsaks=1
#SBATCH --cpus-per-task=8
#SBATCH --mem=20gb
#SBATCH --time=01:00:00
#SBATCH --output=cmssw_reco_%j.log

pwd; hostname; date

echo "running cmssw reco job with $SLURM_NTASKS processes(tasks)/node each with $SLURM_CPUS_PER_TASK cores/process"

LAUNCHER=~/benchmarks4cmssw/launchers4slurm/workflow_136.837_step3only_noDQM.sh
CMSSOFT=/scratch/vkhriste/cms
CMSCONFIG=/scratch/vkhriste/config
CMSSWRELEASE=~/releases/CMSSW_10_0_0/src
INPUTDATA=filelist:/scratch/vkhriste/data/ZeroBias/Run2017F-v1/RAW/filelist.txt
OUTPUTDIR=/scratch/vkhriste/data/ZeroBias/Run2017F-v1/OUTPUT_RECO
LOGDIR=~/logs
ATTEMPT=0
NTHREADS=8
EVENTSTOTAL=800

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

#srun ~/benchmarks4cmssw/launchers4slurm/workflow_136.837_step3only_noDQM.sh \
#    /scratch/vkhriste/cms /scratch/vkhriste/config \
#    ~/releases/CMSSW_10_0_0/src \
#    filelist:/scratch/vkhriste/data/ZeroBias/Run2017F-v1/RAW/filelist.txt \
#    /scratch/vkhriste/data/ZeroBias/Run2017F-v1/OUTPUT_RECO \
#    ~/logs 0 8 800

echo "job is finished"
