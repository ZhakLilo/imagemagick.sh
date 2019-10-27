#!/bin/bash

# Requirements: 
#       ROOT access to the server.

# How to use the script:
#       Download the script as ROOT user, chmod it to 755 and then execute it. Wait for magic to happen :)
#
#       The 'wget' way to do this is:
#       wget https://www.zhaklilo.info/scripts/imagemagick.sh && chmod 755 imagemagick.sh && ./imagemagick.sh
#       And again wait for magic to happen :)

##############################
# * Created by ZhL - Zhak Lilo
# * Date: 12/02/2019
# * Version: 1.0 - initial release
# * Purpose: This script is created to ease and 
# ** automate the installation of ImageMagick
##############################

yum -y install ImageMagick-devel ImageMagick-c++-devel ImageMagick-perl
for phpver in 54 55 56 70 71 72 73; do
printf "\autodetect" | /opt/cpanel/ea-php$phpver/root/usr/bin/pecl install imagick
echo 'extension=imagick.so' >> /opt/cpanel/ea-php$phpver/root/etc/php.d/imagick.ini
done;
/scripts/restartsrv_httpd
/scripts/restartsrv_apache_php_fpm
/usr/bin/convert --version
for phpver in 54 55 56 70 71 72 73; do
echo -n "PHP $phpver" ; /opt/cpanel/ea-php$phpver/root/usr/bin/php -m |grep imagick
done;
