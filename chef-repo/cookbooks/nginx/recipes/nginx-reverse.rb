#
# Cookbook:: nginx
# Recipe:: nginx-reverse
#
# Copyright:: 2023, The Authors, All Rights Reserved.

### NGINX INSTALLATION

#install
execute "install" do
	command "sudo apt install nginx -y"
	action :run
end

#start
execute "start" do
	command "sudo systemctl start nginx"
	action :run
end



# Editar /etc/nginx/sites-enabled/default
# Cambia el archivo de configuracion

# remote_file '/etc/nginx/sites-enabled/default' do
#	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/default'
#	owner 'root'
#	group 'root'
#	mode '0755'
#	action :create
# end

# Para manejo de las ip
address = node['attr']['apache2_ip'] || 'localhost'

file '/etc/nginx/sites-enabled/default' do
  content "server {
		listen 8081 default_server;
		server_name _;

		location /server1 {
			proxy_pass	http://localhost:80/index.html;
		}

		location /server2 {
			proxy_pass	http://#{address}:80/index.html;
		}
	}"
  action :create
end

# checkConf
execute "check" do
	command "sudo nginx -t"
end

#restart
execute "restart" do
	command "sudo systemctl restart nginx"
	action
end