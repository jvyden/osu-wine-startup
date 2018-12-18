#!/bin/sh
mkdir gnutlsfix
cd gnutlsfix
wget http://archive.ubuntu.com/ubuntu/pool/main/g/gnutls28/libgnutls30_3.5.18-1ubuntu1_amd64.deb
wget http://archive.ubuntu.com/ubuntu/pool/main/g/gnutls28/libgnutls30_3.5.18-1ubuntu1_i386.deb
dpkg -i libgnutls30_3.5.18-1ubuntu1_amd64.deb libgnutls30_3.5.18-1ubuntu1_i386.deb
apt-mark hold libgnutls30_3:i386
apt-mark hold libgnutls30_3:amd64
cd ..
rm -rf gnutlsfix
