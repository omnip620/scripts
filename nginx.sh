#!/bin/bash
# centos7 一键安装nginx 1.12
cd ~
yum update -y
yum install -y wget patch openssl make cmake gcc gcc-c++ gcc-g77 flex bison file libtool libtool-libs autoconf kernel-devel libjpeg libjpeg-devel libpng libpng-devel libpng10 libpng10-devel gd gd-devel freetype freetype-devel libxml2 libxml2-devel zlib zlib-devel glib2 glib2-devel bzip2 bzip2-devel libevent libevent-devel ncurses ncurses-devel curl curl-devel e2fsprogs e2fsprogs-devel krb5 krb5-devel libidn libidn-devel openssl openssl-devel vim-minimal nano fonts-chinese gettext gettext-devel ncurses-devel gmp-devel pspell-devel unzip libcap diffutils
wget https://ftp.pcre.org/pub/pcre/pcre-8.41.tar.gz
wget http://nginx.org/download/nginx-1.12.2.tar.gz

tar -zxvf pcre-8.41.tar.gz && cd pcre-8.41/
./configure && make && make install && cd

tar -zxvf nginx-1.12.2.tar.gz && cd nginx-1.12.2/
./configure \
  --with-http_ssl_module && make && make install
rm -f /usr/bin/nginx
ln -s /usr/local/nginx/sbin/nginx /usr/bin/nginx
nginx -v
