#!/bin/sh

CC=/usr/bin/gcc ./configure --with-mac --without-x 2>&1 | tee log.configure
#make 2>&1 | tee log.make
#make bootstrap 2>&1 | tee log.bootstrap
#make install 2>&1 | tee log.install
