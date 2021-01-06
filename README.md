# docker-ansible
Ansible inside

## Running

You will likely need to mount required directories into your container to make it run (or build on top of what is here).

### Simple

```bash
$~   docker run --rm -it amsystems/ansible:2.10-alpine /bin/sh
```

### Mount local directory and ssh key

```bash
$~  docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa amsystems/ansible:2.10-alpine /bin/sh
```

### Injecting commands

```bash
$~  docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa amsystems/ansible:2.10-alpine ansible-playbook playbook.yml
```

### Bash Alias

You can put these inside your dotfiles (~/.bashrc or ~/.zshrc to make handy aliases).

```bash
alias docker-ansible-cli='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible amsystems/ansible:2.10-alpine /bin/sh'
alias docker-ansible-cmd='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible amsystems/ansible:2.10-alpine '
```

use with:

```bash
$~  docker-ansible-cli ansible-playbook -u playbook.yml
```

## Mitogen
To leverage *Mitogen* to accelerate your playbook runs, add this to your ```ansible.cfg```:

Please investigate in your container the location of `ansible_mitogen` (it is different per container). You can do this via:

```bash
your_container="ansible:2.9-ubuntu"
docker run --rm -it "willhallonline/${your_container}" /bin/sh -c "find / -type d | grep "ansible_mitogen/plugins" | sort | head -n 1"
```

and then configuring your own ansible.cfg like:

```ini
[defaults]
strategy_plugins = /usr/local/lib/python3.6/site-packages/ansible_mitogen/plugins/
strategy = mitogen_linear
```

## Maintainer

* Written and maintained by [Ale Martinez](https://www.amsystems.com.ar)
