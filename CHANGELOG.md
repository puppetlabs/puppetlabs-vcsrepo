<!-- markdownlint-disable MD024 -->
# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

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

### Other

- 2.3.0 Release Prep [#369](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/369) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-6325) - PDK Convert vcsrepo [#368](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/368) ([pmcmaw](https://github.com/pmcmaw))
- (maint) modulesync 65530a4 Update Travis [#366](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/366) ([michaeltlombardi](https://github.com/michaeltlombardi))
- Modulesync rubocop [#365](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/365) ([willmeek](https://github.com/willmeek))
- (maint) - modulesync 384f4c1 [#364](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/364) ([tphoney](https://github.com/tphoney))
- RubocopFix [#363](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/363) ([david22swan](https://github.com/david22swan))
- FM-6634 temporary work around for rubocop [#362](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/362) ([tphoney](https://github.com/tphoney))
- (maint) - modulesync 1d81b6a [#361](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/361) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-5889) Added trust_server_cert support to Git provider [#360](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/360) ([eputnam](https://github.com/eputnam))
- typo [#358](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/358) ([TheMeier](https://github.com/TheMeier))
- Release merge back 2.2.0 [#357](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/357) ([pmcmaw](https://github.com/pmcmaw))
- Do not ignore incorrect HTTP Basic auth property specifications. [#355](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/355) ([hlaf](https://github.com/hlaf))

## [2.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.2.0) - 2017-10-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.1.0...2.2.0)

### Other

- FM-6549 Pre-Release Process [#356](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/356) ([david22swan](https://github.com/david22swan))
- MODULES-5709 - Implementing Rubocop in the Module [#354](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/354) ([david22swan](https://github.com/david22swan))
- mergeback for 2.1.0 [#353](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/353) ([eputnam](https://github.com/eputnam))

## [2.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.1.0) - 2017-10-23

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.0.0...2.1.0)

### Other

- updates to changelog for 2.1.0 release [#352](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/352) ([eputnam](https://github.com/eputnam))
- Pre-ReleasePrep [#350](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/350) ([david22swan](https://github.com/david22swan))
- (MODULES-5704) Fix cvs working copy detection [#349](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/349) ([vicinus](https://github.com/vicinus))
- Updates to metadata.json [#348](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/348) ([pmcmaw](https://github.com/pmcmaw))
- specify protocol line 206 for ssh [#347](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/347) ([ricou84](https://github.com/ricou84))
- (maint) modulesync 892c4cf [#346](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/346) ([HAIL9000](https://github.com/HAIL9000))
- [MODULES-5615] Fix for working_copy_exists [#345](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/345) ([martinmoerch](https://github.com/martinmoerch))
- (MODULES-5501) - Remove unsupported Ubuntu [#344](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/344) ([pmcmaw](https://github.com/pmcmaw))
- (maint) modulesync 915cde70e20 [#343](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/343) ([glennsarti](https://github.com/glennsarti))
- hg provider: remove un-needed escaped quotes [#341](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/341) ([tphoney](https://github.com/tphoney))
- (MODULES-5187) mysnc puppet 5 and ruby 2.4 [#340](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/340) ([eputnam](https://github.com/eputnam))
- (MODULES-5162) - Removing commented out test [#339](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/339) ([pmcmaw](https://github.com/pmcmaw))
- (MODULES-4896) Mergeback release into master after 2.0.0 release [#338](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/338) ([glennsarti](https://github.com/glennsarti))
- Git: Do not set branch twice [#335](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/335) ([sathieu](https://github.com/sathieu))

## [2.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.0.0) - 2017-06-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.5.0...2.0.0)

### Other

- (MODULES-5144) Prep for puppet 5 [#337](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/337) ([hunner](https://github.com/hunner))
- (MODULES-4896) release prep for 2.0.0 [#336](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/336) ([eputnam](https://github.com/eputnam))
- MODULES-4823 puppetlabs-vcsrepo: Update the version compatibility to >= 4.7.0 < 5.0.0 [#333](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/333) ([marsmensch](https://github.com/marsmensch))
- fixing force parameter to be boolean [#332](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/332) ([hunner](https://github.com/hunner))
- (MODULES-4722) Autorequire subversion [#330](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/330) ([treydock](https://github.com/treydock))
- [msync] 786266 Implement puppet-module-gems, a45803 Remove metadata.json from locales config [#328](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/328) ([wilson208](https://github.com/wilson208))
- [MODULES-4528] Replace Puppet.version.to_f version comparison from spec_helper.rb [#327](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/327) ([wilson208](https://github.com/wilson208))
- Implement beaker-module_install_helper [#324](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/324) ([wilson208](https://github.com/wilson208))
- (MODULES-4098) Sync the rest of the files [#323](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/323) ([hunner](https://github.com/hunner))
- Fix to get svn provider working again [#322](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/322) ([Rocco83](https://github.com/Rocco83))
- (MODULES-4097) Sync travis.yml [#321](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/321) ([hunner](https://github.com/hunner))
- (FM-5931) Release merge back [#320](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/320) ([eputnam](https://github.com/eputnam))
- (MODULES-1910) document non-standard SSH port [#317](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/317) ([binford2k](https://github.com/binford2k))
- Fix Solaris sh-ism [#311](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/311) ([pearcec](https://github.com/pearcec))

## [1.5.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.5.0) - 2016-12-16

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.4.0...1.5.0)

### Other

- release_prep [#319](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/319) ([eputnam](https://github.com/eputnam))
- (FM-5972) gettext and spec.opts [#318](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/318) ([eputnam](https://github.com/eputnam))
- (MODULES-4174) duplicates svn version fact value [#315](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/315) ([eputnam](https://github.com/eputnam))
- (MODULES-3631) msync Gemfile for 1.9 frozen strings [#314](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/314) ([hunner](https://github.com/hunner))
- Further tightening of the test selection REs [#313](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/313) ([DavidS](https://github.com/DavidS))
- [MODULES-4139] Fix CI failures in CI on ubuntu 16.04 caused by regex matching on 16.04 when it is not meant to. [#312](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/312) ([wilson208](https://github.com/wilson208))
- Fix muliple default provider warning on windows [#310](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/310) ([pearcec](https://github.com/pearcec))
- Make :includes work with svn 1.6 [#309](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/309) ([squarebracket](https://github.com/squarebracket))
- Better management of '/'s for :source and :includes [#308](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/308) ([squarebracket](https://github.com/squarebracket))
- (MODULES-3704) Update gemfile template to be identical [#307](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/307) ([hunner](https://github.com/hunner))
- [MODULES-3998] Fix to GIT and SVN providers to support older versions of git and svn [#306](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/306) ([wilson208](https://github.com/wilson208))
- mocha version update [#305](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/305) ([eputnam](https://github.com/eputnam))
- (MODULES-3983) Update parallel_tests for ruby 2.0.0 [#302](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/302) ([pmcmaw](https://github.com/pmcmaw))
- Update README [#300](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/300) ([kallies](https://github.com/kallies))
- Update modulesync_config [51f469d] [#299](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/299) ([DavidS](https://github.com/DavidS))
- "Better" handling of :ensure changes [#298](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/298) ([squarebracket](https://github.com/squarebracket))
- Make :source a property, + some refactoring [#297](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/297) ([squarebracket](https://github.com/squarebracket))
- Release - 1.4.0 mergeback [#296](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/296) ([eputnam](https://github.com/eputnam))
- Adding svn provider support for versioning of individual files [#274](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/274) ([squarebracket](https://github.com/squarebracket))

## [1.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.4.0) - 2016-09-06

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.2...1.4.0)

### Other

- (FM-5559) Readme and changelog edits for signoff [#295](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/295) ([gguillotte](https://github.com/gguillotte))
- (FM-5556) release prep for 1.4.0 [#294](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/294) ([eputnam](https://github.com/eputnam))
- Fix bug in ensure => absent [#293](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/293) ([butlern](https://github.com/butlern))
- Update modulesync_config [a3fe424] [#292](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/292) ([DavidS](https://github.com/DavidS))
- Update modulesync_config [0d59329] [#291](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/291) ([DavidS](https://github.com/DavidS))
- (MAINT) Update for modulesync_config 72d19f184 [#290](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/290) ([DavidS](https://github.com/DavidS))
- (MODULES-3581) modulesync [067d08a] [#289](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/289) ([DavidS](https://github.com/DavidS))
- {maint} modulesync 0794b2c [#288](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/288) ([tphoney](https://github.com/tphoney))
- Update to newest modulesync_configs [9ca280f] [#287](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/287) ([DavidS](https://github.com/DavidS))
- Update metadata to note Debian 8 support [#286](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/286) ([DavidS](https://github.com/DavidS))
- (FM-4046) Update to current msync configs [006831f] [#285](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/285) ([DavidS](https://github.com/DavidS))
- Bring stderr output to the Puppet visible output [#284](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/284) ([lazyfrosch](https://github.com/lazyfrosch))
- (FM-4049) update to modulesync_configs [#283](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/283) ([DavidS](https://github.com/DavidS))
- Add mirror option for git cloning [#282](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/282) ([Strech](https://github.com/Strech))
- 1.3.x mergeback [#281](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/281) ([DavidS](https://github.com/DavidS))
- fix branch existence determintaion functionality [#277](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/277) ([godlikeachilles](https://github.com/godlikeachilles))

## [1.3.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.2) - 2015-12-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.1...1.3.2)

### Added

- Add feature 'depth' and parameter 'trust_server_cert' to svn [#269](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/269) ([monai](https://github.com/monai))
- Autorequire Package['mercurial'] [#262](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/262) ([mpdude](https://github.com/mpdude))

### Other

- (maint) Another update to the CHANGELOG [#280](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/280) ([bmjen](https://github.com/bmjen))
- (maint) Update ordering in CHANGELOG [#278](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/278) ([bmjen](https://github.com/bmjen))
- Ankeny release for 1.3.2 [#276](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/276) ([HelenCampbell](https://github.com/HelenCampbell))
- Fix :false to be default value [#273](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/273) ([hunner](https://github.com/hunner))
- dos2unix the readme [#272](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/272) ([tphoney](https://github.com/tphoney))
- MODULES-1232 Make sure HOME is set correctly [#265](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/265) ([underscorgan](https://github.com/underscorgan))
- Fix acceptance hang [#264](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/264) ([hunner](https://github.com/hunner))
- MODULES-2326 - Run Regexp.escape on the source URL [#263](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/263) ([underscorgan](https://github.com/underscorgan))
- MODULES-2125 - Allow revision to be passed without source [#261](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/261) ([underscorgan](https://github.com/underscorgan))
- MODULES-1800 - fix case where ensure => latest and no revision specified [#260](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/260) ([underscorgan](https://github.com/underscorgan))
- Merge 1.3.x to master [#259](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/259) ([underscorgan](https://github.com/underscorgan))
- Explitly unset SSH_AUTH_SOCK; it is preferred to the -i flag [#257](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/257) ([alexmv](https://github.com/alexmv))

## [1.3.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.1) - 2015-07-27

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.0...1.3.1)

### Other

- 1.3.1 prep [#258](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/258) ([underscorgan](https://github.com/underscorgan))
- fix for detached HEAD on git 2.4+ [#256](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/256) ([keeleysam](https://github.com/keeleysam))
- MODULES-2131 Git provider now takes account of revision property when using depth property. [#255](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/255) ([jonnytdevops](https://github.com/jonnytdevops))
- Add helper to install puppet/pe/puppet-agent [#254](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/254) ([hunner](https://github.com/hunner))
- (maint) allow setting PUPPET_VERSION in acceptance [#253](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/253) ([justinstoller](https://github.com/justinstoller))
- acceptance: Add a test verifying anonymous https cloning [#252](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/252) ([DavidS](https://github.com/DavidS))
- Merge 1.3.x to master [#251](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/251) ([underscorgan](https://github.com/underscorgan))
- Make sure the embedded SSL cert doesn't expire [#242](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/242) ([BillWeiss](https://github.com/BillWeiss))
- Consider the submodules flag on specific revision cloning [#232](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/232) ([netors](https://github.com/netors))

## [1.3.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.3.0) - 2015-05-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.2.0...1.3.0)

### Other

- Release 1.3.0 [#249](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/249) ([hunner](https://github.com/hunner))
- (MODULES-821) Don't use /tmp [#248](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/248) ([hunner](https://github.com/hunner))
- Modulesync updates [#247](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/247) ([underscorgan](https://github.com/underscorgan))
- Update README per DOC-1501 [#246](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/246) ([psoloway](https://github.com/psoloway))
- Enforce the style guide's recommendation of single quotes as the default. [#243](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/243) ([rnelson0](https://github.com/rnelson0))
- Clean up puppet lint warnings [#241](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/241) ([tykeal](https://github.com/tykeal))
- Fix remote hash ordering for unit tests [#240](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/240) ([cmurphy](https://github.com/cmurphy))
- (BKR-147) add Gemfile setting for BEAKER_VERSION for puppet... [#238](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/238) ([anodelman](https://github.com/anodelman))
- Testing updates [#237](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/237) ([cmurphy](https://github.com/cmurphy))
- Updating 'excludes' in readme to be more concise.  [#236](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/236) ([dummey](https://github.com/dummey))
- Pin rspec gems [#235](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/235) ([cmurphy](https://github.com/cmurphy))
- Implemented multiple remotes feature for git provider. [#230](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/230) ([jonnytdevops](https://github.com/jonnytdevops))
- Update let to use instance variable instead. [#229](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/229) ([hunner](https://github.com/hunner))
- removing private tests [#228](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/228) ([tphoney](https://github.com/tphoney))
- Add IntelliJ files to the ignore list [#226](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/226) ([cmurphy](https://github.com/cmurphy))
- MODULES-1596 - Repository repeatedly destroyed/created with force [#225](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/225) ([underscorgan](https://github.com/underscorgan))
- Fix for MODULES-1597: "format" is a file not a directory [#223](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/223) ([Farzy](https://github.com/Farzy))
- Update .travis.yml, Gemfile, Rakefile, and CONTRIBUTING.md [#222](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/222) ([cmurphy](https://github.com/cmurphy))
- Add support for 'conflict' parameter to populate svn --accept arg [#220](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/220) ([ddisisto](https://github.com/ddisisto))
- Updates README per MODULES-1425 [#219](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/219) ([lrnrthr](https://github.com/lrnrthr))
- Add submodules feature to git provider [#218](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/218) ([dduvnjak](https://github.com/dduvnjak))
- Merge 1.2.x into master [#217](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/217) ([underscorgan](https://github.com/underscorgan))

## [1.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.2.0) - 2014-11-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.1.0...1.2.0)

### Other

- Add missing doc update. [#216](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/216) ([underscorgan](https://github.com/underscorgan))
- 1.2.0 prep [#215](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/215) ([underscorgan](https://github.com/underscorgan))
- Add `user` feature support to CVS provider [#213](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/213) ([jfautley](https://github.com/jfautley))
- (FM-1951) Ensure Git is installable on EL 5 platforms [#211](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/211) ([justinstoller](https://github.com/justinstoller))
- Convert specs to RSpec 2.99.2 syntax with Transpec [#210](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/210) ([igalic](https://github.com/igalic))
- (MODULES-428) Remove dummy warning [#209](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/209) ([hunner](https://github.com/hunner))
- Disable simplecov on Ruby 1.8.7 [#208](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/208) ([sodabrew](https://github.com/sodabrew))
- Handle both Array/Enumerable and String values for excludes parameter [#207](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/207) ([sodabrew](https://github.com/sodabrew))
- Remove excess whitespace [#206](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/206) ([sodabrew](https://github.com/sodabrew))
- Fix issue with puppet_module_install, removed and using updated method f... [#204](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/204) ([cyberious](https://github.com/cyberious))
- Update spec_helper for more consistency [#203](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/203) ([underscorgan](https://github.com/underscorgan))
- Change uid by Puppet execution API [#200](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/200) ([pbrit](https://github.com/pbrit))

## [1.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.1.0) - 2014-07-15

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.2...1.1.0)

### Other

- Release 1.1.0 [#196](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/196) ([hunner](https://github.com/hunner))
- Fix metadata.json to match checksum [#195](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/195) ([hunner](https://github.com/hunner))
- (maint) Use `copy_module_to` in `beaker_helper.rb` [#194](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/194) ([justinstoller](https://github.com/justinstoller))
- The helper calls host outside of an each loop [#193](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/193) ([hunner](https://github.com/hunner))
- Fix lint errors [#192](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/192) ([hunner](https://github.com/hunner))
- Update README.markdown to fix the formatting around the officially supported note. [#191](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/191) ([klynton](https://github.com/klynton))
- (MODULES-1014) Add rspec for noop mode [#189](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/189) ([petems](https://github.com/petems))
- Just use metadata now [#188](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/188) ([hunner](https://github.com/hunner))
- Update Markdown with missing Perforce details. [#187](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/187) ([p4paul](https://github.com/p4paul))
- (MODULES-660) Correct detached HEAD on latest [#173](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/173) ([hunner](https://github.com/hunner))

## [1.0.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.2) - 2014-07-01

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.1...1.0.2)

### Other

- Release 1.0.2 [#186](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/186) ([hunner](https://github.com/hunner))
- Synchronize .travis.yml [#185](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/185) ([cmurphy](https://github.com/cmurphy))
- Patch misuse of apply_manifest_on [#184](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/184) ([hunner](https://github.com/hunner))
- Start synchronizing module files [#182](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/182) ([cmurphy](https://github.com/cmurphy))
- Fix issue with node changing every checkin [#181](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/181) ([jbussdieker](https://github.com/jbussdieker))
- Add supported information and reorder to highlight support [#180](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/180) ([lrnrthr](https://github.com/lrnrthr))
- Rebase of PR #177 - Add HG Basic Auth [#178](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/178) ([sodabrew](https://github.com/sodabrew))
- Update noop to work [#176](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/176) ([hunner](https://github.com/hunner))
- Revert "Remove compatability guarantees for SLES" [#175](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/175) ([hunner](https://github.com/hunner))
- Basic Perforce provider [#171](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/171) ([p4paul](https://github.com/p4paul))

## [1.0.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.1) - 2014-06-19

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.0...1.0.1)

### Other

- (QENG-798) Update acceptance helpers to create distmoduledir [#174](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/174) ([justinstoller](https://github.com/justinstoller))
- Pending overflow depth test [#172](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/172) ([hunner](https://github.com/hunner))
- Release 1.0.1 [#170](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/170) ([hunner](https://github.com/hunner))
- Remove compatability guarantees for SLES [#168](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/168) ([hunner](https://github.com/hunner))
- Correct shallow clone count [#166](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/166) ([hunner](https://github.com/hunner))
- More typos [#165](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/165) ([hunner](https://github.com/hunner))
- Fix typo in mkdir [#164](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/164) ([hunner](https://github.com/hunner))
- Need to make the moduledir before scping the module to agents [#163](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/163) ([hunner](https://github.com/hunner))
- Patch beaker spec helper for create_remote_file [#162](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/162) ([hunner](https://github.com/hunner))
- Pin versions in the supported branch. [#158](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/158) ([underscorgan](https://github.com/underscorgan))
- Pin version of beaker-rspec to ~2.2 [#156](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/156) ([johnduarte](https://github.com/johnduarte))
- Remove beaker from Gemfile [#155](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/155) ([johnduarte](https://github.com/johnduarte))
- (MODULES-1014) Adding noop mode option [#153](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/153) ([petems](https://github.com/petems))
- Update .gitignore [#152](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/152) ([petems](https://github.com/petems))
- Update Modulefile to use hyphen in name, not slash [#149](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/149) ([lucas42](https://github.com/lucas42))

## [1.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/1.0.0) - 2014-06-04

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.2.0...1.0.0)

### Other

- 1.0.0 prep [#154](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/154) ([underscorgan](https://github.com/underscorgan))
- Update tests for ubuntu 14.04 [#151](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/151) ([hunner](https://github.com/hunner))
- Add optional keyfile argument to rake tasks [#150](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/150) ([johnduarte](https://github.com/johnduarte))
- Set git bare with revision test to fail [#148](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/148) ([johnduarte](https://github.com/johnduarte))
- Adjust Rake tasks for beaker testing [#147](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/147) ([johnduarte](https://github.com/johnduarte))
- Un-optional the non-optional commands. [#146](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/146) ([daenney](https://github.com/daenney))
- Update specs and fix FM-1361 [#145](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/145) ([hunner](https://github.com/hunner))
- Move protocol tests to beaker suite [#144](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/144) ([johnduarte](https://github.com/johnduarte))
- Updated modulefile and added metadata.json for 1.0.0 release. [#143](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/143) ([underscorgan](https://github.com/underscorgan))
- Ensure vagrant user/group for non-vagrant testing [#142](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/142) ([johnduarte](https://github.com/johnduarte))
- Add beaker tests to complete test plan [#141](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/141) ([johnduarte](https://github.com/johnduarte))
- Add rake tasks to test both beaker and beaker-rspec in one go [#140](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/140) ([cyberious](https://github.com/cyberious))
- Fix detached head state [#139](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/139) ([cyberious](https://github.com/cyberious))
- Fix issue where force=>true was not destroying repository then recreatin... [#138](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/138) ([cyberious](https://github.com/cyberious))
- Add test for ensure latest with branch specified [#137](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/137) ([johnduarte](https://github.com/johnduarte))
- Add acceptance tests for git protocols using clone [#135](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/135) ([johnduarte](https://github.com/johnduarte))
- fix tabbing in vcsrepo test [#131](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/131) ([igalic](https://github.com/igalic))
- add beaker-rspec support [#130](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/130) ([Phil0xF7](https://github.com/Phil0xF7))
- Only add ssh options to commands that actually talk to the network. [#121](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/121) ([fkrull](https://github.com/fkrull))
- Use `git rev-parse` to get tag canonical revision [#120](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/120) ([huandu](https://github.com/huandu))
- fix svnlook behavior with plain directories [#117](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/117) ([jonoterc](https://github.com/jonoterc))
- git: actually use the remote parameter [#115](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/115) ([mciurcio](https://github.com/mciurcio))
- Add the option to shallow clones with git [#114](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/114) ([freyes](https://github.com/freyes))
- Bug fix: Git provider on_branch? retains trailing newline [#109](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/109) ([mikegerwitz](https://github.com/mikegerwitz))
- Call set_ownership from the bzr provider [#108](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/108) ([sodabrew](https://github.com/sodabrew))
- Correctly handle detached head for 'latest' on latest Git versions [#106](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/106) ([mikegerwitz](https://github.com/mikegerwitz))
- Don't 'su' if passed user is current user [#105](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/105) ([mcanevet](https://github.com/mcanevet))
- Prepare 0.2.0 release. [#102](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/102) ([apenney](https://github.com/apenney))

## [0.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.2.0) - 2013-11-13

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.2...0.2.0)

### Other

- Add autorequire for Package['git'] [#98](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/98) ([reidmv](https://github.com/reidmv))
- Add a blank dependencies section and stringify versions. [#96](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/96) ([apenney](https://github.com/apenney))
- FM-103: Add metadata.json to all modules. [#95](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/95) ([apenney](https://github.com/apenney))
- Move from rspec1 to rspec2 [#93](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/93) ([apenney](https://github.com/apenney))
- Documented the "module" attribute. [#92](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/92) ([markleightonfisher](https://github.com/markleightonfisher))
- update git provider to handle checking out into an existing (empty) dir [#91](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/91) ([jiacona](https://github.com/jiacona))
- SVN provider should check for '^Revision:' and not '^Last Changed Rev:' [#89](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/89) ([razorsedge](https://github.com/razorsedge))
- Correct use of withenv [#86](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/86) ([sodabrew](https://github.com/sodabrew))
- Try to get Travis to respect the three different puppet versions [#85](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/85) ([sodabrew](https://github.com/sodabrew))
- added support for changing upstream repo url - rebase of #74 [#84](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/84) ([sodabrew](https://github.com/sodabrew))
- Add support for master svn repositories [#83](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/83) ([sodabrew](https://github.com/sodabrew))
- Allow for setting the CVS_RSH environment variable [#82](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/82) ([mpdude](https://github.com/mpdude))
- Adding svn configuration parameter, and docs [#81](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/81) ([sepulworld](https://github.com/sepulworld))
- fix git provider checkout of a remote ref on an existing repo [#78](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/78) ([jhoblitt](https://github.com/jhoblitt))
- Add user and ssh identity to the Mercurial provider. [#77](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/77) ([arnoudj](https://github.com/arnoudj))
- Add travis build-status image [#76](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/76) ([pbrit](https://github.com/pbrit))
- Fix mocha for specs [#75](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/75) ([sodabrew](https://github.com/sodabrew))
- Improve Git SSH usage documentation [#73](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/73) ([MattiSG](https://github.com/MattiSG))
- Add timeout to ssh connections [#65](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/65) ([rkhatibi](https://github.com/rkhatibi))
- Update Modulefile for 0.1.2 release to Forge [#62](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/62) ([ryanycoleman](https://github.com/ryanycoleman))
- "ensure => latest" support for bzr [#61](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/61) ([hholzgra](https://github.com/hholzgra))
- Enable unlimited nesting for submodule updating [#46](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/46) ([pbrit](https://github.com/pbrit))
- Handle force in svn args [#40](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/40) ([ajohnstone](https://github.com/ajohnstone))

## [0.1.2](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.2) - 2013-03-25

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.1...0.1.2)

### Other

- Allow non-root users to clone a repo [#59](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/59) ([binford2k](https://github.com/binford2k))
- Tighten regex to avoid matching the word 'commit' in message [#58](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/58) ([sim0nf](https://github.com/sim0nf))
- Allows the creation of non-root repositories [#57](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/57) ([binford2k](https://github.com/binford2k))
- Update origin if necessary before checking revision [#56](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/56) ([raphink](https://github.com/raphink))

## [0.1.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.1) - 2012-10-30

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.1.0...0.1.1)

### Other

- Updated git documentation [#37](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/37) ([cprice404](https://github.com/cprice404))
- Replace references to Reductive Labs with Puppet Labs [#36](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/36) ([lifton](https://github.com/lifton))
- Add a dummy provider, remove 'defaultfor' from all other providers. [#35](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/35) ([sodabrew](https://github.com/sodabrew))
- Adds comma to last attribute to comply with style [#31](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/31) ([ghoneycutt](https://github.com/ghoneycutt))
- Removes trailing whitespace [#30](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/30) ([ghoneycutt](https://github.com/ghoneycutt))
- Add default user to run git as. [#27](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/27) ([ody](https://github.com/ody))

## [0.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.1.0) - 2012-10-12

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.0.5...0.1.0)

### Other

- (#16495, #15660) Fix regression for notifications and pulls on git provider [#33](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/33) ([kbarber](https://github.com/kbarber))
- 0.1.0 Release [#32](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/32) ([ryanycoleman](https://github.com/ryanycoleman))
- Checkout git repository as user, fixed ensure latest, ssh options [#25](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/25) ([ejhayes](https://github.com/ejhayes))
- Add the ability to specify a git remote [#24](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/24) ([jesusaurus](https://github.com/jesusaurus))
- Fix failing hg provider spec [#23](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/23) ([jmchilton](https://github.com/jmchilton))
- Improved Puppet DSL style as per the guidelines. [#19](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/19) ([adamgibbins](https://github.com/adamgibbins))
- don't recreate bare repo if it exists already - fixes http://projects.puppetlabs.com/issues/12303 [#18](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/18) ([andreasgerstmayr](https://github.com/andreasgerstmayr))
- (#11798) Fix git checkout of revisions [#17](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/17) ([mmrobins](https://github.com/mmrobins))

## [0.0.5](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.0.5) - 2011-12-26

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.0.4...0.0.5)

### Other

- Added missing 'working_copy_exists?' method. [#16](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/16) ([mfournier](https://github.com/mfournier))
- Fix (#10787) - Various fixes/tweaks for the CVS provider [#15](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/15) ([](https://github.com/))
- Fix (#10788) - Avoid unnecessary remote operations in the vcsrepo type [#14](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/14) ([](https://github.com/))
- Suggested fix for (#10751) by adding a "module" parameter [#13](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/13) ([](https://github.com/))
- Fix (#9083) as suggested by the original bug reporter. [#12](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/12) ([](https://github.com/))
- Bug Fix: Some ownerships in .git directory are 'root' after vcsrepo's retrieve is called [#11](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/11) ([cPanelScott](https://github.com/cPanelScott))
- Fix (#10440) by making all commands optional [#9](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/9) ([](https://github.com/))

## [0.0.4](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/0.0.4) - 2011-09-21

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/cb2efcdfaa1f9b6d8c78208151d4b4ebd4e35885...0.0.4)
