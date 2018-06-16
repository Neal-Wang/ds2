#
# Cookbook:: .
# Recipe:: mysql
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

mysql_master node['ds2']['database']['instance_name'] do
  id node['ds2']['database']['id']
  user node['ds2']['database']['rep_user']
  password node['ds2']['database']['rep_password']
  binlog_do_db node['ds2']['database']['binlog_do_db']
end
