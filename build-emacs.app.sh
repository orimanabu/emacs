#!/bin/sh

# Usage: 
# 1. cp build-emacs.app.sh to the top directory of emacs source tree.
# 2. run "./build-emacs.app.sh"
# 3. That's all.

export CC=/usr/bin/gcc

installprefix=`pwd`/build
app_dir=$installprefix/Emacs.app/Contents/Resources
# this may not works since emacs 24*
# version=`grep 'defconst[ ]*emacs-version' ./lisp/version.el \
#     | sed -e 's/^[^"]*"\([^"]*\)".*$/\1/'`
version=24.3
compver=x86_64-apple-darwin`uname -r`

# make an emacs bundle
find . -name *.elc | xargs rm
rm -rf $installprefix
mkdir $installprefix
set -e
./configure --with-mac --enable-mac-app=$installprefix --prefix=$installprefix
make
make install
set +e

mv $installprefix/share/emacs/$version/* $app_dir
mv $installprefix/share/info $app_dir
mv $installprefix/share/man $app_dir
rm -rf $installprefix/share
mv $installprefix/var $app_dir
mv $installprefix/bin $app_dir/../MacOS/bin
# mkdir $app_dir/../MacOS/libexec
mv $installprefix/libexec/emacs/$version/$compver $app_dir/../MacOS/libexec
rm -rf $installprefix/libexec
# Make the application binary a hard link
# no longer necessary issue#17
# rm $app_dir/../MacOS/Emacs
# ln $app_dir/../MacOS/bin/emacs $app_dir/../MacOS/Emacs

echo 'Done! Find your Emacs.app at '$installprefix'.'

