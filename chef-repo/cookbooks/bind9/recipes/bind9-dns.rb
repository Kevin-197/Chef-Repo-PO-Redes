#
# Cookbook Name:: bind9
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

package 'bind9' do
	action :install
end
  
remote_file '/etc/bind/named.conf.local' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/named.conf.local'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end
  
remote_file '/etc/bind/zones/asimov.io.zone' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/asimov.io.zone'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

remote_file '/etc/bind/zones/dostoievski.io.zone' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/dostoievski.io.zone'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

remote_file '/etc/bind/zones/google.com.zone' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/google.com.zone'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

remote_file '/etc/bind/named.conf.options' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/named.conf.options'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

service 'bind9' do
	action [:start, :enable]
  end
  