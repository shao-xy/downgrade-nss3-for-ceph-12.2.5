#!/bin/bash

cwd=$(pwd)
wd=$(mktemp -d /tmp/downgrade-lib.XXXX)
cd $wd

PKGS=(
	nss-3.53.1-7.el7_9.x86_64.rpm
	nss-devel-3.53.1-3.el7_9.i686.rpm
	nss-tools-3.53.1-3.el7_9.x86_64.rpm
	nss-sysinit-3.53.1-3.el7_9.x86_64.rpm
)

test -d packages || mkdir packages
for pkg in ${PKGS[@]}; do
	echo "Downloading $pkg"
	wget http://mirror.centos.org/centos/7/updates/x86_64/Packages/$pkg -O packages/$pkg &>/dev/null
done

rm -rf etc usr
for pkg in packages/*.rpm; do
	echo "Unpacking $pkg"
	rpm2cpio $pkg | cpio -dimv &>/dev/null
done

(find etc -type f && find usr -type f) \
| while read line; do
	echo "Copying $line to /$line"
	sudo cp $line /$line
done

cd $cwd
rm -rf $wd
