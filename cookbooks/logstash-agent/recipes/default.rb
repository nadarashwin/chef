#
# Cookbook Name:: logstash-agent
# Recipe:: default
#
# Copyright 2016, crazy_ones
#
# All rights reserved - Do Not Redistribute
#


directory '/data/logstash' do
  owner 'root'
  group 'root'
  mode '0755'
  action :create
end

remote_file '/data/logstash/logstash-2.3.4.zip' do
        source 'ftp://192.168.56.103/pub/logstash-2.3.4.zip'
        owner 'root'
        group 'root'
        mode '0644'
        action :create
end

#remote_file '/data/logstash/agent.conf' do
#        source 'ftp://192.168.56.103/pub/agent.conf'
#        owner 'root'
#        group 'root'
#        mode '0644'
#        action :create
#end


template '/data/logstash/agent.conf' do
	mode '0755'
	source 'agent.erb'
	notifies :run, 'execute[starting_logstash]', :immediately
end

execute 'extracting_logstash_zip' do
        command 'unzip logstash-2.3.4.zip && rm -vf logstash-2.3.4.zip'
        cwd '/data/logstash'
        not_if { File.exist?('/data/logstash/logstash-2.3.4.zip') }
end

execute 'starting_logstash' do
	command './logstash -f /data/logstash/agent.conf &'
	cwd '/data/logstash/logstash-2.3.4/bin'
	not_if  'ps -ef | grep "[a]gent.conf"', :user => 'root' 
end

