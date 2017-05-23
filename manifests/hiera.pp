# == Class: vcsrepo::hiera
#
# A clss that allows for hiera creation of the resource vcsrepo
#
# == Parameters
#
# [*repo*]
# Hash of vcsrepo definitions
#
class vcsrepo::hiera (
  Optional[Hash] $repo = {}
){
  create_resources('vcsrepo', $repo)
}
