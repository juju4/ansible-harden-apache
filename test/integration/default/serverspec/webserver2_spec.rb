require 'serverspec'

# Required by serverspec
set :backend, :exec


describe command('curl -kv https://localhost/doesnotexist') do
  its(:stdout) { should match /404 Not Found/ }
end

describe command('curl -kv https://localhost/server-status') do
  its(:stdout) { should match /404 Not Found/ }
end
