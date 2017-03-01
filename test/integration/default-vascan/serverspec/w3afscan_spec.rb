require 'serverspec'

# Required by serverspec
set :backend, :exec

describe file('/tmp/output-w3af.txt') do
  it { should be_file }
  its(:content) { should_not match /Connection refused/ }
## exceptions?
## The web application under test seems to be in a shared hosting
## Some URLs have no protection (X-Frame-Options header) against Click-Jacking attacks. (returning on page 404/403)
#  its(:content) { should_not match /vulnerability/ }

## essay...
#  it "should not contain any critical vulnerability" do
#    :content.each_line do |line|
#      if line.match(/vulnerability/) and not line.match(/The web application under test seems to be in a shared hosting/) and not line.match(/Some URLs have no protection \(X-Frame-Options header\) against Click-Jacking attacks/)
#        it should_not be
#      end
#    end
#  end
end
