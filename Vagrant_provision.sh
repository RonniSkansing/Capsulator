#!/usr/bin/env bash

# predefine settings
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password password root'
debconf-set-selections <<< 'mysql-server-5.5 mysql-server/root_password_again password root'
# add repo
apt-get install software-properties-common
apt-key adv --recv-keys --keyserver hkp://keyserver.ubuntu.com:80 0x5a16e7281be7a449
add-apt-repository 'deb http://dl.hhvm.com/ubuntu trusty main'
# update refs
apt-get update
# install essenstials
apt-get install -y curl apache2 mysql-server-5.5 php5 php5-curl php5-mysql php5-cli php5-readline php5-xdebug php-pear vim git curl npm
# symlink nojejs to node
sudo ln -s "$(which nodejs)" /usr/bin/node
# nodejs depenedency manager
npm install bower -g

# symlink with vagrant share
mkdir -p /vagrant/share
sudo ln -s /vagrant/share /var/www/default
# default web application
cd /vagrant/share && git clone https://github.com/RonnieSkansing/flower ./  && bower install

# apache2 default web service
VHOST=$(cat <<EOF
Listen 8080
<VirtualHost 0.0.0.0>
  DocumentRoot /var/www/default/
</VirtualHost>
EOF
)
echo "${VHOST}" > /etc/apache2/sites-enabled/000-default.conf
a2dissite 000-default.conf
a2ensite 000-default.conf
# Enable mod_rewrite
a2enmod rewrite
# Restart apache
service apache2 restart
