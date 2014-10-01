# nsenter for docker

There is an open [bug](https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1012081) for Debian/Ubuntu from Ubuntu 12.10 (Quantal Quetzal) to Ubuntu 14.04 (Trusty Tahr) relating to an old version of [util-linux](https://www.kernel.org/pub/linux/utils/util-linux/) which doesn't include nsenter.

The latest compiled version is nsenter from util-linux 2.25.226-42f0. [Download](https://github.com/Dreyer/nsenter/releases/latest).

## requirements

I've got this working well on my current setup which is below (YMMV):

- Mac OS X 10.9.5
- [Vagrant](http://www.vagrantup.com/) 1.6.5
- [Docker](https://docker.com/) 1.2.0
- [VirtualBox](https://www.virtualbox.org/) 4.3.16

## compile

Setup Vagrant on the host machine.

    me@host:~$ vagrant up

Once the Vagrant box is up, login to the guest VM with ssh.

    me@host:~$ vagrant ssh

Inside the guest VM, run the package script to generate a neat tarball.

    vagrant@guest:~$ /vagrant/package.sh

After running the above commands, you should have a packaged tarball in your `releases` folder on your host machine or at `/vagrant/releases` if your still in the guest VM.

## download

If you don't want to compile your own, you can download the latest binary which is compiled as above on Ubuntu 14.04 (64-bit) in a tarball.

This is handy if you just need `nsenter` for entering a Docker container in a Vagrant/VirtualBox guest running on a Mac OS X host.

Incorporate the `download.sh` script in your `Vagrantfile`. It may need tweaking to get it to work with your particular setup.

    config.vm.provision "shell", path: "./download.sh"

## bonus

If you want a shortcut to enter Docker containers using `nsenter`, add the following to your `/home/vagrant/.bashrc` in your guest VM:

    dockerenterfunc() {
        PID=$(docker inspect --format '{{ .State.Pid }}' $1)
        sudo nsenter --target $PID --mount --uts --ipc --net --pid
    }
    alias dockerenter=dockerenterfunc
    
Make sure you update your `~/.bashrc` in the guest VM before using the shortcut.

    vagrant@guest:~$ source ~/.bashrc

Then pass the name of your container to the shortcut. For example, assuming you have a Docker container called `redis` which is already running:

    vagrant@guest:~$ dockerenter redis

