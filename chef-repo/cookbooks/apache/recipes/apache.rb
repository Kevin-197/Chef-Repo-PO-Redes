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

number = node['attr']['apache_number'] || '0'

file '/var/www/html/index.html' do
  content "<html><body><h1>Server #{number}</h1></body></html>"
  action :create
end

