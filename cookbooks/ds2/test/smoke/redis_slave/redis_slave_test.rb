# # encoding: utf-8

# Inspec test for recipe .::mysql

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(6379) do
  it { should be_listening }
end

describe service('redis@slave') do
  it { should be_installed }
  it { should be_enabled }
  it { should be_running }
end

describe command("redis-cli -h 192.168.10.13 -p 6379 -a distributed_system2 info") do
  its('exit_status') { should eq 0 }
  its(:stdout) { should match %r{role:slave} }
  its(:stdout) { should match %r{master_host:192.168.10.12} }
  its(:stdout) { should match %r{master_port:6379} }
end
