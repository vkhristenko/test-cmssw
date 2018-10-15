# CMSSW Software Stack Description and Explanation

An attempt to provide a description of the whole CMS Experiment software stack used for the data processing/analytics. Only description (guildelines for installtion are provided separately) is outlined here

## Software Repositories at `https://github.com/cms-sw/`

### cms-docker 
- `https://github.com/cms-sw/cms-docker`
- collection of various docker images

### cmssw
- `https://github.com/cms-sw/cmssw`
- `CMSSW` source code itself without any externals or system wide rpms

### cmsdist
- `https://github.com/cms-sw/cmsdist`
- collecion of `.spec` files that specify how to build the rpms to be used by the `CMSSW`

### cms-git-tools
- `https://github.com/cms-sw/cms-git-tools`
- `git` wrappers to simplify the sparse-checkout process and interaction with `git` in general

### pkgtools
- `https://github.com/cms-sw/pkgtools`
- scripts used to build the whole stack from scratch

### cmssw-config
- `https://github.com/cms-sw/cmssw-config`
- cmssw build configuration files 
- __FILL IN MORE INFO!__

### cmspkg
- `https://github.com/cms-sw/cmspkg`
- light-weight package manager
- simplifies common cms-wide package management

### SCRAM 
- `https://github.com/cms-sw/SCRAM`
- Software Configuratio and Management Utility
- build system (a la cmake ...)

## Software Components

### CERN VM-FS
- https://cernvm.cern.ch/portal/filesystem
- CERN VM File System
- Providese a way to distribute the whole software stack to the site
 - Compilers
 - External Packages
 - CMSSW distributions (releases)

### Frontier Squid Proxy
- http://www.squid-cache.org/
- https://twiki.cern.ch/twiki/bin/view/Frontier/InstallSquid
- *Is used for conditions retrieval from the ORACLE Database and reuse*, which is physically located on CERN machines
- *SITECONF* folder must be properly configured. More on this in [Installation and Setup](InstallationAndSetup.md)

### Simple file Transfers with xrootd + kerberos
- Given xrootd + kerberos is installed and a possibility to kerberize for the realm from which to copy data (CERN.CH or FNAL.GOV), files can be copied without the use of the WLCG certificates
- I found that some HPC systems do not have kerberos preinstalled, therefore this might be needed in case of file transfers without the grid authentication set up.

### Required packages
- Given a system without a possibility to put cvmfs, packages can be installed by the sysadmin centrally.
- *NOTE*, that in case CERN VM-FS is present, these packages are not needed!
```
yum install -y sudo vim rsync krb5-workstation e2fsprogs xauth \
               git bash-completion bash-completion-extras \
               tcsh openssl perl-Digest-MD5 perl-Switch perl-Env \
               voms-clients xrootd-client \
               http://linuxsoft.cern.ch/wlcg/centos7/x86_64/wlcg-repo-1.0.0-1.el7.noarch.rpm \
               HEP_OSlibs wlcg-voms-cms \
               http://repository.egi.eu/sw/production/umd/4/centos7/x86_64/updates/umd-release-4.1.3-1.el7.centos.noarch.rpm \
               ca-policy-egi-core
```
