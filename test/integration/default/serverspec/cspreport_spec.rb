require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('curl -kv https://localhost/csp/report.php') do
  its(:stderr) { should match /HTTP\/1.1 204 No Content/ }
  its(:stderr) { should_not match /HTTP\/1.0 500 Internal Server Error/ }
end
describe command('curl -kv https://localhost/csp/report.php'), :if => os[:family] != 'ubuntu' || os[:release] != '18.04' do
  its(:stderr) { should match /SSL connection using TLS1.2/ }
end
describe command('curl -kv https://localhost/csp/report.php'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  its(:stderr) { should match /SSL connection using TLSv1.2/ }
end
