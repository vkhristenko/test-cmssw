#!/bin/bash

#SBATCH --partition=dp-cn
#SBATCH -A deep
#SBATCH -N 4
#SBATCH --exclusive
#SBATCH --job-name=cmssw_patatrack_hlt_cpuonly
#SBATCH --mail-type=END,FAIL
#SBATCH --mail-user=viktor.khristenko@cern.ch
#SBATCH --time=02:00:00
#SBATCH --output=/p/project/cdeep/khristenko1/logs/%j.log
#SBATCH --error=/p/project/cdeep/khristenko1/logs/%j.err

srun test_envs.sh
#srun setup.sh /p/home/jusers/khristenko1/deep/tmp_cmssw_patatrack_1 16
