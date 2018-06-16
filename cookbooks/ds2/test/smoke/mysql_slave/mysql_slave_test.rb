# # encoding: utf-8

# Inspec test for recipe .::mysql_slave

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(3306) do
  it { should be_listening }
end

describe service('mysql-slave') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

sql_command = 'mysql -S /var/run/mysql-slave/mysqld.sock -uroot -pds2_root_pw'

describe command("echo 'show databases;' | #{sql_command}") do
  its('exit_status') { should eq 0 }
end

describe file('/etc/mysql-slave/conf.d/slave.cnf') do
  it { should be_file }
  it { should be_owned_by 'mysql' }
  it { should be_mode 416 }
end

describe command("echo 'show slave status\\G' | #{sql_command}") do
  its(:stdout) { should match %r{Slave_IO_Running: Yes} }
  its(:stdout) { should match %r{Slave_SQL_Running: Yes} }
  its(:stdout) { should match %r{Master_Host: 192.168.10.10} }
end