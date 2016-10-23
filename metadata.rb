name             "testrail"
maintainer       "Brint O'Hearn"
maintainer_email "cookbooks@opscode.com"
license          "Apache 2.0"
description      "Installs/Configures Testrail"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "3.0.0"

recipe "Testrail", "Installs and configures Testrail LAMP stack on a single system"

%w{ php openssl }.each do |cb|
  depends cb
end

depends "apache2", ">= 2.0.0"
depends "database", ">= 1.6.0"
depends "mysql", ">= 6.0"
depends "mysql2_chef_gem", "~> 1.0.1"
depends "build-essential"
depends "iis", ">= 1.6.2"
depends "tar", ">= 0.3.1"
depends "nginx", "~> 2.7.4"
depends "php-fpm", "~> 0.6.10"
depends 'selinux', '~> 0.7'

%w{ debian ubuntu windows centos redhat scientific oracle }.each do |os|
  supports os
end

attribute "Testrail/version",
  :display_name => "Testrail download version",
  :description => "Version of Testrail to download from the Testrail site or 'latest' for the current release.",
  :default => "latest"

attribute "Testrail/checksum",
  :display_name => "Testrail tarball checksum",
  :description => "Checksum of the tarball for the version specified.",
  :default => ""

attribute "Testrail/dir",
  :display_name => "Testrail installation directory",
  :description => "Location to place Testrail files.",
  :default => "/var/www/testrail"

attribute "Testrail/db/database",
  :display_name => "Testrail MySQL database",
  :description => "Testrail will use this MySQL database to store its data.",
  :default => "testraildb"

attribute "Testrail/db/user",
  :display_name => "Testrail MySQL user",
  :description => "Testrail will connect to MySQL using this user.",
  :default => "testrailuser"

attribute "Testrail/db/password",
  :display_name => "Testrail MySQL password",
  :description => "Password for the Testrail MySQL user.",
  :default => "randomly generated"

attribute "Testrail/keys/auth",
  :display_name => "Testrail auth key",
  :description => "Testrail auth key.",
  :default => "randomly generated"

attribute "Testrail/keys/secure_auth",
  :display_name => "Testrail secure auth key",
  :description => "Testrail secure auth key.",
  :default => "randomly generated"

attribute "Testrail/keys/logged_in",
  :display_name => "Testrail logged-in key",
  :description => "Testrail logged-in key.",
  :default => "randomly generated"

attribute "Testrail/keys/nonce",
  :display_name => "Testrail nonce key",
  :description => "Testrail nonce key.",
  :default => "randomly generated"

attribute "Testrail/server_aliases",
  :display_name => "Testrail Server Aliases",
  :description => "Testrail Server Aliases",
  :default => "FQDN"

attribute "Testrail/languages/lang",
  :display_name => "Testrail WPLANG configulation value",
  :description => "Testrail WPLANG configulation value",
  :default => ""

attribute "Testrail/languages/version",
  :display_name => "Version of Testrail translation file",
  :description => "Version of Testrail translation file",
  :default => ""

attribute "Testrail/languages/projects",
  :display_name => "Testrail translation projects",
  :description => "Testrail translation projects",
  :type => "array",
  :default => ["main", "admin", "admin/network", "cc"]
