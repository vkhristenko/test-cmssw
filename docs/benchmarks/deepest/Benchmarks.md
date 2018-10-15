# CMSSW Benchmarks for the DEEP-EST HPC System as of Deliverable 1.2

## Using deeper-sdv partition
- `ssh <username>@deep.fz-juelich.de`
- for 1 node with 4 tasks per node: `srun --partition=sdv -N 1 --ntasks-per-node=4 --pty /bin/bash -i`

## Setup Once
- *Should be done only once!*
- `git clone https://github.com/vkhristenko/benchmarks4cmssw`
- `mkdir ~/logs`
- `mkdir releases; cd releases`
- `source /cvmfs/cms.cern.ch/cmsset_default.sh`
- `cmsrel CMSSW_10_0_0; cd CMSSW_10_0_0`
- `cmsenv`
- `scram b -v -j 8`

## Prepartion for execution
- *To be perfromed for each clean interactive shell*
- `cd ~/releases/CMSSW_10_0_0/src`
- `source /cvmfs/cms.cern.ch/cmsset_default.sh`
- `cmsenv`
- `export CMS_PATH=/sdv-work/public/cern/config`
