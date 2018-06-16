# # encoding: utf-8

# Inspec test for recipe .::mysql

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(3306) do
  it { should be_listening }
end

describe service('mysql-master') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

sql_command = 'mysql -S /var/run/mysql-master/mysqld.sock -uroot -pds2_root_pw'

describe command("echo 'show databases;' | #{sql_command}") do
  its('exit_status') { should eq 0 }
end

describe file('/etc/mysql-master/conf.d/master.cnf') do
  it { should be_file }
  it { should be_owned_by 'mysql' }
  it { should be_mode 416 }
  its(:content) { should match(/log-bin = mysql-bin/) }
  its(:content) { should match(/binlog_format = MIXED/) }
end

describe command("echo \"show variables like '%log%';\"| #{sql_command}") do
  its(:stdout) { should match %r{log_bin[\s]+ON} }
  its(:stdout) { should match %r{binlog_format[\s]+MIXED} }
end