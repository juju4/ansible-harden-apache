require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('curl -kv https://localhost/'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:stdout) { should match /Apache2 Ubuntu Default Page: It works/ }
  its(:stderr) { should match /SSL connection using TLS1.2/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/ }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:stderr) { should match /default-src 'self'; script-src 'self' 'unsafe-inline'; connect-src 'self'; img-src 'self'; style-src 'self' 'unsafe-inline'; object-src 'self';/ }
end
describe command('curl -kv https://localhost/'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  its(:stdout) { should match /Apache2 Ubuntu Default Page: It works/ }
  its(:stderr) { should match /SSL connection using ECDHE-RSA-AES256-GCM-SHA384/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/ }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:stderr) { should match /default-src 'self'; script-src 'self' 'unsafe-inline'; connect-src 'self'; img-src 'self'; style-src 'self' 'unsafe-inline'; object-src 'self';/ }
end
describe command('curl -kv https://localhost/'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /Apache HTTP Server Test Page powered by CentOS/ }
  its(:stderr) { should match /SSL connection using TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384/ }
  its(:stderr) { should match /X-Frame-Options: sameorigin/ }
  its(:stderr) { should match /X-XSS-Protection: 1; mode=block/ }
  its(:stderr) { should match /default-src 'self'; script-src 'self' 'unsafe-inline'; connect-src 'self'; img-src 'self'; style-src 'self' 'unsafe-inline'; object-src 'self';/ }
end
describe command('curl -kv https://localhost/doesnotexist') do
  its(:stdout) { should match /404 Not Found/ }
end

