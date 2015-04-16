#
# Cookbook Name:: ns
# Recipe:: default
#
# Copyright (C) 2015 YOUR_NAME
#
# All rights reserved - Do Not Redistribute
#

package 'bind9' do
  action :install
end

directory '/var/log/bind' do
  owner "bind"
  group "bind"
  mode "0755"
end

template "/etc/bind/named.conf" do
  source "named.conf"
  owner "root"
  group "bind"
  mode "0644"
end

template "/etc/bind/named.conf.acl" do
  source "named.conf.acl.erb"
  owner "root"
  group "bind"
  mode "0644"
  variables(
    :local_hostname   => node['local']['hostname'],
    :local_ip4addr    => node['local']['ip4addr'],
    :primary_hostname => node['primary']['hostname'],
    :primary_ip4addr  => node['primary']['ip4addr'],
  )
  notifies :restart, 'service[bind9]', :delayed
end

template "/etc/bind/named.conf.options" do
  source "named.conf.options.erb"
  owner "root"
  group "bind"
  mode "0644"
  variables(
    :local_hostname   => node['local']['hostname'],
    :local_ip4addr    => node['local']['ip4addr'],
    :primary_hostname => node['primary']['hostname'],
    :primary_ip4addr  => node['primary']['ip4addr'],
  )
  notifies :restart, 'service[bind9]', :delayed
end

template "/etc/bind/named.conf.local" do
  source "named.conf.local.erb"
  owner "root"
  group "bind"
  mode "0644"
  variables(
    :local_hostname   => node['local']['hostname'],
    :local_ip4addr    => node['local']['ip4addr'],
    :primary_hostname => node['primary']['hostname'],
    :primary_ip4addr  => node['primary']['ip4addr'],
  )
  notifies :restart, 'service[bind9]', :delayed
end

service 'bind9'
