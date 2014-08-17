#!/bin/bash

if [ x"$#" != x"1" ]; then
	echo "$0 appname"
	exit 1
fi
appname=$1; shift
path=/Applications/${appname}
appbasename=${appname%.*}
installdir=./build

logprefix=log.${appbasename}
export CC=/usr/bin/gcc

echo "==> autogen.sh"
./autogen.sh

echo "==> build-emacs.app.sh"
./build-emacs.app.sh 2>&1 | tee ${logprefix}.build

mdate_string=$(date -j -f '%s' $(stat -f '%m' ${path}) '+%Y-%m-%d %H:%M:%S %Z')
echo "debug: mdate: ${mdate_string}"
mdate=$(date -j -f '%s' $(stat -f '%m' ${path}) '+%Y%m%d')
backup="${path%.app}-${mdate}.${path##*.}"
if [ -e ${path} ]; then
	echo "==> ${path} exists, creating backup as ${backup}"
	mv ${path} ${backup}
else
	echo "==> ${path} does not exist"
fi

mv ${installdir}/Emacs.app ${path}
