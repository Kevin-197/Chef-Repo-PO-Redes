#
# Cookbook:: apache
# Recipe:: apache-priv
#
# Copyright:: 2023, The Authors, All Rights Reserved.

package 'squid' do
  action :install
end

remote_file '/etc/squid/squid.conf' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/squid.conf'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

# Habilita y arranca Squid
service 'squid' do
  action [:enable, :start]
end

