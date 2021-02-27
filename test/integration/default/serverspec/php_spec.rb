require 'serverspec'

# Required by serverspec
set :backend, :exec

describe package('php'), :if => os[:family] == 'redhat' do
  it { should be_installed }
end

describe package('php-common'), :if => os[:family] == 'ubuntu' do
  it { should be_installed }
end

describe command('php -i') do
  its(:stdout) { should contain('PHP License') }
  its(:stdout) { should contain('phpinfo()') }
  its(:stdout) { should contain('PHP Version =>') }
end

describe command('php -i'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  its(:stdout) { should contain('snuffleupagus support => enabled') }
end
describe command('php -i'), :if => os[:family] == 'ubuntu' && os[:release] == '18.04' do
  its(:stdout) { should contain('snuffleupagus support => enabled') }
end

describe file('/etc/php/7.0/apache2/php.ini'), :if => os[:family] == 'ubuntu' && os[:release] == '16.04' do
  it { should be_file }
  it { should exist }
  its(:content) { should match /^expose_php = Off/ }
  its(:content) { should match /^allow_url_fopen = Off/ }
  its(:content) { should match /^disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,chown,diskfreespace,disk_free_space,disk_total_space,dl,exec,escapeshellarg,escapeshellcmd,fileinode,highlight_file,max_execution_time,passthru,pclose,phpinfo,popen,proc_close,proc_open,proc_get_status,proc_nice,proc_open,proc_terminate,set_time_limit,shell_exec,show_source,system,serialize,unserialize,__construct, __destruct, __call,__wakeup/ }
  its(:content) { should match /^memory_limit = 128M/ }
  its(:content) { should match /^include_path = \/usr\/share\/php/ }
  its(:content) { should match /^session.use_strict_mode = 1/ }
  its(:content) { should match /^session.cookie_secure = true/i }
  its(:content) { should match /^session.cookie_httponly = true/i }
end

describe file('/etc/php5/apache2/php.ini'), :if => os[:family] == 'ubuntu' && os[:release] == '14.04' do
  it { should be_file }
  it { should exist }
  its(:content) { should match /^expose_php = Off/ }
  its(:content) { should match /^allow_url_fopen = Off/ }
  its(:content) { should match /^disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,chown,diskfreespace,disk_free_space,disk_total_space,dl,exec,escapeshellarg,escapeshellcmd,fileinode,highlight_file,max_execution_time,passthru,pclose,phpinfo,popen,proc_close,proc_open,proc_get_status,proc_nice,proc_open,proc_terminate,set_time_limit,shell_exec,show_source,system,serialize,unserialize,__construct, __destruct, __call,__wakeup/ }
  its(:content) { should match /^memory_limit = 128M/ }
  its(:content) { should match /^include_path = \/usr\/share\/php/ }
  its(:content) { should match /^session.use_strict_mode = 1/ }
  its(:content) { should match /^session.cookie_secure = true/ }
  its(:content) { should match /^session.cookie_httponly = true/ }
end

describe file('/etc/php.ini'), :if => os[:family] == 'redhat' do
  it { should be_file }
  it { should exist }
  its(:content) { should match /^expose_php = Off/ }
  its(:content) { should match /^allow_url_fopen = Off/ }
  its(:content) { should match /^disable_functions = pcntl_alarm,pcntl_fork,pcntl_waitpid,pcntl_wait,pcntl_wifexited,pcntl_wifstopped,pcntl_wifsignaled,pcntl_wexitstatus,pcntl_wtermsig,pcntl_wstopsig,pcntl_signal,pcntl_signal_dispatch,pcntl_get_last_error,pcntl_strerror,pcntl_sigprocmask,pcntl_sigwaitinfo,pcntl_sigtimedwait,pcntl_exec,pcntl_getpriority,pcntl_setpriority,chown,diskfreespace,disk_free_space,disk_total_space,dl,exec,escapeshellarg,escapeshellcmd,fileinode,highlight_file,max_execution_time,passthru,pclose,phpinfo,popen,proc_close,proc_open,proc_get_status,proc_nice,proc_open,proc_terminate,set_time_limit,shell_exec,show_source,system,serialize,unserialize,__construct, __destruct, __call,__wakeup/ }
  its(:content) { should match /^memory_limit = 128M/ }
  its(:content) { should match /^include_path = \/usr\/share\/php/ }
  its(:content) { should match /^session.use_strict_mode = 1/ }
  its(:content) { should match /^session.cookie_secure = true/ }
  its(:content) { should match /^session.cookie_httponly = true/ }
end
