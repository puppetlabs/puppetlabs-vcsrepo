##2014-11-04 - Supported Release 1.2.0
###Summary

This release includes some improvements for git, mercurial, and cvs providers, and fixes the bug where there were warnings about multiple default providers.

####Features
- Update git and mercurial providers to set UID with `Puppet::Util::Execution.execute` instead of `su`
- Allow git excludes to be string or array
- Add `user` feature to cvs provider

####Bugfixes
- No more warnings about multiple default providers! (MODULES-428)

##2014-07-14 - Supported Release 1.1.0
###Summary
This release adds a Perforce provider* and corrects the git provider behavior
when using `ensure => latest`.

*(Only git provider is currently supported.)

####Features
- New Perforce provider

####Bugfixes
- (MODULES-660) Fix behavior with `ensure => latest` and detached HEAD
- Spec test fixes

##2014-06-30 - Supported Release 1.0.2
###Summary
This supported release adds SLES 11 to the list of compatible OSs and
documentation updates for support.

##2014-06-17 - Supported Release 1.0.1
###Summary
This release is the first supported release of vcsrepo. The readme has been
greatly improved.

####Features
- Updated and expanded readme to follow readme template

####Fixes
- Remove SLES from compatability metadata
- Unpin rspec development dependencies
- Update acceptance level testing

##2014-06-04 - Version 1.0.0
###Summary

This release focuses on a number of bugfixes, and also has some
new features for Bzr and Git.

####Features
- Bzr:
 - Call set_ownership
- Git:
 - Add ability for shallow clones
 - Use -a and desired for HARD resets
 - Use rev-parse to get tag canonical revision

####Fixes
- HG:
 - Only add ssh options when it's talking to the network
- Git:
 - Fix for issue with detached HEAD
 - force => true will now destroy and recreate repo
 - Actually use the remote parameter
 - Use origin/master instead of origin/HEAD when on master
- SVN:
 - Fix svnlook behavior with plain directories

##2013-11-13 - Version 0.2.0
###Summary

This release mainly focuses on a number of bugfixes, which should
significantly improve the reliability of Git and SVN.  Thanks to
our many contributors for all of these fixes!

####Features
- Git:
 - Add autorequire for Package['git']
- HG:
 - Allow user and identity properties.
- Bzr:
 - "ensure => latest" support.
- SVN:
 - Added configuration parameter.
 - Add support for master svn repositories.
- CVS:
 - Allow for setting the CVS_RSH environment variable.

####Fixes
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
 - Handle force property. for svn.
 - Adds support for changing upstream repo url.
 - Check that the URL of the WC matches the URL from the manifest.
 - Changed from using "update" to "switch".
 - Handle revision update without source switch.
 - Fix svn provider to look for '^Revision:' instead of '^Last Changed Rev:'.
- CVS:
 - Documented the "module" attribute.
