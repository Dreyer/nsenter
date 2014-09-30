# VAGRANT-VERSION 1.6.3

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
    config.vm.box = "ubuntu/trusty64"
    config.vm.hostname = "utillinux"
    
    config.vm.synced_folder ".", "/vagrant"

    config.vm.provider "virtualbox" do |vb|
        vb.gui = false
        vb.memory = 2048
        vb.cpus = 2 
    end

    config.vm.provision "docker" do |d|
        d.build_image "/vagrant", args: "-t utillinux/nsenter"
        d.run "nsenter", image: "utillinux/nsenter"
    end

    config.vm.provision "shell", path: "./setup.sh"
end