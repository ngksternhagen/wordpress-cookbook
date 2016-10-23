[![Build Status](https://travis-ci.org/brint/testrail-cookbook.svg?branch=master)](https://travis-ci.org/brint/testrail-cookbook)
[![Dependency Status](https://gemnasium.com/brint/testrail-cookbook.svg)](https://gemnasium.com/brint/testrail-cookbook)

Description
===========

The Chef Testrail cookbook installs and configures Testrail according to the instructions at TODO

Description
===========

TODO

Requirements
============

Platform
--------

* RHEL/CentOS 6
* others in development

Cookbooks
---------

* mysql
* mysql_chef_gem
* php
* apache2
* openssl (uses library to generate secure passwords)
* selinux (used to disable selinux for MySQL on RHEL-based systems)

Attributes
==========

### Testrail

* `node['testrail']['version']` - Version of Testrail to download. Use 'latest' to download most recent version.
* `node['testrail']['parent_dir']` - Parent directory to where Testrail will be extracted. (Windows Only)
* `node['testrail']['dir']` - Location to place Testrail files.
* `node['testrail']['db']['root_password']` - Root password for MySQL (added for support with community cookbook version 6+)
* `node['testrail']['db']['instance_name']` - Name of the MySQL instance to use with MySQL (community cookbook version 6+)
* `node['testrail']['db']['name']` - Name of the Testrail MySQL database.
* `node['testrail']['db']['user']` - Name of the Testrail MySQL user.
* `node['testrail']['db']['pass']` - Password of the Testrail MySQL user. By default, generated using openssl cookbook.
* `node['testrail']['db']['prefix']` - Prefix of all MySQL tables created by Testrail.
* `node['testrail']['db']['host']` - Host of the Testrail MySQL database.
* `node['testrail']['db']['port']` - Port of the Testrail MySQL database.
* `node['testrail']['db']['charset']` - [Character set](http://dev.mysql.com/doc/refman/5.7/en/charset-charsets.html) of the Testrail MySQL database tables. Defaults to 'utf8'.
* `node['testrail']['db']['collate']` - [Collation](http://dev.mysql.com/doc/refman/5.7/en/charset-collation-effect.html) of the Testrail MySQL database tables.
* `node['testrail']['db']['mysql_version']` - Version of MySQL to install (for supporting community cookbook version 6+)

* TODO others from testrail documentation
* `node['testrail']['server_aliases']` - Aliases to use when setting up Virtual Host with Nginx or Apache
* `node['testrail']['server_port']` - Port to use when setting up the Virtual Host with Nginx or Apache

* `node['testrail']['install']['user']` - Install user used for Testrail file permissions and the PHP-FPM user (if applicable)
* `node['testrail']['install']['group']` - Install group used for Testrail file permissions and the PHP-FPM group (if necessary)

* `node['testrail']['parent_dir']` - Parent directory of where Testrail will be installed. This will be used by Windows.
* `node['testrail']['dir']` - Path where Testrail should be installed
* `node['testrail']['url']` - URL to the zip or tarball installer of Testrail
* `node['testrail']['server_name']` - Hostname used for setting up the Virtual Host configuration for your Testrail site

* `node['testrail']['php_options']` - Additional PHP settings for the installation.

Usage
=====

Add the "testrail" recipe to your node's run list or role, or include the recipe in another cookbook.

License and Author
==================

* Author:: Barry Steinglass (barry@opscode.com)
* Author:: Joshua Timberman (joshua@opscode.com)
* Author:: Seth Chisamore (schisamo@opscode.com)
* Author:: Lucas Hansen (lucash@opscode.com)
* Author:: Julian C. Dunn (jdunn@getchef.com)
* Author:: NGK Sternhagen (sternhagen@protonmail.ch)

Copyright:: 2010-2013, Chef Software, Inc.
Copyright:: 2016, NGK Sternhagen

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
