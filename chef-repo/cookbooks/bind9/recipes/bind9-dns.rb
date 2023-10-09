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

directory '/etc/bind/zones' do
	owner 'root'     
	group 'root'     
	mode '0755'      
	recursive true   
	action :create   
end
  
remote_file '/etc/bind/zones/asimov.io.zone' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/asimov.io.zone'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

apache1 = node['attr']['dns_apache1_ip'] || '127.0.0.0'
apache2 = node['attr']['dns_apache2_ip'] || '127.0.0.0'
hostname = node['attr']['hostname'] || 'localhost'

file '/etc/bind/zones/dostoievski.io.zone' do
	content "$TTL 604800 \n
	@   IN  SOA #{hostname}.dostoievski.io. admin.dostoievski.io. (\n
								  2         ; Serial\n
							 604800         ; Refresh\n
							  86400         ; Retry\n
							2419200         ; Expire\n
							 604800 )       ; Negative Cache TTL\n
	@   IN  NS  #{hostname}.dostoievski.io.\n
	@   IN  A   #{apache2}\n
	*   IN  A   #{apache2}\n
	isaac  IN  A   #{apache1}"
	action :create
end 

file '/etc/bind/zones/asimov.io.zone' do
	content "$TTL 604800 \n
	@   IN  SOA #{hostname}.asimov.io. admin.asimov.io. (\n
								  2         ; Serial\n
							 604800         ; Refresh\n
							  86400         ; Retry\n
							2419200         ; Expire\n
							 604800 )       ; Negative Cache TTL\n
	@   IN  NS  #{hostname}.asimov.io.\n
	@   IN  A   #{apache1}\n
	*   IN  A   #{apache1}\n
	fiodor  IN  A   #{apache2}"
	action :create
end 

file '/etc/bind/zones/google.com.zone' do
	content "$TTL 604800 \n
	@   IN  SOA #{hostname}.google.com. admin.google.com. (\n
								  2         ; Serial\n
							 604800         ; Refresh\n
							  86400         ; Retry\n
							2419200         ; Expire\n
							 604800 )       ; Negative Cache TTL\n
	@   IN  NS  #{hostname}.google.com.\n
	*   IN  A   8.8.8.8\n
	www  IN  A   #{apache1}\n
	www  IN  A   #{apache2}"
	action :create
end 

remote_file '/etc/bind/named.conf.options' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/named.conf.options'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
end

ip_address = node['attr']['ipaddress'] || '0.0.0.0'
file '/etc/resolv.conf' do
	content "\nnameserver #{ip_address}\n
	search asimov.io\n
	search dostoievski.io\n
	search google.com"
	action :append
end 

execute "edit_resolv" do
	command "echo \"\nnameserver #{ip_address}\n
	search asimov.io\n
	search dostoievski.io\n
	search google.com\" >> /etc/asterisk/asterisk.conf"
	action :run
end

execute 'restart-bind9' do
	command 'sudo systemctl restart bind9'
	action :run
end
  