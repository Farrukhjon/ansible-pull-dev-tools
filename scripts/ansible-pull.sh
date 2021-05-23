#!/bin/bash

if ! command -v git &>/dev/null; then
  echo "git was not found, trying to install it"
  sudo dnf -y update && sudo dnf -y install git
fi

if ! command -v ansible-pull &>/dev/null; then
  echo "ansible was not found, trying to install it"
  sudo dnf install ansible
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
