[![Build Status - Master](https://travis-ci.org/juju4/ansible-harden-apache.svg?branch=master)](https://travis-ci.org/juju4/ansible-harden-apache)
[![Build Status - Devel](https://travis-ci.org/juju4/ansible-harden-apache.svg?branch=devel)](https://travis-ci.org/juju4/ansible-harden-apache/branches)
# Apache webserver hardening ansible role

Ansible role to harden Apache2 webserver.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.1
 * 2.2 (required for letsencrypt module)
If want to use role with pre-2.2 ansible, comment letsencrypt tasks include in tasks/apache-ssl.yml.

### Operating systems

Ubuntu 14.04 (Apache 2.4.7), 16.04(2.4.18) and Centos7(2.4.6)

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.harden-apache
```

## Variables

Nothing specific for now.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.harden-apache
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ cd /path/to/roles/juju4.harden-apache/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues


## License

BSD 2-clause

