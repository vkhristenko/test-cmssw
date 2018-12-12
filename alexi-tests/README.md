# cmssw aod/miniaod tests

## General notes, guidelines, etc...
- cmssw version, global tags, etc... all depend on the data production campaign that is being analyzed

## To set up
```
export SCRAM_ARCH=slc7_amd64_gcc530
cmsrel CMSSW_8_0_32
cd CMSSW_8_0_32/src
cmsenv
mkdir UserCode; cd UserCode
copy the analyzer
```
