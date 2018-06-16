#
# Cookbook:: .
# Spec:: default
#
# Copyright:: 2018, Qiulin Wang, All Rights Reserved.

require 'spec_helper'

describe 'ds2::mysql_master' do
  context 'When all attributes are default, on Ubuntu 16.04' do
    let(:chef_run) do
      # for a complete list of available platforms and versions see:
      # https://github.com/customink/fauxhai/blob/master/PLATFORMS.md
      runner = ChefSpec::ServerRunner.new(platform: 'ubuntu', version: '16.04')
      runner.converge(described_recipe)
    end

    it 'converges successfully' do
      expect { chef_run }.to_not raise_error
    end

    it 'should update apt' do
      expect(chef_run).to update_apt_update('update_apt')
    end

    it 'should create mysql_client default' do
      expect(chef_run).to create_mysql_client('default')
    end

    it 'should create and start mysql_service default' do
      expect(chef_run).to create_mysql_service('default').with(
        bind_address: 'localhost',
        port: 3306, version: '5.7',
        initial_root_password: 'ds2_root_pw',
        run_user: 'mysql',
        run_group: 'mysql',
        action: [:create, :start])
    end

    it 'should configure mysql_master' do
      expect(chef_run).to create_mysql_master('default').with(
        id: 0,
        user: 'repl',
        password: 'ds2_rep_pw',
        binlog_do_db: 'mysql')
    end
  end
end
