#!/bin/bash

#SBATCH --partition=dp-esb
#SBATCH -A deep
#SBATCH -N 1
#SBATCH --exclusive
#SBATCH --job-name=cmssw_patatrack_hlt
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=viktor.khristenko@cern.ch
#SBATCH --time=01:00:00
#SBATCH --output=/p/project/cdeep/khristenko1/logs/%j.log
#SBATCH --error=/p/project/cdeep/khristenko1/logs/%j.err

TYPE=$1
WORKDIR_TOP=$2
RELEASEDIR=$3
NUM_JOBS=$4
NUM_CORES=$5

[ -d "$WORKDIR_TOP/job_$SLURM_JOB_ID" ] && rm -rf "$WORKDIR_TOP/job_$SLURM_JOB_ID"
mkdir "$WORKDIR_TOP/job_$SLURM_JOB_ID"
WORKDIR="$WORKDIR_TOP/job_$SLURM_JOB_ID"

srun run_wrapper.sh $TYPE $WORKDIR $RELEASEDIR $NUM_JOBS $NUM_CORES
