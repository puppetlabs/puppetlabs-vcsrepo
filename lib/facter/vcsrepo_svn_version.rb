Facter.add(:vcsrepo_svn_version) do
  setcode do
    res = Facter::Core::Execution.execute('svn --version --quiet')
    return nil if res =~ /command not found/
    return res;
  end
end