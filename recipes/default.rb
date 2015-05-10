#
# Cookbook Name:: cm-update-server
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

node_app_path = "/opt/nodejs"
install_path = "#{node_app_path}/cm-update-server"

directory node_app_path do
  owner "root"
  group "root"
end

include_recipe "git"

git "cm-update-server" do
  repository "https://github.com/patcon/cm-update-server.git"
  revision "feature/update-docs-setup"
  destination install_path
  action :sync
end

execute "git checkout HEAD --force" do
  cwd install_path
end

execute "npm update" do
  user "root"
  cwd install_path
end

environments = ["production"]

environments.each do |env|
  cookbook_file "config-default.js" do
    path "#{install_path}/config/#{env}.js"
  end

  template "config-default.json" do
    path "#{install_path}/config/#{env}.json"
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
