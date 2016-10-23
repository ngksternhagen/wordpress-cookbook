#
# Author:: Barry Steinglass (<barry@opscode.com>)
# Author:: Koseki Kengo (<koseki@gmail.com>)
# Author:: Lucas Hansen (<lucash@opscode.com>)
# Author:: Julian C. Dunn (<jdunn@getchef.com>)
#
# Cookbook Name:: testrail
# Attributes:: testrail
#
# Copyright 2009-2013, Chef Software, Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# General settings
default['testrail']['version'] = 'latest'

default['testrail']['db']['root_password'] = 'my_root_password'
default['testrail']['db']['instance_name'] = 'default'
default['testrail']['db']['name'] = "testraildb"
default['testrail']['db']['user'] = "testrailuser"
default['testrail']['db']['pass'] = nil
# default['testrail']['db']['prefix'] = 'wp_'
default['testrail']['db']['host'] = 'localhost'
default['testrail']['db']['port'] = '3306'  # Must be a string
default['testrail']['db']['charset'] = 'utf8'
default['testrail']['db']['collate'] = ''
case node['platform']
when 'ubuntu'
  case node['platform_version']
  when '10.04'
    default['testrail']['db']['mysql_version'] = '5.1'
  else
    default['testrail']['db']['mysql_version'] = '5.5'
  end
when 'centos', 'redhat', 'amazon', 'scientific'
  if node['platform_version'].to_i < 6
    default['testrail']['db']['mysql_version'] = '5.0'
  elsif node['platform_version'].to_i < 7
    default['testrail']['db']['mysql_version'] = '5.1'
  else
    default['testrail']['db']['mysql_version'] = '5.5'
  end
else
  default['testrail']['db']['mysql_version'] = '5.5'
end

default['testrail']['allow_multisite'] = false

default['testrail']['config_perms'] = 0644
default['testrail']['server_aliases'] = [node['fqdn']]
default['testrail']['server_port'] = '80'

default['testrail']['install']['user'] = node['apache']['user']
default['testrail']['install']['group'] = node['apache']['group']

if node['platform'] == 'windows'
  default['testrail']['parent_dir'] = "#{ENV['SystemDrive']}\\inetpub"
  default['testrail']['dir'] = "#{node['testrail']['parent_dir']}\\testrail"
  default['testrail']['url'] = "https://testrail.org/testrail-#{node['testrail']['version']}.zip"
else
  default['testrail']['server_name'] = node['fqdn']
  default['testrail']['parent_dir'] = '/var/www'
  default['testrail']['dir'] = "#{node['testrail']['parent_dir']}/testrail"
  default['testrail']['url'] = "https://testrail.org/testrail-#{node['testrail']['version']}.tar.gz"
end

default['testrail']['php_options'] = { 'php_admin_value[upload_max_filesize]' => '50M', 'php_admin_value[post_max_size]' => '55M' }
