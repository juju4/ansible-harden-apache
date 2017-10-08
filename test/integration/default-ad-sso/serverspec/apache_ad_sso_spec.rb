require 'serverspec'

# Required by serverspec
set :backend, :exec

describe command('rpm -qa'), :if => os[:family] == 'redhat' do
  its(:stdout) { should match /krb5-libs/ }
  its(:stdout) { should match /mod_auth_kerb/ }
end

describe command('dpkg -l'), :if => os[:family] == 'ubuntu' do
  its(:stdout) { should match /krb5/ }
  its(:stdout) { should match /libapache2-mod-auth-kerb/ }
end
