#!/bin/bash

case $(id -u) in
    0) 
         echo first: running as root
         echo doing the root tasks...
         apt-get update
         apt-get install -y build-essential git libncurses5-dev zlib1g-dev unzip libssl-dev subversion htop
         sudo -u vagrant -i $0  # script calling itself as the vagrant user
         ;;
    *) 
         echo then: running as vagrant user
         echo doing the vagrant user tasks
         git clone git://git.openwrt.org/15.05/openwrt.git
         cd openwrt
         cp /vagrant/feeds.conf.default .
	 git clone -b for-15.05 https://github.com/openwrt/packages.git /vagrant/packages
	 git clone -b for-15.05 https://github.com/openwrt-routing/packages.git /vagrant/routing
         ./scripts/feeds update && ./scripts/feeds install -a
         ;;
esac
