require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('curl -kv https://localhost/csp/report.php') do
  its(:stderr) { should match /HTTP\/1.1 204 No Content/ }
  its(:stderr) { should_not match /HTTP\/1.0 500 Internal Server Error/ }
  its(:stderr) { should match /SSL connection using TLS1.2/ }
end
