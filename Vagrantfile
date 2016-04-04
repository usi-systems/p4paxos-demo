## Vagrantfile for P4Paxos

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.vm.box = "ubuntu/trusty64"

  config.vm.provider "virtualbox" do |v|
    v.name = "p4paxos-demo"
  end

  config.vm.hostname = "p4paxos-demo"
  config.vm.network "private_network", ip: "192.168.1.10"
  #config.vm.network :forwarded_port, guest:6633, host:6635 # forwarding of port 

  ## Provisioning
  config.vm.provision :puppet
  config.vm.provision :shell, privileged: false, :path => "setup/p4paxos-setup.sh"

  ## SSH config
  config.ssh.forward_x11 = true

  ## We need at least 4GB to build P4, otherwise you run out of memory
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpuexecutioncap", "100"]
    vb.memory = 4096
    vb.cpus = 4
  end

  # Configure shared_folder
  config.vm.synced_folder "p4paxos/", "/home/vagrant/p4paxos"
end
