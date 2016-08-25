#
## Cookbook Name:: redis
## Recipe:: default
##
## Copyright 2016, YOUR_COMPANY_NAME
##
## All rights reserved - Do Not Redistribute
directory '/data/redis' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

#package 'redis-2.4.10-1.el6.x86_64.rpm' do
#        source 'ftp://192.168.56.103/pub'
#        action :install
#	not_if 'rpm -qa | grep -i  "^redis"'
#end

remote_file '/data/redis/redis-2.4.10-1.el6.x86_64.rpm' do
        source 'ftp://192.168.56.103/pub/redis-2.4.10-1.el6.x86_64.rpm'
	action :create
end

execute 'install_redis' do
	command 'yum install redis-2.4.10-1.el6.x86_64.rpm -y'
	cwd '/data/redis'
	not_if 'rpm -qa | grep -i  "^redis"'
end

template '/etc/redis.conf' do
	mode '0755'
	source 'redis.erb'
end

service 'redis' do
	provider Chef::Provider::Service::Init::Redhat
#	path '/etc/init.d/'
	supports :status => true, :restart => true
	action [:enable, :start]
	subscribes :restart, 'template[/etc/redis.conf]', :immediately
end
