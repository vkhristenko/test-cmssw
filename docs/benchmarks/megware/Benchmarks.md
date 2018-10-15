# CMSSW Benchmarks Setup

## Megware AMD machine gmz02
- `ssh <username>@login.megware.de`
- `ssh frontend`
- for 1 executable(task) per node: `srun -N 1 --ntasks-per-node=1 --partition=CPU_7551 --pty bash`
- for 4 executables(tasks) per node: `srun -N 1 --ntasks-per-node=4 --partition=CPU_7551 --pty bash`

## Setup Once
- *Should be done just once!*
- `git clone https://github.com/vkhristenko/benchmarks4cmssw`
- `mkdir ~/logs`
- `mkdir releases; cd  releases`
- `source /scratch/vkhriste/cms/cmsset_default.sh`
- `cmsrel CMSSW_10_0_0; cd CMSSW_10_0_0`
- `cmsenv`
- `scram b -v -j 8`

## Preparation for execution
- *To be performed for each clean interactive shell*
- `cd ~/releases/CMSSW_10_0_0/src`
- `source /scratch/vkhriste/cms/cmsset_default.sh`
- `cmsenv`
- `export CMS_PATH=/scratch/vkhriste/config`

## Workflow 136.837
### Physics
- *ZeroBias* is a workflow that contains a mix of various collision events (physics triggers).
- Run *RAW2DIGI* - digitization
- Run *RECO* - reconstruction

### Data: /ZeroBias/Run2017F-v1/RAW
- Original location of files @CERN is provided in [Datasets](../Datasets.md) description
- @Megware, files are located on a scratch space: `/scratch/vkhriste/data/ZeroBias/Run2017F-v1/RAW/`. Visible from the gmz02 node.

### Execution Test
- attempt = 0
- nthreads = 8
- nevents per process = 100
```
srun ~/benchmarks4cmssw/launchers4slurm/workflow_136.837_step3only_noDQM.sh \
         /scratch/vkhriste/cms /scratch/vkhriste/config \
         ~/releases/CMSSW_10_0_0/src \
         filelist:/scratch/vkhriste/data/ZeroBias/Run2017F-v1/RAW/filelist.txt \
         /scratch/vkhriste/data/ZeroBias/Run2017F-v1/OUTPUT_RECO \
         ~/logs 0 8 100
```

### Benchmark with 8 processes (tasks) per node and 8 threads per process
- `srun -N 1 --ntasks-per-node=8 --partition=CPU_7551 --pty bash`
- nthreads per process = 8
- nevents per process = 800 -> 100 events per thread
```
srun ~/benchmarks4cmssw/launchers4slurm/workflow_136.837_step3only_noDQM.sh \
         /scratch/vkhriste/cms /scratch/vkhriste/config \
         ~/releases/CMSSW_10_0_0/src \
         filelist:/scratch/vkhriste/data/ZeroBias/Run2017F-v1/RAW/filelist.txt \
         /scratch/vkhriste/data/ZeroBias/Run2017F-v1/OUTPUT_RECO \
         ~/logs 0 8 800
```

## Workflow 136.831
### Physics
- *JetHT* is a workflow that definitely contains hadron activity (Hadron Calorimeter triggers fired).
- Run *RAW2DIGI* - digitization
- Run *RECO* - reconstruction

### Data: /JetHT/Run2017F-v1/RAW
- Original location of files @CERN is provided in [Datasets](../Datasets.md) description
- @Megware, files are located on a scratch space: `/scratch/vkhriste/data/JetHT/Run2017F-v1/RAW/`. Visible from the gmz02 node.

### Execution Test
- attempt = 0
- nthreads = 8
- nevents per process = 100
```
srun ~/benchmarks4cmssw/launchers4slurm/workflow_136.831_step3only_noDQM.sh \
         /scratch/vkhriste/cms /scratch/vkhriste/config \
         ~/releases/CMSSW_10_0_0/src \
         filelist:/scratch/vkhriste/data/JetHT/Run2017F-v1/RAW/filelist.txt \
         /scratch/vkhriste/data/JetHT/Run2017F-v1/OUTPUT_RECO \
         ~/logs 0 8 100
```

### Benchmark with 8 processes (tasks) per node and 8 threads per process
- `srun -N 1 --ntasks-per-node=8 --partition=CPU_7551 --pty bash`
- nthreads per process = 8
- nevents per process = 800 -> 100 events per thread
```
srun ~/benchmarks4cmssw/launchers4slurm/workflow_136.831_step3only_noDQM.sh \
         /scratch/vkhriste/cms /scratch/vkhriste/config \
         ~/releases/CMSSW_10_0_0/src \
         filelist:/scratch/vkhriste/data/JetHT/Run2017F-v1/RAW/filelist.txt \
         /scratch/vkhriste/data/JetHT/Run2017F-v1/OUTPUT_RECO \
         ~/logs 0 8 800
```
