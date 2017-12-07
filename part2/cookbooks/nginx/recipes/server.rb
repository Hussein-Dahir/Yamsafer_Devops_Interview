#
# Cookbook:: nginx
# Recipe:: server
#
# Copyright:: 2017, The Authors, All Rights Reserved.

package 'nginx' do
  action :install
end

template '/var/www/html/index.html' do
  source 'index.html.erb'
end

service 'nginx' do
  action [ :enable, :start ]
end


