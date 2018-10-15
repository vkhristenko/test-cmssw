# Installation and Setup

## CERN VM-FS
- https://cernvm.cern.ch/portal/filesystem
- Default installation
- At a minimum, add `cms.cern.ch` repository to get a hold of CMSSW releases
- For IB releases, `cms-ib.cern.ch` needs to also be added to the available repositories

## File Transfer to a site with xrootd and kerberos
- To transfer data (e.g. for benchmarking on some system) without installing grid packages, we can use just kerberos and xrootd.
- `sudo yum install krb5-workstation xrootd`
- It might be the case that you will require a non-default krb5.conf file. Something that worked for me is provided here [krb5.conf](conf/krb5.conf)
- To kerberize then run:
```
export KRB5_CONFIG=/path/to/new/krb5.conf
kinit -A -f <username>@REALM
```
- For instance in case of CERN T2 storage, after kerberizing for CERN, you can try to run:
```
xrdcp root://eoscms.cern.ch//eos/cms/store/data/Run2017F/ZeroBias/RAW/v1/000/305/590/00000/C42DB2A0-76BA-E711-9544-02163E011DBD.root .
```
- The file is available as of 02/03/2018

## REQUIRED: Frontier Squid
- https://twiki.cern.ch/twiki/bin/view/Frontier/InstallSquid
- http://www.squid-cache.org/
- Just follow the outlined procedure
- Independent of the software stack delivery

## REQUIRED: Configuring SITECONF for Frontier Proxies and Servers
If you are not planning to make your site available to the grid to run CMS crab jobs, and all you want is to test CMSSW for the purpose of benchmarking or anything else, you will need to create a SITECONF folder in a place that is accessible from the compute nodes. *NOTE* it is important to stress for HPC systems in particular, as they tend to have complicated scheme for mount points for various file systems. At a point of start up of `cmsRun` executable, it will try to look for a particular file that specifies the ip and port of the squid proxy.

*setup:*
- In summary, consult this [Dockerfile](https://github.com/vkhristenko/dockerfiles/blob/master/cc7-cmssw/Dockerfile#L32).
- Example `site-local-config.xml` file is provided in the same git repo.
- After setting up according to the [Dockerfile](https://github.com/vkhristenko/dockerfiles/blob/master/cc7-cmssw/Dockerfile#L32) and before running `cmsRun`, we must export the `CMS_PATH` env var to the location where `SITECONF` folder has been placed.
- `export CMS_PATH=/path/to/config` and config must contain `SITECONF` folder 

## INSTALLATION EXAMPLE: Installing with CVMFS
*Given that CERN VM-FS has been installed on the cluster, there is no subsequent installtion of rmps required!* You simply have to initilaize the env variables and checkout a cmssw release that you need:

- environment variables setup: `source /cvmfs/cms.cern.ch/cmsset_default.sh`
- `mkdir ~/releases; cd ~/releases`
- List all the releases: `scram list`
- checkout: `cmsrel CMSSW_10_0_0`
- The rest are just standard CMS commands

## INSTALLATION EXAMPLE: Installing External RPMs + CMSSW RPMs
- In what follows, *external RPMs* signifies the rpms of packages neither maintained nor developed by the CMS community.
- In summary, check this [Dockerfile](https://github.com/vkhristenko/dockerfiles/blob/master/cc7-cmssw/Dockerfile#L32)
- Basic idea is: get externals, bootstrap, then install cmssw rpms
- *NOTE:* you can bootstrap directly without trying to install the external rpms and the [bootstrap.sh](http://cmsrep.cern.ch/cmssw/repos/bootstrap.sh) will try to harvest the system for already available packages/rpms. 
- *NOTE:* bootstrap has to be performed as non-root user!
- *NOTE:* installation and setup of the cms sw stack should be done into the area that is available cluster wide.

## RELEASE SETUP: Checkout / Setup a CMSSW release
*Given a release available via CERN VM-FS or installed via rpms, you can setup local a release and start data processing*

*setup*:
- Assume that cms software stack has been installed in $CMSHOME. For the case of CERN VM-FS, it is always mounted as: `/cvmfs/cms.cern.ch/`. If installed via rpms, you specified the path where to install via `-path /opt/cms` option for the `bootstrap.sh` script.
- initialize the environmental variables: `source $CMSHOME/cmsset_default.sh`
- create a directory where releases will be instantiated: `mkdir releases; cd releases`
- check out a release: `cmsrel CMSSW_10_0_0; cd CMSSW_10_0_0/src`
- initialize the enviromental variables for that particular release: `cmsenv`
- *Ready to process CMS data*
