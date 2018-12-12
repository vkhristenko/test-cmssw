import FWCore.ParameterSet.Config as cms
process = cms.Process("NtupleMaking")

# various imports to set up cmssw processing
process.load("Configuration.StandardSequences.MagneticField_38T_cff")
process.load("FWCore.MessageService.MessageLogger_cfi")
process.MessageLogger.cerr.FwkReport.reportEvery = 1
process.load("Configuration.Geometry.GeometryIdeal_cff")
process.load('Configuration.EventContent.EventContent_cff')
process.load("Configuration.StandardSequences.FrontierConditions_GlobalTag_condDBv2_cff")

# this is a global tag -> identifies which conditions to use for 
# the data processing, it is needed (i believe) even if you
# do not need those
process.GlobalTag.globaltag = "80X_mcRun2_asymptotic_2016_TrancheIV_v6"

# specify which files
process.maxEvents = cms.untracked.PSet( input = cms.untracked.int32(100) )
process.source = cms.Source("PoolSource",
    fileNames = cms.untracked.vstring(["/store/mc/RunIISummer16DR80Premix/ggXToYYTo4Mu_m18_scalar_13TeV-pythia8-JHUGen/AODSIM/PUMoriond17_80X_mcRun2_asymptotic_2016_TrancheIV_v6-v1/60000/728BF563-89BC-E811-92A7-001F2908BE52.root"])
)

# this is for output, kinda a TFile helper...
process.TFileService = cms.Service("TFileService", 
    fileName = cms.string("test.root") )

# cmssw is a plug/play system -> load dynamic shared objects 
# at runtime -> therefore we must specify all the objects (.so) to load and use
process.test_analyzer = cms.EDAnalyzer("TestAnalyzer")

# data processsing workflow to perform -> here only our analyzer
process.p = cms.Path(process.test_analyzer)
