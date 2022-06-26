# configfiles

A repo containing my configuration files, ansible deploy scripts and a quick
way of testing them using vagrant.

## Vagrant setup

### Install vagrant and the following plugins
```
> vagrant plugin list
vagrant-vbguest (0.30.0, global)
vagrant-vmware-desktop (3.0.1, global)
```

### Choose one of the Vagrantfiles in this repo and place it in a folder

See the vagrant/ folder. VirtualBox seems to be a bit buggy at the moment I am
writing this so I recommend going for the VMWare machine.

### Start the machine while in that folder
```
> vagrant up
```

It will be an "empty" machine based on the box in the Vagrantfile

We will provision this machine using ansible below

### SSH to the machine (do this to get its IP, you'll need it)
```
> vagrant ssh
...
--> ip a
```

### To restart the machine (do this after it's been provisioned)
```
> vagrant reload
```

### To later stop the machine
```
> vagrant halt
```




## Ansible setup

### Install ansible
```
> sudo apt install ansible
```

### Install some custom ansible roles/collections
```
> ansible-galaxy install gantsign.oh-my-zsh
> ansible-galaxy install gantsign.keyboard
```


### Configure your hosts file (aka the list of machines you want to configure)

There are many ways to set up the key, the easiest one seems to be to just
point to the Vagrant private key generated for that vm.

Example /etc/ansible/hosts file assuming a Vagrant vm called testvm_vmware
which got assigned the IP address 192.168.0.106:

```
[servers]
testvm_vmware ansible_host=192.168.0.106 ansible_ssh_private_key_file=~/.ssh/testvm_vmware.key

[all:vars]
ansible_python_interpreter=/usr/bin/python3
```


### Make sure that the permissions are restrictive on ~/.ssh/testvm_vmware.key

Ansible will complain anyway if this isn't done

```
> chmod 600 ~/.ssh/testvm_vmware.key
```


### SSH config

Since the testvm_vmware machine only has user 'vagrant' you'll need something
like this for ansible to connect through ssh:

```
> cat ~/.ssh/config
Host 192.168.0.106
    User vagrant
```


### Finally, to provision the machine:
```
> ansible-playbook main.yml
```
