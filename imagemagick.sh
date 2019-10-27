#!/bin/bash

# Requirements: 
#       ROOT access to the server.
#
# How to use the script:
#       Download the script as ROOT user, chmod it to 755 and then execute it. Wait for magic to happen :)
#
#       The 'wget' way to do this is:
#       wget https://www.zhaklilo.info/scripts/imagemagick.sh && chmod 755 imagemagick.sh && ./imagemagick.sh
#       And again wait for magic to happen :)
#
##############################
# * Created by ZhL - Zhak Lilo
# * Date: 12/02/2019
# * Last update: 27/10/2019
# * Version: 1.0 - Initial release
# * Version: 1.3 - Added CentOS 7.x support, fixed the "module 'imagick' already loaded in unknown on line 0"
# * Purpose: This script is created to ease and automate the installation of ImageMagick on CentOS 6.x and CentOS 7.x
##############################
#
echo 'Checking your OS version ...';

version=$(rpm -E %{rhel})

case $version in

    '6')
        echo 'Your CentOS version is 6.x';
        echo 'Starting the installation of ImageMagick service + the PHP extension:';

        #First we will install the ImageMagick service
        yum -y install ImageMagick-devel ImageMagick-c++-devel ImageMagick-perl

        #Then we will install the imagick PHP extension in loop for all of the PHP versions
        for phpver in 54 55 56 70 71 72 73; do
        printf "\autodetect" | /opt/cpanel/ea-php$phpver/root/usr/bin/pecl install imagick

        #In the latest cPanel versions adding the below extension is no more required
        #echo 'extension=imagick.so' >> /opt/cpanel/ea-php$phpver/root/etc/php.d/imagick.ini

        done;

        #Once all of the installations are done let's restart the Apache and PHP-FPM services
        /scripts/restartsrv_httpd
        /scripts/restartsrv_apache_php_fpm

        #Lastly we will print the ImageMagick service version and verify the imagick PHP extension for all of the PHP versions
        echo -e 'Verifying the ImageMagick service installation:\n';
        /usr/bin/convert --version

        echo -e 'Verifying the imagick PHP extension installation:\n';
        for phpver in 54 55 56 70 71 72 73; do
        echo -n "PHP $phpver: " ; /opt/cpanel/ea-php$phpver/root/usr/bin/php -m | grep imagick
        done;
    ;;
   '7')
        echo 'Your CentOS version is 7.x';
        echo 'Starting the installation of ImageMagick service + the PHP extension:';

        #First we will install the ImageMagick service
        yum -y install ImageMagick-devel ImageMagick-c++-devel ImageMagick-perl

        #Then we will install the imagick PHP extension in loop for all of the PHP versions
        for phpver in 54 55 56 70 71 72 73; do
        printf "\autodetect" | /opt/cpanel/ea-php$phpver/root/usr/bin/pecl install imagick
        done;

        #Adding imagick extensions for PHP 5.6 as it is not manually added
        echo 'extension=imagick.so' >> /opt/cpanel/ea-php56/root/etc/php.d/imagick.ini

        #Once all of the installations are done let's restart the Apache and PHP-FPM services
        /scripts/restartsrv_httpd
        /scripts/restartsrv_apache_php_fpm

        #Lastly we will print the ImageMagick service version and verify the imagick PHP extension for all of the PHP versions
        echo -e 'Verifying the ImageMagick service installation:\n';
        /usr/bin/convert --version

        echo -e 'Verifying the imagick PHP extension installation:\n';
        for phpver in 54 55 56 70 71 72 73; do
        echo -n "PHP $phpver: " ; /opt/cpanel/ea-php$phpver/root/usr/bin/php -m | grep imagick
        done;
    ;;
    *)
        echo 'This is not CentOS and I am created only for CentOS 6.x and 7.x. Please execute me on server with such OS.';
    ;;
esac
