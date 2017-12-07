#
# Cookbook:: nginx
# Recipe:: add_to_elb
#
# Copyright:: 2017, The Authors, All Rights Reserved.

chef_gem 'aws-sdk-elasticloadbalancing' do
  action :nothing
  compile_time false
end.run_action(:install)

chef_gem 'aws-sdk-ec2' do
  action :nothing
  compile_time false
end.run_action(:install)

include_recipe 'aws'

require 'aws-sdk-ec2'
require 'aws-sdk-elasticloadbalancing'

region_name = "eu-central-1"
credentials = Aws::Credentials.new("AKIAJQ6FNRMJW4BDFQ6Q", "n2BZYL9a4hBiMi+0B3spK0z0RHYXcqqfgYWpX6vs")

resource = Aws::ElasticLoadBalancing::Resource.new(region: region_name, credentials: credentials)
elb_client = resource.client()

ec2 = Aws::EC2::Resource.new(region: region_name, credentials: credentials)
ec2_client = ec2.client()

resp = ec2_client.describe_instances({
  filters: [
    {
      name: "private-ip-address", 
      values: [
        node['ipaddress'], 
      ], 
    }, 
  ], 
})

instance_id = resp.reservations[0].instances[0].instance_id

elb_client.register_instances_with_load_balancer({
  instances: [
    {
      instance_id: instance_id
    }
  ], 
  load_balancer_name: "load-balancer"
})