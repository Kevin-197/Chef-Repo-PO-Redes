#
# Cookbook:: openvpn
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

remote_file '/home/ubuntu/openvpn-install.sh' do
	source 'https://git.io/vpn'
	owner 'root'
	group 'root'
	mode 'x+'
	action :create
end

execute 'Ejecutar_Instalacion_Chef' do
	command 'bash openvpn-install.sh'
	cwd '/home/ubuntu'
	action: run
end


