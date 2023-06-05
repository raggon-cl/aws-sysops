#!/bin/bash

amazon-linux-extras install epel -y
yum install httpd wget git unzip stress -y
systemctl restart httpd
curl -O https://www.tooplate.com/zip-templates/2121_wave_cafe.zip
unzip 2121_wave_cafe.zip
mv 2121_wave_cafe/* /var/www/html