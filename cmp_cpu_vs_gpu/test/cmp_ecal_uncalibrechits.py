import sys

print sys.argv
pathToFile = sys.argv[2]

import FWCore.ParameterSet.Config as cms

process = cms.Process("Demo")

process.load("FWCore.MessageService.MessageLogger_cfi")
process.options = cms.untracked.PSet (wantSummary = cms.untracked.bool(False))

process.load('Configuration.StandardSequences.GeometryRecoDB_cff')
process.load("Configuration.StandardSequences.FrontierConditions_GlobalTag_cff")
from Configuration.AlCa.GlobalTag import GlobalTag
process.GlobalTag = GlobalTag(process.GlobalTag, 'auto:phase1_2017_realistic', '')


process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(-1) )
process.MessageLogger.cerr.FwkReport.reportEvery = 10

process.source = cms.Source("PoolSource",
            fileNames = cms.untracked.vstring(

                     # "root://cmg-gpu1080.cern.ch//data/ml/vawong/CMSSW_10_2_X_2018-06-28-2300/src/ComparisonPlots/test.root",   
                          'file:{}'.format(pathToFile)

                              #run254532_SinglePulse.root"
                                  )
            )

#  hRhToken = consumes<HBHERecHitCollection >(iConfig.getUntrackedParameter<string>("HBHERecHits","hbheprereco"));
#  hRhTokenGPU = consumes<HBHERecHitCollection >(iConfig.getUntrackedParameter<string>("HBHERecHitsGPU","hbheprerecogpu"));

process.cmp_ecal_cpu_vs_gpu = cms.EDAnalyzer(
    'cmp_ecal_uncalibrechits',
    tok_cpu = cms.InputTag("ecalMultiFitUncalibRecHit", "EcalUncalibRecHitsEB"),
    tok_gpu = cms.InputTag("ecalMultiFitUncalibRecHitgpu", "EcalUncalibRecHitsEBgpu"),
)

process.TFileService = cms.Service(
    'TFileService', 
    fileName = cms.string('cmp_ecal_cpu_vs_gpu.root') 
)


process.p = cms.Path(process.cmp_ecal_cpu_vs_gpu)
