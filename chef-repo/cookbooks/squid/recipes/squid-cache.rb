#
# Cookbook:: apache
# Recipe:: apache-priv
#
# Copyright:: 2023, The Authors, All Rights Reserved.

package 'squid' do
  action :install
end

# Configura Squid
template '/etc/squid/squid.conf' do
  source 'squid.conf.erb' # Crea un archivo ERB para configurar Squid
  owner 'proxy'
  group 'proxy'
  mode '0644'
  notifies :restart, 'service[squid]'
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

