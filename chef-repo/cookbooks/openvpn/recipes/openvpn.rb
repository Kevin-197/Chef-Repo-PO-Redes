#
# Cookbook:: openvpn
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

execute 'Ejecutar_Instalacion_OpenVPN' do
	command 'bash openvpn-install.sh'
	cwd '/home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files'
	action: run
end

file '/home/ubuntu/Desktop.ovpn' do
	source '~/Desktop.ovpn'
	action :create
end
  