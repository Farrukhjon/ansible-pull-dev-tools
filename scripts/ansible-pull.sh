#!/bin/bash

sudo dnf -y update
echo "Upgrade pip"
python -m pip install --upgrade pip
echo "Install Ansible by pip"
python -m pip install wheel ansible

if ! command -v git &>/dev/null; then
  echo "git was not found, trying to install it"
  exit
fi

if ! command -v ansible-pull &>/dev/null; then
  echo "ansible was not found, trying to install it"
  exit
fi

ansible-pull --checkout=main \
  --inventory=localhost, \
  --module-name=git \
  --url="https://github.com/Farrukhjon/ansible-pull-dev-tools.git" \
  --directory /tmp/ansible/ansible-pull \
  --user vagrant \
  --only-if-changed \
  --verbose \
  ansible/playbook.yml
