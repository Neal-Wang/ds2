#
# Cookbook:: .
# Recipe:: apache
#
# Copyright:: 2018, Qiulin Wang, All Rights Reserved.

apt_update 'update_apt' do
  action :update
end

include_recipe 'apache2'
