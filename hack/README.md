Hack - Local Development and Deployment Tooling
===============================================

This directory contains scripts and configuration files used for provisioning
local testing environments and remote, immutable infrastructure.

## Structure

To keep things organized, application configuration files are kept in the `files`
directory while scripts used to install them are kept in the `scripts` directory.

### First Time Setup

The Vagrantfile controls how to provision a local VM for testing. This requires
the Vagrant tool from Hashicorp. How it's installed depends on your platform, but
there's two basic requirements:

1. *Hypervisor:* The VM needs to run in a hypervisor. This is the program that's
   responsible for managing the virtual hardware and networking needed to provide
   the virtual machine with the illusion that it's on dedicated hardware.
2. *Vagrant:* The hypervisor needs to be instructed to provision a virtual machine
   and provide various creature comforts to us mortals. Vagrant accomplishes this
   in a way that's reproducible across different host machines, like your laptop.

*MacOS*

To install Vagrant on MacOS with homebrew, run the following:

```
    # install the de-facto standard hypervisor, virtualbox
    brew cask install virtualbox
    # install vagrant
    brew cask install vagrant
```

*Ubuntu*

```
    # install virtualbox
    sudo apt install virtualbox
    # install vagrant
    VAGRANT_VERSION=2.0.2
    TEMP=$(mktemp -d)
    wget -O $TEMP/vagrant_${VAGRANT_VERSION}_x86_64.deb https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_x86_64.deb
    wget -O $TEMP/vagrant_${VAGRANT_VERSION}_SHA256SUMS https://releases.hashicorp.com/vagrant/${VAGRANT_VERSION}/vagrant_${VAGRANT_VERSION}_SHA256SUMS
    sha256sum -c --ignore-missing $TEMP/vagrant_${VAGRANT_VERSION}_SHA256SUMS || { echo "Vagrant deb didn't match checksum." ; exit 1 ; }
    mv $TEMP/vagrant_${VAGRANT_VERSION}_x86_64.deb $HOME
    sudo apt install $HOME/vagrant_${VAGRANT_VERSION}_x86_64.deb
    # hit yes to these prompts if they're sane
    rm -r $TEMP
    rm $HOME/vagrant_${VAGRANT_VERSION}_x86_64.deb
```

*Other*

If you don't believe in package managers or don't use a host operating system listed
here, you'll probably want to visit the Vagrant [downloads page](https://www.vagrantup.com/downloads.html)
and consult their [installation documentation](https://www.vagrantup.com/docs/installation/).

### Provisioning a Local VM

To setup a local testing environment, run the following:

```
    cd hack && vagrant up
```

To connect to the VM over SSH once it's been provisioned, run the following:

```
    vagrant ssh
```

If you want to reprovision the VM with its initial installation scripts, run the following:

```
    vagrant provision
```

If you want to destroy the VM and reprovision it to start from scratch, run the following:

```
    vagrant destroy -f && vagrant up
```

