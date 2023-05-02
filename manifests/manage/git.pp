# @summary Manage the Git source code manager package
#
# @param package_name
#   name of package to manage
#
# @param package_ensure
#   ensure state of the package resource
#
# @example simple include
#   include vcsrepo::manage::git
class vcsrepo::manage::git (
  Variant[String[1], Array[String[1]]] $package_name = 'git',
  String[1] $package_ensure = 'installed',
) {
  package { $package_name:
    ensure => $package_ensure,
  }
}
