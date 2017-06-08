#!/bin/bash

prefix=$1

if [[ "$prefix" == "" ]];
    prefix=$PREFIX
fi

if [[ "$prefix" == "" ]];
    prefix=/usr/local
fi

mkdir .install.tmp
cd .install.tmp

wget https://api.github.com/repos/saksmt/local-bin/tarball
tar zxf tarball

# going into freshly unpacked tar
cd $(ls)

PREFIX=$prefix make install -e

cd ../..

rm -rf .install.tmp

