#!/bin/bash

#SBATCH --partition=dp-esb
#SBATCH -A deep
#SBATCH --job-name=cmssw_patatrack_setup
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=viktor.khristenko@cern.ch
#SBATCH --ntasks=1
#SBATCH --cpus-per-task=16
#SBATCH --time=01:00:00
#SBATCH --output=/p/project/cdeep/khristenko1/logs/%j.log

WORKDIR=$1
NUM_CORES=$2

srun setup.sh $WORKDIR $NUM_CORES
#srun setup.sh /p/home/jusers/khristenko1/deep/tmp_cmssw_patatrack_1 16
