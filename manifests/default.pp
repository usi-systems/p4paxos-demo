
exec {"apt-get update":
  path => "/usr/bin",
}

$essentials  = [ "build-essential", "fakeroot", "debhelper", "autoconf", "automake", "libssl-dev", "graphviz", "python-all", "python-qt4", "python-twisted-conch", "libtool", "tmux", "vim", "python-pip", "python-paramiko", "python-sphinx", "python-dev" , "ssh", "emacs", "sshfs", "python-routes", "bison", "git", "xterm", "firefox" ]

$pipPackages = [ "alabaster", "greenlet", "networkx" , "decorator", "eventlet", "msgpack-python", "oslo.config", "scapy", "thrift", "netifaces" ]

package { $essentials:
  require  => Exec['apt-get update'],
}

package { $pipPackages:
  ensure => present,
  provider => pip,
  require => Package[$essentials],
}

package {"openvswitch-switch":
  ensure  => present,
  require  => Exec['apt-get update'],
}

package {"openvswitch-controller":
  ensure  => present,
  require  => Exec['apt-get update'],
}

package {"mininet":
  ensure  => present,
  require => Package["openvswitch-switch", "openvswitch-controller"],
}

