# # encoding: utf-8

# Inspec test for recipe lamp::apache

# The Inspec reference, with examples and extensive documentation, can be
# found at http://inspec.io/docs/reference/resources/

describe port(80) do
  it { should be_listening }
end

describe apache do
  its('service') { should cmp 'apache2' }
  its('user') { should cmp 'www-data' }
end
