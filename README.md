# imagemagick.sh

An automated shell script for installing ImageMagick service and the imagick PHP extension for all cPanel supported PHP versions with CentOS 6.x or CentOS 7.x.

# Script requirements: 

ROOT access to the server.

*Note that the PHP versions should be first installed via WHM Software -> EasyApache 4 and then this script executed. If you are not sure how to perform this, please check the [corresponding cPanel documentation](https://documentation.cpanel.net/display/EA4/How+to+Locate+and+Install+a+PHP+Version+or+Extension).*

# Download and execution

Choose one of these methods:

1. Direct SSH download of the script and execution (the simplest and fastest method):

<code> wget https://www.zhaklilo.info/scripts/imagemagick.sh && chmod 755 imagemagick.sh && ./imagemagick.sh </code>

2. You can download the entire repository by using <code>git clone</code> or <code>git clone --depth 1 -b master</code> followed by the cloning URL above.
