# docker-ansible
Ansible inside

Running
You will likely need to mount required directories into your container to make it run (or build on top of what is here).

Simple
$~   docker run --rm -it willhallonline/ansible:2.9-alpine /bin/sh
Mount local directory and ssh key
$~  docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa willhallonline/ansible:2.9-alpine /bin/sh
Injecting commands
$~  docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/id_rsa willhallonline/ansible:2.9-alpine ansible-playbook playbook.yml
Bash Alias
You can put these inside your dotfiles (~/.bashrc or ~/.zshrc to make handy aliases).

alias docker-ansible-cli='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible willhallonline/ansible:2.9-alpine /bin/sh'
alias docker-ansible-cmd='docker run --rm -it -v $(pwd):/ansible -v ~/.ssh/id_rsa:/root/.ssh/id_rsa --workdir=/ansible willhallonline/ansible:2.9-alpine '
use with:

$~  docker-ansible-cli ansible-playbook -u playbook.yml
Maintainer
Written and maintained by Ale Martinez
