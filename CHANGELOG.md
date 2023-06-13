<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v6.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v6.1.0) - 2023-06-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v6.0.1...v6.1.0)

### Added

- (CONT-580) - Updating readme with Deferred function for sensitive fields [#610](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/610) ([Ramesh7](https://github.com/Ramesh7))
- Add classes to manage supported SCM packages [#586](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/586) ([jcpunk](https://github.com/jcpunk))

## [v6.0.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v6.0.1) - 2023-05-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v6.0.0...v6.0.1)

### Fixed

- (GH-585/CONT-998) Fix for safe_directory logic [#605](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/605) ([david22swan](https://github.com/david22swan))

## [v6.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v6.0.0) - 2023-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.5.0...v6.0.0)

### Changed
- (CONT-803) Add Support for Puppet 8 / Drop Support for Puppet 6 [#601](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/601) ([david22swan](https://github.com/david22swan))

## [v5.5.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.5.0) - 2023-04-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.4.0...v5.5.0)

## [v5.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.4.0) - 2023-01-31

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.3.0...v5.4.0)

### Added

- support per-repo HTTP proxy for the git provider [#576](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/576) ([bugfood](https://github.com/bugfood))
- support umask for git repos (try 2) [#574](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/574) ([bugfood](https://github.com/bugfood))

### Fixed

- Bring back GIT_SSH support for old git versions [#582](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/582) ([vStone](https://github.com/vStone))
- fix repeated acceptance tests on the same container [#575](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/575) ([bugfood](https://github.com/bugfood))
- pdksync - (CONT-189) Remove support for RedHat6 / OracleLinux6 / Scientific6 [#573](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/573) ([david22swan](https://github.com/david22swan))
- pdksync - (CONT-130) - Dropping Support for Debian 9 [#570](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/570) ([jordanbreen28](https://github.com/jordanbreen28))

## [v5.3.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.3.0) - 2022-09-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.2.0...v5.3.0)

### Added

- pdksync - (GH-cat-11) Certify Support for Ubuntu 22.04 [#563](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/563) ([david22swan](https://github.com/david22swan))
- Add skip_hooks property to vcsrepo  [#557](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/557) ([sp-ricard-valverde](https://github.com/sp-ricard-valverde))

### Fixed

- Only remove safe_directory, if it exists [#566](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/566) ([KoenDierckx](https://github.com/KoenDierckx))

## [v5.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.2.0) - 2022-06-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.1.0...v5.2.0)

### Added

- pdksync - (GH-cat-12) Add Support for Redhat 9 [#543](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/543) ([david22swan](https://github.com/david22swan))

### Fixed

- (GH-552) Fix home directory evaluation [#553](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/553) ([chelnak](https://github.com/chelnak))

## [v5.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.1.0) - 2022-06-24

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.0.0...v5.1.0)

### Added

- pdksync - (IAC-1753) - Add Support for AlmaLinux 8 [#524](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/524) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1751) - Add Support for Rocky 8 [#523](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/523) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1709) - Add Support for Debian 11 [#521](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/521) ([david22swan](https://github.com/david22swan))

### Fixed

- (GH-535) Fix for safe directories [#549](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/549) ([chelnak](https://github.com/chelnak))
- pdksync - (GH-iac-334) Remove Support for Ubuntu 14.04/16.04 [#529](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/529) ([david22swan](https://github.com/david22swan))
- MODULES-11050 - Force fetch tags [#527](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/527) ([sp-ricard-valverde](https://github.com/sp-ricard-valverde))
- pdksync - (IAC-1787) Remove Support for CentOS 6 [#525](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/525) ([david22swan](https://github.com/david22swan))
- pdksync - (IAC-1598) - Remove Support for Debian 8 [#522](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/522) ([david22swan](https://github.com/david22swan))

## [v5.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.0.0) - 2021-06-02

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v4.0.0...v5.0.0)

### Changed
- Always run as given user, even if identity set [#473](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/473) ([bigpresh](https://github.com/bigpresh))

## [v4.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v4.0.0) - 2021-03-03

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.2.1...v4.0.0)

### Changed
- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [#491](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/491) ([carabasdaniel](https://github.com/carabasdaniel))

## [v3.2.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.2.1) - 2021-02-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.2.0...v3.2.1)

### Fixed

- (MODULES-9997) - Removing extra unwrap on Sensitive value [#490](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/490) ([pmcmaw](https://github.com/pmcmaw))

## [v3.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.2.0) - 2021-01-20

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.1.1...v3.2.0)

### Added

- pdksync - (feat) - Add support for Puppet 7 [#476](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/476) ([daianamezdrea](https://github.com/daianamezdrea))
- pdksync - (IAC-973) - Update travis/appveyor to run on new default branch `main` [#466](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/466) ([david22swan](https://github.com/david22swan))

### Fixed

- [MODULES-10857] Rename exist function to exists in cvs.rb [#484](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/484) ([carabasdaniel](https://github.com/carabasdaniel))
- (IAC-1223) Correct clone https test [#471](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/471) ([pmcmaw](https://github.com/pmcmaw))
- check if pass containes non-ASCII chars before provider is created [#464](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/464) ([adrianiurca](https://github.com/adrianiurca))

## [v3.1.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.1.1) - 2020-06-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.1.0...v3.1.1)

### Fixed

- prevent ANSI color escape sequences from messing up git output [#458](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/458) ([kenyon](https://github.com/kenyon))
- Unset GIT_SSH_COMMAND before exec'ing git command [#435](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/435) ([mzagrabe](https://github.com/mzagrabe))

## [v3.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.1.0) - 2019-12-10

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.0.0...v3.1.0)

### Added

- (FM-8234) Port to Litmus [#429](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/429) ([sheenaajay](https://github.com/sheenaajay))
- pdksync - Add support on Debian10 [#428](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/428) ([lionce](https://github.com/lionce))
- feature(git): add keep local changes option [#425](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/425) ([jfroche](https://github.com/jfroche))

### Fixed

- feat: do not chown excluded files [#432](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/432) ([jfroche](https://github.com/jfroche))

## [v3.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.0.0) - 2019-06-14

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.4.0...v3.0.0)

### Added

- (FM-8035) Add RedHat 8 support [#419](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/419) ([eimlav](https://github.com/eimlav))
- (MODULES-8738) Allow Sensitive value for basic_auth_password [#416](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/416) ([eimlav](https://github.com/eimlav))
- (MODULES-8140) - Add SLES 15 support [#399](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/399) ([eimlav](https://github.com/eimlav))

### Changed
- pdksync - (MODULES-8444) - Raise lower Puppet bound [#413](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/413) ([david22swan](https://github.com/david22swan))

### Fixed

- MODULES-8910 fix for failing git install using RepoForge instead of epel [#414](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/414) ([Lavinia-Dan](https://github.com/Lavinia-Dan))
- (maint) Add HTML anchor tag [#404](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/404) ([clairecadman](https://github.com/clairecadman))
- pdksync - (FM-7655) Fix rubygems-update for ruby < 2.3 [#401](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/401) ([tphoney](https://github.com/tphoney))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.4.0) - 2018-09-28

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.3.0...2.4.0)

### Added

- pdksync - (FM-7392) - Puppet 6 Testing Changes [#394](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/394) ([pmcmaw](https://github.com/pmcmaw))
- pdksync - (MODULES-6805) metadata.json shows support for puppet 6 [#393](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/393) ([tphoney](https://github.com/tphoney))
- pdksync - (MODULES-7658) use beaker4 in puppet-module-gems [#390](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/390) ([tphoney](https://github.com/tphoney))
- (MODULES-7467) Update Vcsrepo to support Ubuntu 18.04 [#382](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/382) ([david22swan](https://github.com/david22swan))

### Fixed

- (MODULES-7009) Do not run HTTPS tests on old OSes [#384](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/384) ([tphoney](https://github.com/tphoney))
- Improve Git performance when using SHA revisions [#380](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/380) ([vpierson](https://github.com/vpierson))
- [FM-6957] Removing unsupported OS from Vcsrepo [#378](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/378) ([david22swan](https://github.com/david22swan))
- Avoid popup on macOS when developer tools aren't installed [#367](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/367) ([girardc79](https://github.com/girardc79))

## [2.3.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.3.0) - 2018-01-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.2.0...2.3.0)

### Added

- (MODULES-5889) Added trust_server_cert support to Git provider [#360](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/360) ([eputnam](https://github.com/eputnam))

## [2.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.2.0) - 2017-10-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.1.0...2.2.0)

## [2.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.1.0) - 2017-10-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.0.0...2.1.0)

### Fixed

- (MODULES-5704) Fix cvs working copy detection [#349](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/349) ([vicinus](https://github.com/vicinus))
- [MODULES-5615] Fix for working_copy_exists [#345](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/345) ([martinmoerch](https://github.com/martinmoerch))
- Git: Do not set branch twice [#335](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/335) ([sathieu](https://github.com/sathieu))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.0.0) - 2017-06-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.5.0...2.0.0)

### Fixed

- fixing force parameter to be boolean [#332](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/332) ([hunner](https://github.com/hunner))
- Fix to get svn provider working again [#322](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/322) ([Rocco83](https://github.com/Rocco83))
- Fix Solaris sh-ism [#311](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/311) ([pearcec](https://github.com/pearcec))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.5.0) - 2016-12-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.4.0...1.5.0)

### Added

- Adding svn provider support for versioning of individual files [#274](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/274) ([squarebracket](https://github.com/squarebracket))

### Fixed

- [MODULES-4139] Fix CI failures in CI on ubuntu 16.04 caused by regex matching on 16.04 when it is not meant to. [#312](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/312) ([wilson208](https://github.com/wilson208))
- Fix muliple default provider warning on windows [#310](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/310) ([pearcec](https://github.com/pearcec))
- [MODULES-3998] Fix to GIT and SVN providers to support older versions of git and svn [#306](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/306) ([wilson208](https://github.com/wilson208))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.4.0) - 2016-09-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.2...1.4.0)

### Added

- Update metadata to note Debian 8 support [#286](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/286) ([DavidS](https://github.com/DavidS))
- Add mirror option for git cloning [#282](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/282) ([Strech](https://github.com/Strech))

### Fixed

- Fix bug in ensure => absent [#293](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/293) ([butlern](https://github.com/butlern))
- fix branch existence determintaion functionality [#277](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/277) ([godlikeachilles](https://github.com/godlikeachilles))

## [1.3.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.2) - 2015-12-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.1...1.3.2)

### Added

- Add feature 'depth' and parameter 'trust_server_cert' to svn [#269](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/269) ([monai](https://github.com/monai))
- Autorequire Package['mercurial'] [#262](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/262) ([mpdude](https://github.com/mpdude))

### Fixed

- Fix :false to be default value [#273](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/273) ([hunner](https://github.com/hunner))
- MODULES-1232 Make sure HOME is set correctly [#265](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/265) ([underscorgan](https://github.com/underscorgan))
- Fix acceptance hang [#264](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/264) ([hunner](https://github.com/hunner))
- MODULES-1800 - fix case where ensure => latest and no revision specified [#260](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/260) ([underscorgan](https://github.com/underscorgan))

## [1.3.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.1) - 2015-07-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.0...1.3.1)

### Added

- Add helper to install puppet/pe/puppet-agent [#254](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/254) ([hunner](https://github.com/hunner))
- acceptance: Add a test verifying anonymous https cloning [#252](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/252) ([DavidS](https://github.com/DavidS))

### Fixed

- fix for detached HEAD on git 2.4+ [#256](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/256) ([keeleysam](https://github.com/keeleysam))
- Make sure the embedded SSL cert doesn't expire [#242](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/242) ([BillWeiss](https://github.com/BillWeiss))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.0) - 2015-05-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.2.0...1.3.0)

### Added

- (BKR-147) add Gemfile setting for BEAKER_VERSION for puppet... [#238](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/238) ([anodelman](https://github.com/anodelman))
- Add IntelliJ files to the ignore list [#226](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/226) ([cmurphy](https://github.com/cmurphy))
- Add support for 'conflict' parameter to populate svn --accept arg [#220](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/220) ([ddisisto](https://github.com/ddisisto))
- Add submodules feature to git provider [#218](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/218) ([dduvnjak](https://github.com/dduvnjak))

### Fixed

- Fix remote hash ordering for unit tests [#240](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/240) ([cmurphy](https://github.com/cmurphy))
- MODULES-1596 - Repository repeatedly destroyed/created with force [#225](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/225) ([underscorgan](https://github.com/underscorgan))
- Fix for MODULES-1597: "format" is a file not a directory [#223](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/223) ([Farzy](https://github.com/Farzy))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.2.0) - 2014-11-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.1.0...1.2.0)

### Added

- Add `user` feature support to CVS provider [#213](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/213) ([jfautley](https://github.com/jfautley))
- Handle both Array/Enumerable and String values for excludes parameter [#207](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/207) ([sodabrew](https://github.com/sodabrew))
- Change uid by Puppet execution API [#200](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/200) ([pbrit](https://github.com/pbrit))

### Fixed

- Fix issue with puppet_module_install, removed and using updated method f... [#204](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/204) ([cyberious](https://github.com/cyberious))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.1.0) - 2014-07-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.2...1.1.0)

### Added

- (MODULES-1014) Add rspec for noop mode [#189](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/189) ([petems](https://github.com/petems))

### Fixed

- Fix metadata.json to match checksum [#195](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/195) ([hunner](https://github.com/hunner))
- Fix lint errors [#192](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/192) ([hunner](https://github.com/hunner))
- Update README.markdown to fix the formatting around the officially supported note. [#191](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/191) ([klynton](https://github.com/klynton))
- (MODULES-660) Correct detached HEAD on latest [#173](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/173) ([hunner](https://github.com/hunner))

## [1.0.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.2) - 2014-07-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.1...1.0.2)

### Added

- Add supported information and reorder to highlight support [#180](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/180) ([lrnrthr](https://github.com/lrnrthr))
- Rebase of PR #177 - Add HG Basic Auth [#178](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/178) ([sodabrew](https://github.com/sodabrew))

### Fixed

- Fix issue with node changing every checkin [#181](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/181) ([jbussdieker](https://github.com/jbussdieker))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.1) - 2014-06-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.0...1.0.1)

### Added

- Pin versions in the supported branch. [#158](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/158) ([underscorgan](https://github.com/underscorgan))
- (MODULES-1014) Adding noop mode option [#153](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/153) ([petems](https://github.com/petems))

### Fixed

- Correct shallow clone count [#166](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/166) ([hunner](https://github.com/hunner))
- Fix typo in mkdir [#164](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/164) ([hunner](https://github.com/hunner))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.0) - 2014-06-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.2.0...1.0.0)

### Added

- Add optional keyfile argument to rake tasks [#150](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/150) ([johnduarte](https://github.com/johnduarte))
- Add beaker tests to complete test plan [#141](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/141) ([johnduarte](https://github.com/johnduarte))
- Add rake tasks to test both beaker and beaker-rspec in one go [#140](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/140) ([cyberious](https://github.com/cyberious))
- Add test for ensure latest with branch specified [#137](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/137) ([johnduarte](https://github.com/johnduarte))
- Add acceptance tests for git protocols using clone [#135](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/135) ([johnduarte](https://github.com/johnduarte))
- add beaker-rspec support [#130](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/130) ([Phil0xF7](https://github.com/Phil0xF7))
- Only add ssh options to commands that actually talk to the network. [#121](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/121) ([fkrull](https://github.com/fkrull))
- Add the option to shallow clones with git [#114](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/114) ([freyes](https://github.com/freyes))

### Fixed

- Update specs and fix FM-1361 [#145](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/145) ([hunner](https://github.com/hunner))
- Fix detached head state [#139](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/139) ([cyberious](https://github.com/cyberious))
- Fix issue where force=>true was not destroying repository then recreatin... [#138](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/138) ([cyberious](https://github.com/cyberious))
- git: actually use the remote parameter [#115](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/115) ([mciurcio](https://github.com/mciurcio))
- Bug fix: Git provider on_branch? retains trailing newline [#109](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/109) ([mikegerwitz](https://github.com/mikegerwitz))
- Correctly handle detached head for 'latest' on latest Git versions [#106](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/106) ([mikegerwitz](https://github.com/mikegerwitz))
- Don't 'su' if passed user is current user [#105](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/105) ([mcanevet](https://github.com/mcanevet))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.2.0) - 2013-11-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.2...0.2.0)

### Added

- Add autorequire for Package['git'] [#98](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/98) ([reidmv](https://github.com/reidmv))
- Add a blank dependencies section and stringify versions. [#96](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/96) ([apenney](https://github.com/apenney))
- FM-103: Add metadata.json to all modules. [#95](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/95) ([apenney](https://github.com/apenney))
- added support for changing upstream repo url - rebase of #74 [#84](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/84) ([sodabrew](https://github.com/sodabrew))
- Add support for master svn repositories [#83](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/83) ([sodabrew](https://github.com/sodabrew))
- Allow for setting the CVS_RSH environment variable [#82](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/82) ([mpdude](https://github.com/mpdude))
- Add user and ssh identity to the Mercurial provider. [#77](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/77) ([arnoudj](https://github.com/arnoudj))
- Add travis build-status image [#76](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/76) ([pbrit](https://github.com/pbrit))
- Add timeout to ssh connections [#65](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/65) ([rkhatibi](https://github.com/rkhatibi))
- "ensure => latest" support for bzr [#61](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/61) ([hholzgra](https://github.com/hholzgra))

### Fixed

- Correct use of withenv [#86](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/86) ([sodabrew](https://github.com/sodabrew))

## [0.1.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.2) - 2013-03-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.1...0.1.2)

### Added

- Allows the creation of non-root repositories [#57](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/57) ([binford2k](https://github.com/binford2k))

## [0.1.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.1) - 2012-10-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.0...0.1.1)

### Added

- Add a dummy provider, remove 'defaultfor' from all other providers. [#35](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/35) ([sodabrew](https://github.com/sodabrew))
- Adds comma to last attribute to comply with style [#31](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/31) ([ghoneycutt](https://github.com/ghoneycutt))
- Add default user to run git as. [#27](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/27) ([ody](https://github.com/ody))

## [0.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.0) - 2012-10-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.0.5...0.1.0)

### Added

- Add the ability to specify a git remote [#24](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/24) ([jesusaurus](https://github.com/jesusaurus))
- Improved Puppet DSL style as per the guidelines. [#19](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/19) ([adamgibbins](https://github.com/adamgibbins))

### Fixed

- (#16495, #15660) Fix regression for notifications and pulls on git provider [#33](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/33) ([kbarber](https://github.com/kbarber))
- Checkout git repository as user, fixed ensure latest, ssh options [#25](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/25) ([ejhayes](https://github.com/ejhayes))
- Fix failing hg provider spec [#23](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/23) ([jmchilton](https://github.com/jmchilton))
- don't recreate bare repo if it exists already - fixes http://projects.puppetlabs.com/issues/12303 [#18](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/18) ([andreasgerstmayr](https://github.com/andreasgerstmayr))
- (#11798) Fix git checkout of revisions [#17](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/17) ([mmrobins](https://github.com/mmrobins))

## [0.0.5](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.0.5) - 2011-12-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.0.4...0.0.5)

### Added

- Added missing 'working_copy_exists?' method. [#16](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/16) ([mfournier](https://github.com/mfournier))
- Fix (#10788) - Avoid unnecessary remote operations in the vcsrepo type [#14](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/14) ([](https://github.com/))
- Suggested fix for (#10751) by adding a "module" parameter [#13](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/13) ([](https://github.com/))

### Fixed

- Fix (#10787) - Various fixes/tweaks for the CVS provider [#15](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/15) ([](https://github.com/))
- Fix (#9083) as suggested by the original bug reporter. [#12](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/12) ([](https://github.com/))
- Bug Fix: Some ownerships in .git directory are 'root' after vcsrepo's retrieve is called [#11](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/11) ([cPanelScott](https://github.com/cPanelScott))
- Fix (#10440) by making all commands optional [#9](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/9) ([](https://github.com/))

## [0.0.4](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.0.4) - 2011-09-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/cb2efcdfaa1f9b6d8c78208151d4b4ebd4e35885...0.0.4)
