require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/etc/rsyslog.d/apache2syslog') do
  it { should be_file }
  it { should be_readable }
  its(:content) { should match /InputFileTag apache-access:/ }
end

describe command('rsyslogd -N2') do
  its(:stderr) { should match /rsyslogd: End of config validation run. Bye./ }
  its(:exit_status) { should eq 0 }
end
