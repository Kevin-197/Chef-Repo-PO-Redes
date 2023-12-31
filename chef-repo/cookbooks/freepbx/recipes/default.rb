#
# Cookbook:: freepbx
# Recipe:: default
#

###ASTERISK INSTALLATION

#update
execute "update" do
	command "sudo apt-get update -y && sudo apt-get upgrade -y"
	action :run
end

#install freepbx dependencies
execute "freepbx_Dependencies" do
	command "sudo apt-get install unzip git gnupg2 curl libnewt-dev libssl-dev libncurses5-dev subversion libsqlite3-dev build-essential libjansson-dev libxml2-dev uuid-dev subversion -y"
	action :run
end

#download asterisk file
remote_file "/home/ubuntu/asterisk-18-current.tar.gz" do
	source "http://downloads.asterisk.org/pub/telephony/asterisk/asterisk-18-current.tar.gz"
	action :create
end

execute "extract_asterisk" do
	command "tar -xvzf asterisk-18-current.tar.gz"
	cwd '/home/ubuntu'
	action :run
end

execute "change_directory_asterisk" do
	command "cd /home/ubuntu/asterisk-18.* && contrib/scripts/get_mp3_source.sh && DEBIAN_FRONTEND=noninteractive contrib/scripts/install_prereq install"
	cwd '/home/ubuntu'
	action :run
end


execute "configure" do
	command "cd /home/ubuntu/asterisk-18.* && ./configure"
	cwd '/home/ubuntu'
	action :run
end

remote_file '/home/ubuntu/asterisk-18.19.0/menuselect.makedeps' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/menuselect.makedeps'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
  end

  remote_file '/home/ubuntu/asterisk-18.19.0/menuselect.makedeps' do
	source 'file:///home/ubuntu/Chef-Repo-PO-Redes/chef-repo/Configuration%20Files/menuselect.makeopts'
	owner 'root'
	group 'root'
	mode '0755'
	action :create
  end

execute "build_asterisk" do
	command "make -j6"
	cwd "/home/ubuntu/asterisk-18.19.0"
	action :run
end

execute "make_install" do
	command "sudo make install"
	cwd "/home/ubuntu/asterisk-18.19.0"
	action :run
end

execute "samples_config" do
	command "sudo make samples && sudo make config && sudo ldconfig"
	cwd "/home/ubuntu/asterisk-18.19.0"
	action :run
end

###ASTERISK SERVER CONFIG

execute "group_asterisk" do
	command "sudo groupadd asterisk && sudo useradd -r -d /var/lib/asterisk -g asterisk asterisk"
	action :run
end

execute "addaudio_asterisk" do
	command "usermod -aG audio,dialout asterisk"
	action :run
end

execute "asterisk_ownership" do
	command "sudo chown -R asterisk.asterisk /etc/asterisk && sudo chown -R asterisk.asterisk /var/lib/asterisk && sudo chown -R asterisk.asterisk /var/log/asterisk && sudo chown -R asterisk.asterisk /var/spool/asterisk && sudo chown -R asterisk.asterisk /usr/lib/asterisk"
	action :run
end

execute "asterisk_configfile1" do
	command "echo \"AST_USER=\"\"asterisk\"\"\nAST_GROUP=\"\"asterisk\"\"\n\nCOLOR=yes\" > /etc/default/asterisk"
	action :run
end

execute "asterisk_configfile2" do
	command "echo \"\nrunuser = asterisk              ; The user to run as.\nrungroup = asterisk             ; The group to run as.\" >> /etc/asterisk/asterisk.conf"
	action :run
end

execute "restart_Asterisk" do
	command "sudo systemctl restart asterisk"
	action :run
end

execute "fix_asterisk_server_error" do
	command "sudo sed -i 's\";\\[radius\\]\"\\[radius\\]\"g' /etc/asterisk/cdr.conf && sudo sed -i 's\";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf\"radiuscfg => /etc/radcli/radiusclient.conf\"g' /etc/asterisk/cdr.conf && sudo sed -i 's\";radiuscfg => /usr/local/etc/radiusclient-ng/radiusclient.conf\"radiuscfg => /etc/radcli/radiusclient.conf\"g' /etc/asterisk/cel.conf"
	action :run
end

execute "restart_Asterisk2" do
	command "sudo systemctl restart asterisk"
	action :run
end

### INSTALLING FREEPBX
	
execute "dependencies" do
	command "sudo apt-get install software-properties-common -y"
	action :run
end

execute "add_php_repo" do
	command "sudo add-apt-repository ppa:ondrej/php -y"
	action :run
end
	
execute "install_apache_mariadb_php" do
	command "sudo apt-get install apache2 mariadb-server libapache2-mod-php7.2 php7.2 php-pear php7.2-cgi php7.2-common php7.2-curl php7.2-mbstring php7.2-gd php7.2-mysql php7.2-bcmath php7.2-zip php7.2-xml php7.2-imap php7.2-json php7.2-snmp -y"
	action :run
end	
	
remote_file "/home/ubuntu/asterisk-18.19.0/freepbx-15.0-latest.tgz" do
	source "http://mirror.freepbx.org/modules/packages/freepbx/freepbx-15.0-latest.tgz"
	action :create
end
	
execute "extract_freepbx" do
	command "tar -xvzf freepbx-15.0-latest.tgz"
	cwd "/home/ubuntu/asterisk-18.19.0"
	action :run
end
	
execute "install_nodejs" do
	command "cd /home/ubuntu/asterisk-18.19.0/freepbx && sudo apt-get install nodejs npm -y"
	action :run
end	
	
execute "set_permissions" do
	command "sudo ./install -n"
	cwd "/home/ubuntu/asterisk-18.19.0/freepbx"
	action :run
end		
	
execute "install_pm2_module" do
	command "sudo fwconsole ma install pm2"
	cwd "/home/ubuntu/asterisk-18.19.0/freepbx"
	action :run
end	 	
	
execute "apache_configuration_user" do
	command "sudo sed -i 's/^\\(User\\|Group\\).*/\\1 asterisk/' /etc/apache2/apache2.conf && sudo sed -i 's/AllowOverride None/AllowOverride All/' /etc/apache2/apache2.conf"
	cwd "/home/ubuntu/asterisk-18.19.0/freepbx"
	action :run
end	

execute "increase_upload_max_filesize" do
	command "sudo sed -i 's/\\(^upload_max_filesize = \\).*/\\120M/' /etc/php/7.2/apache2/php.ini && sudo sed -i 's/\\(^upload_max_filesize = \\).*/\\120M/' /etc/php/7.2/cli/php.ini"
	cwd "/home/ubuntu/asterisk-18.19.0/freepbx"
	action :run
end	
	
execute "rewrite_apache_restart" do
	command "sudo a2enmod rewrite && sudo systemctl restart apache2"
	cwd "/home/ubuntu/asterisk-18.19.0/freepbx"
	action :run
end

# Copyright:: 2023, The Authors, All Rights Reserved.
