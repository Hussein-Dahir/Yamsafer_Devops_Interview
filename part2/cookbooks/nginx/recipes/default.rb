#
# Cookbook:: nginx
# Recipe:: default
#
# Copyright:: 2017, The Authors, All Rights Reserved.

include_recipe 'nginx::server'
include_recipe 'nginx::add_to_elb'
