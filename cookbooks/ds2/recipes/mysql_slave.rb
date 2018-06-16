#
# Cookbook:: .
# Recipe:: mysql_slave
#
# Copyright:: 2018, Qiulin Wang, All Rights Reserved.

apt_update 'update_apt' do
  action :update
end

mysql_client 'default' do
  version node['ds2']['database']['version']
  action :create
end

mysql_service node['ds2']['database']['instance_name'] do
  bind_address node['ds2']['database']['host']
  port node['ds2']['database']['port']
  version node['ds2']['database']['version']
  initial_root_password node['ds2']['database']['root_password']
  run_user node['ds2']['database']['deploy_user']
  run_group node['ds2']['database']['deploy_group']
  action [:create, :start]
end

mysql_slave node['ds2']['database']['instance_name'] do
  id node['ds2']['database']['id']
  master_host node['ds2']['database']['master_host']
  user node['ds2']['database']['rep_user']
  password node['ds2']['database']['rep_password']
  database node['ds2']['database']['database']
end
