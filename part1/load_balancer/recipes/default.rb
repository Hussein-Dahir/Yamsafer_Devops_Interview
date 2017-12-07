#
# Cookbook:: load_balancer
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

chef_gem 'aws-sdk-ec2' do
  action :nothing
  compile_time false
end.run_action(:install)
require 'aws-sdk-ec2'

package 'nginx' do
  action :install
end

service 'nginx' do
  action [ :enable, :start ]
end

template '/etc/nginx/conf.d/load-balancer.conf' do
  source 'load_balancer.erb'
end

execute 'remove_default' do
  command 'sudo rm /etc/nginx/sites-enabled/default'
  action :run
end

execute 'restart_service' do
  command 'sudo service nginx restart'
  action :run
end

#service 'nginx' do
#  action [ :restart ]
#end

