#
# Cookbook:: openvpn
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

execute 'Ejecutar_Instalacion_OpenVPN' do
	command 'bash openvpn-install.sh'
	cwd '/home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/'
	action :run
	notifies :run, 'remote_file[Copiar_Archivo_Configuracion_Cliente]', :immediately
end

execute 'Copiar archivo desde /root' do
	command 'sudo cp /root/Desktop.ovpn /home/ubuntu/'
	action :run
	not_if { ::File.exist?('/home/ubuntu/Desktop.ovpn') }
  end

