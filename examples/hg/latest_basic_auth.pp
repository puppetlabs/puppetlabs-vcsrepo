vcsrepo { '/tmp/vcstest-hg-clone':
  ensure   => latest,
  provider => hg,
  source   => 'http://hg.basho.com/riak',
  revision => 'riak-0.5.3',
  basic_auth_username	=> 'username',
  basic_auth_password	=> 'eightstars',
}