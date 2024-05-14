# Gin Control

This is an example [Puppet Control Repository](https://www.puppet.com/docs/pe/2023.5/control_repo.html) 
for implementing the gin and juniper modules in a serverless
environment using [bolt](https://www.puppet.com/docs/bolt/latest/bolt.html).

```bash
bolt module install
```

```bash
vagrant up ubuntu22
```

```bash
bolt plan run -v gin::apply --run-as=root -t ubuntu22 --stream
```

## Prerequisites

- Ensure the hostname (FQDN) is set.
- Install augeus (on debian libaugeas-dev and sudo gem install ruby-augeas)
- `sudo /opt/puppetlabs/puppet/bin/gem install ruby-augeas`
