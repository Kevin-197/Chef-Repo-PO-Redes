#
# Cookbook:: openvpn
# Recipe:: default
#
# Copyright:: 2023, The Authors, All Rights Reserved.

execute 'Obtener_Desktop.ovpn' do	
    command 'bash /home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration\ Files/GetClientConfOpenVPN.sh'
    action :run
end

package 'network-manager-openvpn' do
    action :install
  end
  