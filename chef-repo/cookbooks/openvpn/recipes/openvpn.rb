#
# Cookbook:: openvpn
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

execute 'Ejecutar_Instalacion_OpenVPN' do
	command 'bash /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/openvpn-ubuntu-install.sh'
	action :run
	notifies :run , 'execute[Copiar_Archivo_Configuracion_Cliente]', :immediately
end

execute 'Copiar_Archivo_Configuracion_Cliente' do
	command 'bash /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/Desktop.sh'
	action :nothing
	not_if { ::File.exist?('/home/ubuntu/Desktop.ovpn') }
end

#execute 'Copiar_Archivo_Configuracion_Cliente' do
#	command 'bash /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/Desktop.sh'
#	action :run
#end


service 'openvpn' do
	action :restart
end
  