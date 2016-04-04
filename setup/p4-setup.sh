#!/usr/bin/env bash

cd ~
git clone git://github.com/p4lang/p4factory.git

cd ~/p4factory/
git submodule update --init --recursive

./install_deps.sh

sudo tools/veth_setup.sh
./autogen.sh
./configure
