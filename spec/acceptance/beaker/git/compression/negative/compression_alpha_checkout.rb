test_name 'C3505 - checkout with compression alpha'

# Globals
repo_name = 'testrepo_checkout'

hosts.each do |host|
  tmpdir = host.tmpdir('vcsrepo')
  step 'setup - create repo' do
    install_package(host, 'git')
    my_root = File.expand_path(File.join(File.dirname(__FILE__), '../../../../..'))
    scp_to(host, "#{my_root}/acceptance/files/create_git_repo.sh", tmpdir)
    on(host, "cd #{tmpdir} && ./create_git_repo.sh")
  end

  teardown do
    on(host, "rm -fr #{tmpdir}")
  end

  step 'checkout with compression alpha with puppet' do
    pp = <<-EOS
    vcsrepo { "#{tmpdir}/#{repo_name}":
      ensure => present,
      source => "file://#{tmpdir}/testrepo.git",
      provider => git,
      compression => abcde,
    }
    EOS

    apply_manifest_on(host, pp)
    apply_manifest_on(host, pp)
  end

  step 'verify git repo was checked out' do
    on(host, "ls #{tmpdir}/#{repo_name}/.git/") do |res|
      fail_test('checkout not found') unless res.stdout.include? "HEAD"
    end
  end

end