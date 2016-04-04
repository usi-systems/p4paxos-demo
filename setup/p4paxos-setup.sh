#!/bin/sh

# install p4c-bmv2
cd ~
git clone https://github.com/p4lang/p4c-bm.git p4c-bmv2
cd p4c-bmv2
git checkout -b p4paxos b69cc315d05d1037a2524014321d4cda4d89adcf
sudo pip install -r requirements.txt
sudo python setup.py install

# install new behavioral-model
cd ~
git clone https://github.com/p4lang/behavioral-model.git bmv2
cd bmv2
git checkout -b p4paxos 8a7e567d5574db9e8fbb8b4bc7b645de31c75f76
sudo ./install_deps.sh
./autogen.sh
./configure
make