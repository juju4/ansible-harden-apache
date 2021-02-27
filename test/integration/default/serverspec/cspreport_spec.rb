require 'serverspec'

# Required by serverspec
set :backend, :exec

set conn = 'SSL connection using TLSv1.3'
if (os[:family] == 'ubuntu')
  set conn = 'SSL connection using TLSv1.3'
elsif (os[:family] == 'centos' && os[:release] == '8')
  set conn = 'SSL connection using TLSv1.3'
elsif (os[:family] == 'redhat' && os[:release] == '7')
  set conn = 'SSL connection using TLS_ECDHE'
elsif (os[:family] == 'centos' && os[:release] == '7')
  set conn = 'SSL connection using TLS_ECDHE'
else
  set conn = 'SSL connection using TLSv1.2'
end

describe command('curl -kv https://localhost/csp/report.php') do
  its(:stderr) { should match /HTTP\/1.1 204 No Content/ }
  its(:stderr) { should_not match /HTTP\/1.0 500 Internal Server Error/ }
end
describe command('curl -kv https://localhost/csp/report.php') do
  its(:stderr) { should match /#{conn}/ }
  its(:stderr) { should match os[:family] }
end
