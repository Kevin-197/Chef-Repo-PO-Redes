#
# Cookbook:: apache
# Recipe:: apache-priv
#
# Copyright:: 2023, The Authors, All Rights Reserved.

package 'apache2' do
  action :install
end

service 'apache2' do
  action [:start, :enable]
end

file '/var/www/html/index.html' do
  content '<html><body><h1>Server2</html></body></h1>'
  action :create
end 

