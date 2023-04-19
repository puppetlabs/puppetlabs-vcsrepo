# Change log

All notable changes to this project will be documented in this file. The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](http://semver.org).

## [v6.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v6.0.0) (2023-04-19)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.5.0...v6.0.0)

### Changed

- \(CONT-803\) Add Support for Puppet 8 / Drop Support for Puppet 6 [\#601](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/601) ([david22swan](https://github.com/david22swan))

## [v5.5.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.5.0) (2023-04-19)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.4.0...v5.5.0)

## [v5.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.4.0) (2023-01-31)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.3.0...v5.4.0)

### Added

- support per-repo HTTP proxy for the git provider [\#576](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/576) ([bugfood](https://github.com/bugfood))
- support umask for git repos \(try 2\) [\#574](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/574) ([bugfood](https://github.com/bugfood))

### Fixed

- Bring back GIT\_SSH support for old git versions [\#582](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/582) ([vStone](https://github.com/vStone))
- fix repeated acceptance tests on the same container [\#575](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/575) ([bugfood](https://github.com/bugfood))
- pdksync - \(CONT-189\) Remove support for RedHat6 / OracleLinux6 / Scientific6 [\#573](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/573) ([david22swan](https://github.com/david22swan))
- pdksync - \(CONT-130\) - Dropping Support for Debian 9 [\#570](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/570) ([jordanbreen28](https://github.com/jordanbreen28))

## [v5.3.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.3.0) (2022-09-13)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.2.0...v5.3.0)

### Added

- pdksync - \(GH-cat-11\) Certify Support for Ubuntu 22.04 [\#563](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/563) ([david22swan](https://github.com/david22swan))
- Add skip\_hooks property to vcsrepo  [\#557](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/557) ([sp-ricard-valverde](https://github.com/sp-ricard-valverde))

### Fixed

- Only remove safe\_directory, if it exists [\#566](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/566) ([KoenDierckx](https://github.com/KoenDierckx))

## [v5.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.2.0) (2022-06-30)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.1.0...v5.2.0)

### Added

- pdksync - \(GH-cat-12\) Add Support for Redhat 9 [\#543](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/543) ([david22swan](https://github.com/david22swan))

### Fixed

- \(GH-552\) Fix home directory evaluation [\#553](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/553) ([chelnak](https://github.com/chelnak))

## [v5.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.1.0) (2022-06-24)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v5.0.0...v5.1.0)

### Added

- pdksync - \(IAC-1753\) - Add Support for AlmaLinux 8 [\#524](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/524) ([david22swan](https://github.com/david22swan))
- pdksync - \(IAC-1751\) - Add Support for Rocky 8 [\#523](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/523) ([david22swan](https://github.com/david22swan))
- pdksync - \(IAC-1709\) - Add Support for Debian 11 [\#521](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/521) ([david22swan](https://github.com/david22swan))

### Fixed

- \(GH-535\) Fix for safe directories [\#549](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/549) ([chelnak](https://github.com/chelnak))
- pdksync - \(GH-iac-334\) Remove Support for Ubuntu 14.04/16.04 [\#529](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/529) ([david22swan](https://github.com/david22swan))
- MODULES-11050 - Force fetch tags [\#527](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/527) ([sp-ricard-valverde](https://github.com/sp-ricard-valverde))
- pdksync - \(IAC-1787\) Remove Support for CentOS 6 [\#525](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/525) ([david22swan](https://github.com/david22swan))
- pdksync - \(IAC-1598\) - Remove Support for Debian 8 [\#522](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/522) ([david22swan](https://github.com/david22swan))

## [v5.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v5.0.0) (2021-06-02)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v4.0.0...v5.0.0)

### Changed

- Always run as given user, even if identity set [\#473](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/473) ([bigpresh](https://github.com/bigpresh))

## [v4.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v4.0.0) (2021-03-03)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.2.1...v4.0.0)

### Changed

- pdksync - Remove Puppet 5 from testing and bump minimal version to 6.0.0 [\#491](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/491) ([carabasdaniel](https://github.com/carabasdaniel))

## [v3.2.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.2.1) (2021-02-16)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.2.0...v3.2.1)

### Fixed

- \(MODULES-9997\) - Removing extra unwrap on Sensitive value [\#490](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/490) ([pmcmaw](https://github.com/pmcmaw))

## [v3.2.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.2.0) (2021-01-20)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.1.1...v3.2.0)

### Added

- pdksync - \(feat\) - Add support for Puppet 7 [\#476](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/476) ([daianamezdrea](https://github.com/daianamezdrea))
- pdksync - \(IAC-973\) - Update travis/appveyor to run on new default branch `main` [\#466](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/466) ([david22swan](https://github.com/david22swan))

### Fixed

- \[MODULES-10857\] Rename exist function to exists in cvs.rb [\#484](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/484) ([carabasdaniel](https://github.com/carabasdaniel))
- \(IAC-1223\) Correct clone https test [\#471](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/471) ([pmcmaw](https://github.com/pmcmaw))
- check if pass containes non-ASCII chars before provider is created [\#464](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/464) ([adrianiurca](https://github.com/adrianiurca))

## [v3.1.1](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.1.1) (2020-06-26)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.1.0...v3.1.1)

### Fixed

- prevent ANSI color escape sequences from messing up git output [\#458](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/458) ([kenyon](https://github.com/kenyon))
- Unset GIT\_SSH\_COMMAND before exec'ing git command [\#435](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/435) ([mzagrabe](https://github.com/mzagrabe))

## [v3.1.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.1.0) (2019-12-10)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/v3.0.0...v3.1.0)

### Added

- \(FM-8234\) Port to Litmus [\#429](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/429) ([sheenaajay](https://github.com/sheenaajay))
- pdksync - Add support on Debian10 [\#428](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/428) ([lionce](https://github.com/lionce))
- feature\(git\): add keep local changes option [\#425](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/425) ([jfroche](https://github.com/jfroche))

### Fixed

- feat: do not chown excluded files [\#432](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/432) ([jfroche](https://github.com/jfroche))

## [v3.0.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/v3.0.0) (2019-06-13)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.4.0...v3.0.0)

### Changed

- pdksync - \(MODULES-8444\) - Raise lower Puppet bound [\#413](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/413) ([david22swan](https://github.com/david22swan))

### Added

- \(FM-8035\) Add RedHat 8 support [\#419](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/419) ([eimlav](https://github.com/eimlav))
- \(MODULES-8738\) Allow Sensitive value for basic\_auth\_password [\#416](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/416) ([eimlav](https://github.com/eimlav))
- \(MODULES-8140\) - Add SLES 15 support [\#399](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/399) ([eimlav](https://github.com/eimlav))

### Fixed

- MODULES-8910 fix for failing git install using RepoForge instead of epel [\#414](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/414) ([Lavinia-Dan](https://github.com/Lavinia-Dan))
- \(maint\) Add HTML anchor tag [\#404](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/404) ([clairecadman](https://github.com/clairecadman))
- pdksync - \(FM-7655\) Fix rubygems-update for ruby \< 2.3 [\#401](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/401) ([tphoney](https://github.com/tphoney))

## [2.4.0](https://github.com/puppetlabs/puppetlabs-vcsrepo/tree/2.4.0) (2018-09-28)

[Full Changelog](https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.3.0...2.4.0)

### Added

- pdksync - \(FM-7392\) - Puppet 6 Testing Changes [\#394](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/394) ([pmcmaw](https://github.com/pmcmaw))
- pdksync - \(MODULES-6805\) metadata.json shows support for puppet 6 [\#393](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/393) ([tphoney](https://github.com/tphoney))
- pdksync - \(MODULES-7658\) use beaker4 in puppet-module-gems [\#390](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/390) ([tphoney](https://github.com/tphoney))
- \(MODULES-7467\) Update Vcsrepo to support Ubuntu 18.04 [\#382](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/382) ([david22swan](https://github.com/david22swan))

### Fixed

- \(MODULES-7009\) Do not run HTTPS tests on old OSes [\#384](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/384) ([tphoney](https://github.com/tphoney))
- Improve Git performance when using SHA revisions [\#380](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/380) ([vpierson](https://github.com/vpierson))
- \[FM-6957\] Removing unsupported OS from Vcsrepo [\#378](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/378) ([david22swan](https://github.com/david22swan))
- Avoid popup on macOS when developer tools aren't installed [\#367](https://github.com/puppetlabs/puppetlabs-vcsrepo/pull/367) ([girardc79](https://github.com/girardc79))

## 2.3.0

This release uses the PDK convert functionality which in return makes the module PDK compliant. It also includes a few features and a roll up of maintenance changes.

### Added
- Added trust_server_cert support to Git provider ([MODULES-5889](https://tickets.puppet.com/browse/MODULES-5889)).
- Do not ignore incorrect HTTP Basic auth property specifications.
- Adds some basic unit tests ([MODULES-5889](https://tickets.puppet.com/browse/MODULES-5889)).

### Fixed
- Addressing Rubocop errors throughout the module.
- Change expected exception type from Puppet::Error to RuntimeError.
- A typo in the CHANGELOG.md.
- A roll up of minor changes via modulesync_configs.

### Removed
- `gem update bundler` as the module runs into ([MODULES-6339](https://tickets.puppet.com/browse/MODULES-6339)).

## Supported Release [2.2.0]

### Summary
This is to enable Rubocop within the module.

### Added
- Rubocop has been enabled and will now run against all future pull requests.

### Fixed
- Entire module has been put through the rubocop process and now matches the expected standards.

## Supported Release [2.1.0]

### Summary
This is to provide a clean release from which to run Rubocop.

### Added
- Debian 9 as supported platform

### Fixed
- CVS working copy detection ([MODULES-5704](https://tickets.puppet.com/browse/MODULES-5704))
- typo error for sshed-git-source
- Update to existence test, Use 'svn info' instead of 'svn status'. 'svn status' does not return proper exit codes, while 'svn info' does.
- working_copy_exists in svn provider. Change method 'working_copy_exists' to use 'svn info' instead of 'svn status'. 'svn status' does not return proper exit codes, while 'svn info' does. ([MODULES-5615](https://tickets.puppet.com/browse/MODULES-5615))
- tests associated with hg
- hg provider: remove escaped quotes - authentication fix

### Removed
- Support for Ubuntu 10.04 and 12.04, existing compatibility is unaffected ([MODULES-5501](https://tickets.puppet.com/browse/MODULES-5501))
- Support for Debian 6 and SLES 10, existing compatibility is unaffected
- Commented out test ([MODULES-5162](https://tickets.puppet.com/browse/MODULES-5162))

## Supported Release [2.0.0]

### Summary
This is a major release that **drops support for Puppet 3** and addresses an issue with the subversion provider.

### Added
- Documentation for using an non-standard ssh port ([MODULES-1910](https://tickets.puppet.com/browse/MODULES-1910))
- Autorequire for the subversion package in the vcsrepo type ([MODULES-4722](https://tickets.puppetlabs.com/browse/MODULES-4722))
- Puppet 5 support in metadata ([MODULES-5144](https://tickets.puppet.com/browse/MODULES-5144))

### Changed
- Lower bound of Puppet requirement to 4.7.0 ([MODULES-4823](https://tickets.puppetlabs.com/browse/MODULES-4823))

### Fixed
- Solaris `SSH_AUTH_SOCKET` issue
- Issue with subversion provider ([MODULES-4280](https://tickets.puppetlabs.com/browse/MODULES-4280))
- `force` parameter to return a boolean instead of a string ([MODULES-4864](https://tickets.puppetlabs.com/browse/MODULES-4864))

## [1.5.0] - 2016-12-19 Supported Release

### Summary
Release featuring some refactoring and improvements around git's `ensurable`.

### Bugfixes
- `ensure => absent` fix

### Features
- `:source` property added
- Improved `ensure` handling for git provider
- General refactoring for all providers
- Various test improvements

## [1.4.0] - 2015-09-06 Supported Release

### Summary

Small release for a new feature and added compatibility.

### Features

- Git repositories can be cloned as mirror or bare repos.
- Added STDERR to Puppet's output.
- Added Debian 8 and Ubuntu 16.04 compatibility.

## [1.3.2] - 2015-12-08 Supported Release

### Summary

Small release for support of newer PE versions. This increments the version of PE in the metadata.json file.

## [1.3.1] - 2015-07-28 Supported Release

### Summary

This release includes a number of bugfixes and test updates.

### Fixed

- Fix for detached HEAD on git 2.4+.
- Git provider doesn't ignore revision property when depth is used (MODULES-2131).
- Tests fixed.
- Check if submodules == true before calling update_submodules.

## [1.3.0] - 2015-05-19 Supported Release

### Summary

This release adds git provider remote handling, svn conflict resolution, and fixes the git provider when /tmp is mounted noexec.

### Added

- `source` property now takes a hash of sources for the git provider's remotes.
- Added `submodules` parameter to skip submodule initialization for the git provider.
- Added `conflict` to the svn provider to resolve conflicts.
- Added `branch` parameter to specify clone branch.
- Readme rewritten.

### Fixed

- The git provider now works even if `/tmp` is noexec.

## [1.2.0] - 2014-11-04 Supported Release

### Summary

This release includes some improvements for git, mercurial, and cvs providers, and fixes the bug where there were warnings about multiple default providers.

### Added

- Update git and mercurial providers to set UID with `Puppet::Util::Execution.execute` instead of `su`
- Allow git excludes to be string or array
- Add `user` feature to cvs provider

### Fixed

- No more warnings about multiple default providers! (MODULES-428)

## [1.1.0] - 2014-07-14 Supported Release

### Summary

This release adds a Perforce provider\* and corrects the git provider behavior
when using `ensure => latest`.

\*(Only git provider is currently supported.)

### Added

- New Perforce provider.

### Fixed

- Fix behavior with `ensure => latest` and detached HEAD. (MODULES-660)
- Spec test fixes.

## [1.0.2] - 2014-06-30 Supported Release

### Summary

This supported release adds SLES 11 to the list of compatible OSs and
documentation updates for support.

## [1.0.1] - 2014-06-17 Supported Release

### Summary

This release is the first supported release of vcsrepo. The readme has been
greatly improved.

### Added

- Updated and expanded readme to follow readme template.

### Fixed

- Remove SLES from compatability metadata.
- Unpin rspec development dependencies.
- Update acceptance level testing.

## [1.0.0] - 2014-06-04

### Summary

This release focuses on a number of bugfixes, and also has some
new features for Bzr and Git.

### Added

- Bzr:
 - Call set_ownership.
- Git:
 - Add ability for shallow clones.
 - Use -a and desired for HARD resets.
 - Use rev-parse to get tag canonical revision.

### Fixed

- HG:
 - Only add ssh options when it's talking to the network.
- Git:
 - Fix for issue with detached HEAD.
 - `force => true` will now destroy and recreate repo.
 - Actually use the remote parameter.
 - Use origin/main instead of origin/HEAD when on main.
- SVN:
 - Fix svnlook behavior with plain directories.

## 0.2.0 - 2013-11-13

### Summary

This release mainly focuses on a number of bugfixes, which should
significantly improve the reliability of Git and SVN.  Thanks to
our many contributors for all of these fixes!

### Added

- Git:
 - Add autorequire for `Package['git']`.
- HG:
 - Allow user and identity properties.
- Bzr:
 - "ensure => latest" support.
- SVN:
 - Added configuration parameter.
 - Add support for main svn repositories.
- CVS:
 - Allow for setting the CVS_RSH environment variable.

### Fixed

- Handle Puppet::Util[::Execution].withenv for 2.x and 3.x properly.
- Change path_empty? to not do full directory listing.
- Overhaul spec tests to work with rspec2.
- Git:
 - Improve Git SSH usage documentation.
 - Add ssh session timeouts to prevent network issues from blocking runs.
 - Fix git provider checkout of a remote ref on an existing repo.
 - Allow unlimited submodules (thanks to --recursive).
 - Use git checkout --force instead of short -f everywhere.
 - Update git provider to handle checking out into an existing (empty) dir.
- SVN:
 - Handle force property.
 - Adds support for changing upstream repo url.
 - Check that the URL of the WC matches the URL from the manifest.
 - Changed from using "update" to "switch".
 - Handle revision update without source switch.
 - Fix svn provider to look for '^Revision:' instead of '^Last Changed Rev:'.
- CVS:
 - Documented the "module" attribute.

[2.3.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.2.0...2.3.0
[2.2.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.1.0...2.2.0
[2.1.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/2.0.0...2.1.0
[2.0.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.5.0...2.0.0
[1.5.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.4.0...1.5.0
[1.4.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.2...1.4.0
[1.3.2]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.1...1.3.2
[1.3.1]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.3.0...1.3.1
[1.3.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.2.0...1.3.0
[1.2.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.1.0...1.2.0
[1.1.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.2...1.1.0
[1.0.2]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.1...1.0.2
[1.0.1]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/1.0.0...1.0.1
[1.0.0]: https://github.com/puppetlabs/puppetlabs-vcsrepo/compare/0.2.0...1.0.0


\* *This Changelog was automatically generated by [github_changelog_generator](https://github.com/github-changelog-generator/github-changelog-generator)*
