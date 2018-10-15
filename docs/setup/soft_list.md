# Software List

CERN/CMS use case is quite particular as typically we deliver the whole software stack to the site. This requires a very large number of various software packages. To simplify the process we utilize the CERN VM-FS. CVMFS, for short, provides access to all of the software components and available releases.

## CERN VM-FS
- What: `The CernVM File System provides a scalable, reliable and low-maintenance software distribution service`
- Why: to distribute the whole soft stack, instead of installing individual packages. Provides an easy way to get ahold of the newest releases of various components.
- Alternatives: install rpms
- Installation: `https://cernvm.cern.ch/portal/filesystem/quickstart`, already used on deeper sdv
- Comments: Have to be visible across both login and compute nodes - actually across all of them.
- Comment: Can be run from the User Space: `https://cernvm.cern.ch/portal/filesystem/parrot`

## Frontier Squid
- What: `- http://www.squid-cache.org/`. Requires a special version of squid (called Frontier Squid within LHC). Pulls conditions with http
- Why: for efficient conditions distribution. Especially helpful for benchmarks which run on the same data and require no pulling of new payloads. Instead of reading servers at CERN, a local server would speed things up substantially, especially at start-up of the job.
- Installation: - https://twiki.cern.ch/twiki/bin/view/Frontier/InstallSquid
