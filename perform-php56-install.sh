#!/bin/bash

echo "PHP 5.6-alpha Installer for Ubuntu 12+"
echo "by Rob Frawley of Scribe"
echo ""

echo -n "Beginning in 5 seconds." ; sleep 1
echo -n "." ; sleep 1
echo -n "." ; sleep 1
echo -n "." ; sleep 1
echo -n "." ; sleep 1
echo    "." ; sleep 1


if [ -d "./php-build" ]; then
  echo "Removing previous install..."
  sudo rm -fr ./php-build
fi

echo "Creating installer root path..."
mkdir php-build ; cd php-build

echo "Updating Ubuntu system..."
sudo apt-get update >> ./build.log2>&1

echo "Removing previous PHP packages..."
sudo apt-get remove -y php5* >> ./build.log2>&1

echo "Getting build dependencies per Ubuntu with PHP..."
sudo apt-get build-dep -y php5 >> ./build.log2>&1

echo "Installing build tools and development dependencies for PHP compile"
sudo apt-get install -y \
	build-essential \
	checkinstall \
	autoconf \
	libtool \
	libxml2 \
	libxml2-dev \
	openssl \
	libcurl4-openssl-dev \
	libbz2-1.0 \
	libbz2-dev \
	libjpeg-dev \
	libpng12-dev \
	libfreetype6 \
	libfreetype6-dev \
 	libldap-2.4-2 \
	libldap2-dev \
	libmcrypt4 \
 	libmcrypt-dev \
	libmysqlclient-dev \
    libxslt1.1 \
	libxslt1-dev \
	libxt-dev \
	libxml2-dev \
	libssl-dev \
	libbz2-dev \
	libcurl3-dev \
	libdb5.1-dev \
	libjpeg-dev \
	libpng-dev \
	libXpm-dev \
	libfreetype6-dev \
	libt1-dev \
	libgmp3-dev \
	libc-client-dev \
	libldap2-dev \
	libmcrypt-dev \
	libmhash-dev \
	freetds-dev \
	libz-dev \
	libmysqlclient15-dev \
	ncurses-dev \
	libpcre3-dev \
	unixODBC-dev \
	libsqlite-dev \
	libaspell-dev \
	libreadline6-dev \
	librecode-dev \
	libsnmp-dev \
	libtidy-dev \
	libxslt-dev \
	libt1-dev \
	libldap2-dev >> ./build.log2>&1

echo "Downloading..."
wget http://downloads.php.net/tyrael/php-5.6.0alpha1.tar.bz2
echo "d1ac1df6ff701546a005e2d9799d2002 php-5.6.0alpha1.tar.bz2" > checklist.chk
md5sum -c checklist.chk

if [[ "$?" != "0" ]]; then
  echo "Could not verify download...try again"
  exit
else
  echo "Download verfified..."
fi

echo "Extracting download..."
tar xjf php-5.6.0alpha1.tar.bz2
cd php-5.6.0alpha1

echo "Configuring..."
./configure --with-config-file-path=/etc/php5/v6/ --with-pear=/usr/share/php --with-config-file-scan-dir=/etc/php5/v6/ --enable-zip --with-zlib --enable-bcmath --with-bz2 --with-curl --enable-exif --enable-intl --enable-mbstring --with-readline --with-bz2 --with-curl --with-gd --enable-calendar --with-iconv --with-pdo-mysql --with-mysql=mysqlnd --with-mysqli=mysqlnd --enable-mbstring --enable-bcmath --enable-sockets --enable-sysvsem --enable-sysvshm --with-libxml-dir=/usr --with-mysqli --with-openssl --with-regex=php --with-zlib --enable-fpm --with-mcrypt

echo "Making..."
make clean
make

echo "Installing..."
sudo checkinstall --pkgname="php5" --maintainer="systems@scribenet.com" --pkgrelease="1" --provides="php,php5,php5-fpm,php5-cli" -D -y

echo "Post-Install steps..."
sudo mkdir -p /etc/php5/v6/

echo "Complete."