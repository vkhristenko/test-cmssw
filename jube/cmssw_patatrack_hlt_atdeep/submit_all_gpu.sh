#!/bin/bash

WORKDIR=/p/project/cdeep/khristenko1/running_tests
RELEASEDIR=/p/project/cdeep/khristenko1/cmssw_releases

# submit for Compute module nodes (2x 12 cores x 2 HT)
#sbatch submit_run_cn.sh cpu $WORKDIR $RELEASEDIR 12 4

# submit for ESB with CPUs (1x 8 cores x 2 HT)
sbatch submit_run_esb.sh gpu $WORKDIR $RELEASEDIR 1 16

# submit for DAM with CPUs (2x 24 cores x 2 HT)
#sbatch submit_run_esb.sh gpu $WORKDIR $RELEASEDIR 12 8
