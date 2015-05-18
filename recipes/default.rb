#
# Cookbook Name:: cm-update-server
# Recipe:: default
#
# Copyright (C) 2015 Patrick Connolly
#
# All rights reserved - Do Not Redistribute
#

require 'pathname'

install_path = node['cm_update_server']['install_path']

node_app_path = Pathname.new(install_path).dirname
directory node_app_path do
  owner "root"
  group "root"
  recursive true
end

include_recipe "git"

git "cm-update-server" do
  repository node['cm_update_server']['git_url']
  revision node['cm_update_server']['git_revision']

  destination install_path
  action :sync
end

execute "git checkout HEAD --force" do
  cwd install_path
end

include_recipe "nodejs::default"

execute "npm update" do
  user "root"
  cwd install_path
end

include_recipe "sqlite::default"

directory "#{install_path}/data"

environments = ["production"]

execute "node_modules/sequelize-cli/bin/sequelize init:config --force" do
  cwd install_path
end

execute "sed -i'' 's/mysql/sqlite/g' config/config.json" do
  cwd install_path
end

environments.each do |env|
  cookbook_file "config-default.js" do
    path "#{install_path}/config/#{env}.js"
  end

  template "config-default.json" do
    path "#{install_path}/config/#{env}.json"
  end

  execute "node_modules/sequelize-cli/bin/sequelize db:migrate --env #{env}" do
    cwd install_path
  end
end

include_recipe "forever"

forever_service "cm-update-server" do
  user "root"
  group "root"
  path install_path
  log_dir "/var/log"
  script "cm-update-server.js"
  script_options ""
  description "Cyanogenmod update server."
  action [ :enable, :start ]
end
