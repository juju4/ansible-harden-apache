require 'serverspec'

# Required by serverspec
set :backend, :exec

set welcome = 'Apache2 Ubuntu Default Page: It works'
if (os[:family] == 'ubuntu')
  set conn = 'SSL connection using TLSv1.3'
  set public_key = 'Public-Key: \(4096 bit\)'
else
  set conn = 'SSL connection using TLSv1.2'
  set public_key = 'Public-Key: \(2048 bit\)'
end

describe package('httpd'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe service('httpd'), :if => os[:family] == 'redhat' do
  it { should be_enabled }
  it { should be_running }
end

describe service('apache2'), :if => os[:family] == 'ubuntu' do
  it { should be_enabled }
  it { should be_running }
end

describe service('org.apache.httpd'), :if => os[:family] == 'darwin' do
  it { should be_enabled }
  it { should be_running }
end

#describe port(80) do
#  it { should be_listening }
#end
describe port(443) do
  it { should be_listening }
end

describe command('apachectl -M') do
  its(:stdout) { should contain('headers_module') }
  its(:stdout) { should contain('rewrite_module') }
  its(:stdout) { should contain('ssl_module') }
end

describe command('curl -vk https://localhost') do
  its(:stdout) { should match /#{welcome}/ }
  its(:stderr) { should match /#{conn}/ }
  its(:stderr) { should match /HTTP\/.* 200/ }
  its(:exit_status) { should eq 0 }
end
describe command('curl -vk https://localhost/nonexistent') do
  its(:stdout) { should match /<title>404 Not Found<\/title>/ }
  its(:stderr) { should match /HTTP\/.* 404/ }
  its(:exit_status) { should eq 0 }
end
describe command('curl -vk -X OPTIONS https://localhost') do
  its(:stdout) { should match /<title>403 Forbidden<\/title>/ }
  its(:stderr) { should match /HTTP\/.* 403/ }
  its(:exit_status) { should eq 0 }
end

describe command('openssl s_client -connect localhost:443 < /dev/null 2>/dev/null | openssl x509 -text -in /dev/stdin') do
  its(:stdout) { should match /sha256/ }
  its(:stdout) { should match /#{public_key}/ }
end
## enumerate ciphers? multiple openssl s_client, nmap, sslscan, ...
#http://superuser.com/questions/109213/how-do-i-list-the-ssl-tls-cipher-suites-a-particular-website-offers

## Test stapling: but can't do it with self-signed certificates ...
#describe command('openssl s_client -connect localhost:443 -status < /dev/null 2>/dev/null'), :if => (os[:family] == 'ubuntu' && (os[:release] == '16.04' || os[:release] == '14.04')) || (os[:family] == 'redhat' && os[:release] == '7') do
#  its(:stdout) { should match /OCSP Response Status: successful/ }
#  its(:stdout) { should_not match /OCSP response: no response sent/ }
#end
