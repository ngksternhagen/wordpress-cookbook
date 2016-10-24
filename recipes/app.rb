#
# Cookbook Name:: testrail
# Recipe:: app
#
# Copyright 2009-2010, Opscode, Inc.
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

include_recipe "testrail::database"

::Chef::Recipe.send(:include, Opscode::OpenSSL::Password)
node.set_unless['testrail']['keys']['auth'] = secure_password
node.set_unless['testrail']['keys']['secure_auth'] = secure_password
node.set_unless['testrail']['keys']['logged_in'] = secure_password
node.set_unless['testrail']['keys']['nonce'] = secure_password
node.set_unless['testrail']['salt']['auth'] = secure_password
node.set_unless['testrail']['salt']['secure_auth'] = secure_password
node.set_unless['testrail']['salt']['logged_in'] = secure_password
node.set_unless['testrail']['salt']['nonce'] = secure_password
node.save unless Chef::Config[:solo]

directory node['testrail']['dir'] do
  action :create
  recursive true
  if platform_family?('windows')
    rights :read, 'Everyone'
  else
    owner node['testrail']['install']['user']
    group node['testrail']['install']['group']
    mode  '00755'
  end
end

archive = platform_family?('windows') ? 'testrail.zip' : 'testrail.tar.gz'

if platform_family?('windows')
  windows_zipfile node['testrail']['parent_dir'] do
    source node['testrail']['url']
    action :unzip
    not_if {::File.exists?("#{node['testrail']['dir']}\\index.php")}
  end
else
  tar_extract node['testrail']['url'] do
    target_dir node['testrail']['dir']
    creates File.join(node['testrail']['dir'], 'index.php')
    user node['testrail']['install']['user']
    group node['testrail']['install']['group']
    tar_flags [ '--strip-components 1' ]
    not_if { ::File.exists?("#{node['testrail']['dir']}/index.php") }
  end
end

template "#{node['testrail']['dir']}/TODO.php" do
  source 'TODO.php.erb'
  mode node['testrail']['config_perms']
  variables(
    :db_name           => node['testrail']['db']['name'],
    :db_user           => node['testrail']['db']['user'],
    :db_password       => node['testrail']['db']['pass'],
    :db_host           => node['testrail']['db']['host'],
    :db_prefix         => node['testrail']['db']['prefix'],
    :db_charset        => node['testrail']['db']['charset'],
    :db_collate        => node['testrail']['db']['collate'],
    :auth_key          => node['testrail']['keys']['auth'],
    :secure_auth_key   => node['testrail']['keys']['secure_auth'],
    :logged_in_key     => node['testrail']['keys']['logged_in'],
    :nonce_key         => node['testrail']['keys']['nonce'],
    :auth_salt         => node['testrail']['salt']['auth'],
    :secure_auth_salt  => node['testrail']['salt']['secure_auth'],
    :logged_in_salt    => node['testrail']['salt']['logged_in'],
    :nonce_salt        => node['testrail']['salt']['nonce'],
    :allow_multisite   => node['testrail']['allow_multisite'],
  )
  owner node['testrail']['install']['user']
  group node['testrail']['install']['group']
  action :create
end
