#
# Cookbook:: squid
# Recipe:: squid-cache
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

ip_address = node['attr']['ipaddress'] || '8.8.8.8'
execute "squid_config_dns" do
	command "echo \"\ndns_nameservers #{ip_address}\" >> /etc/squid/squid.conf"
	action :run
end

# Habilita y arranca Squid
service 'squid' do
  action [:enable, :start]
end

execute 'restart_squid' do
	command 'sudo systemctl restart squid'
	action :run
end

