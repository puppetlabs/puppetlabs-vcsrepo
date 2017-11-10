Facter.add(:vcsrepo_git_ver) do
  setcode do
    begin
      version = Facter::Core::Execution.execute('git --version')
      version.match(%r{[0-9]+\.[0-9]+\.[0-9]+(\.[0-9]+)?})[0] unless version.nil?
    rescue
      ''
    end
  end
end
