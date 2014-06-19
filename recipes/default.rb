#
# Cookbook Name:: twemproxy
# Recipe:: default
#
# Copyright 2014, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe 'apt'
include_recipe 'build-essential'
include_recipe 'redisio'
include_recipe 'redisio::install'
include_recipe 'redisio::enable'

package 'wget'

remote_file '/tmp/nutcracker-0.3.0.tar.gz' do
  source 'https://twemproxy.googlecode.com/files/nutcracker-0.3.0.tar.gz'
end

bash 'build and install nutcracker' do
  cwd '/tmp'
  code <<-EOF
    tar -xzf nutcracker-0.3.0.tar.gz
    (cd nutcracker-0.3.0 && ./configure)
    (cd nutcracker-0.3.0 && make && make install)
  EOF
end

directory "/etc/nutcracker" do
  action :create
end

template '/etc/nutcracker/nutcracker.yml' do
  source 'twemproxy.yml.erb'
  owner 'root'
  group 'root'
  mode '0755'
end

template '/etc/init.d/nutcracker' do
  source 'twemproxy.erb'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :enable, "service[nutcracker]"
  notifies :start, "service[nutcracker]"
end

service "nutcracker" do
  supports :restart => true, :start => true, :stop => true, :reload => true, :status => true
  action :nothing
end