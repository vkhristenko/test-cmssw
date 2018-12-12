// -*- C++ -*-
//
// Package:    Alexi/TestAnalyzer
// Class:      TestAnalyzer
// 
/**\class TestAnalyzer TestAnalyzer.cc Alexi/TestAnalyzer/plugins/TestAnalyzer.cc

 Description: [one line class summary]

 Implementation:
     [Notes on implementation]
*/
//
// Original Author:  Viktor Khristenko
//         Created:  Wed, 12 Dec 2018 08:52:36 GMT
//
//


// system include files
#include <memory>
#include <iostream>

// user include files
#include "FWCore/Framework/interface/Frameworkfwd.h"
#include "FWCore/Framework/interface/one/EDAnalyzer.h"

#include "FWCore/Framework/interface/Event.h"
#include "FWCore/Framework/interface/MakerMacros.h"

#include "FWCore/ParameterSet/interface/ParameterSet.h"

#include "DataFormats/PatCandidates/interface/Muon.h"
//
// class declaration
//

// If the analyzer does not use TFileService, please remove
// the template argument to the base class so the class inherits
// from  edm::one::EDAnalyzer<> and also remove the line from
// constructor "usesResource("TFileService");"
// This will improve performance in multithreaded jobs.

class TestAnalyzer : public edm::one::EDAnalyzer<edm::one::SharedResources>  {
   public:
      explicit TestAnalyzer(const edm::ParameterSet&);
      ~TestAnalyzer();

      static void fillDescriptions(edm::ConfigurationDescriptions& descriptions);


   private:
      virtual void beginJob() override;
      virtual void analyze(const edm::Event&, const edm::EventSetup&) override;
      virtual void endJob() override;

      // ----------member data ---------------------------
      edm::InputTag _tagMuons;
      edm::EDGetTokenT<pat::MuonCollection> _tokMuons;
};

//
// constants, enums and typedefs
//

//
// static data member definitions
//

//
// constructors and destructor
//
TestAnalyzer::TestAnalyzer(const edm::ParameterSet& ps)

{
   //now do what ever initialization is needed
   usesResource("TFileService");

   _tagMuons = ps.getUntrackedParameter<edm::InputTag>(
        "tagMuons");
   _tokMuons = consumes<pat::MuonCollection>(
        _tagMuons);
}


TestAnalyzer::~TestAnalyzer()
{
 
   // do anything here that needs to be done at desctruction time
   // (e.g. close files, deallocate resources etc.)

}


//
// member functions
//

#define print(expr)\
    std::cout << ""#expr " = " << expr << std::endl

// ------------ method called for each event  ------------
void
TestAnalyzer::analyze(const edm::Event& event, const edm::EventSetup& iSetup)
{
   using namespace edm;

  // extract the collection
  edm::Handle<pat::MuonCollection> hMuons;
  event.getByToken(_tokMuons, hMuons);

  // loop over all the muons
  for (pat::MuonCollection::const_iterator it=hMuons->begin();
    it!=hMuons->end(); ++it) {
    auto muon = *it;
    print(muon.pt());
  }
}


// ------------ method called once each job just before starting event loop  ------------
void 
TestAnalyzer::beginJob()
{
}

// ------------ method called once each job just after ending the event loop  ------------
void 
TestAnalyzer::endJob() 
{
}

// ------------ method fills 'descriptions' with the allowed parameters for the module  ------------
void
TestAnalyzer::fillDescriptions(edm::ConfigurationDescriptions& descriptions) {
  //The following says we do not know what parameters are allowed so do no validation
  // Please change this to state exactly what you do use, even if it is no parameters
  edm::ParameterSetDescription desc;
  desc.setUnknown();
  descriptions.addDefault(desc);
}

//define this as a plug-in
DEFINE_FWK_MODULE(TestAnalyzer);
