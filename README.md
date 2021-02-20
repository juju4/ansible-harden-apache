[![Actions Status - Master](https://github.com/juju4/ansible-harden-apache/workflows/AnsibleCI/badge.svg)](https://github.com/juju4/ansible-harden-apache/actions?query=branch%3Amaster)
[![Actions Status - Devel](https://github.com/juju4/ansible-harden-apache/workflows/AnsibleCI/badge.svg?branch=devel)](https://github.com/juju4/ansible-harden-apache/actions?query=branch%3Adevel)

# Apache webserver hardening ansible role

Ansible role to harden Apache2 webserver.

## Requirements & Dependencies

### Ansible
It was tested on the following versions:
 * 2.1
 * 2.2 (required for letsencrypt module)
 * 2.3
 * 2.4
If want to use role with pre-2.2 ansible, comment letsencrypt tasks include in tasks/apache-ssl.yml.

### Operating systems

Ubuntu 14.04 (Apache 2.4.7), 16.04(2.4.18) and Centos7(2.4.6)

## Example Playbook

Just include this role in your list.
For example

```
- host: all
  roles:
    - juju4.harden_apache
```

## Variables

Among the different options, you have to configure Apache Single-Sign On with ActiveDirectory through Kerberos.
Role does not include configuration on Windows side and can't be part of Continuous Testing so review carefully before using in production.

## Continuous integration

This role has a travis basic test (for github), more advanced with kitchen and also a Vagrantfile (test/vagrant).
Default kitchen config (.kitchen.yml) is lxd-based, while (.kitchen.vagrant.yml) is vagrant/virtualbox based.

Once you ensured all necessary roles are present, You can test with:
```
$ gem install kitchen-ansible kitchen-lxd_cli kitchen-sync kitchen-vagrant
$ cd /path/to/roles/juju4.harden_apache
$ kitchen verify
$ kitchen login
$ KITCHEN_YAML=".kitchen.vagrant.yml" kitchen verify
```
or
```
$ pip install molecule docker
$ molecule test
$ MOLECULE_DISTRO=ubuntu:20.04 molecule test --destroy=never
```
or
```
$ cd /path/to/roles/juju4.harden_apache/test/vagrant
$ vagrant up
$ vagrant ssh
```

## Troubleshooting & Known issues

* To validate AD SSO with Kerberos
```
$ kinit <account>@LOCAL.DOMAIN
$ klist
$ kvno HTTP/<fqdn@LOCAL.DOMAIN>
$ kinit -k -t /etc/apache2/krb5.keytab HTTP/<fqdn@LOCAL.DOMAIN>
```

## Extras

* If you want to warn users who use old browsers, the following projects are among the options to add little warnings: (browser-update.org)[https://browser-update.org/], (outdatedbrowser.com)[http://outdatedbrowser.com/]

## License

BSD 2-clause

