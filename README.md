twemproxy Cookbook
==================
Installs Redis and Nutcracker, and proxies between two Redis instances running on ports 6379 & 6380.

Requirements
------------
* Vagrant
* Test Kitchen
* Chefspec
* Serverspec
* Berkshelf
* vagrant-berkshelf plugin, version >= 2.0.1

#### packages
- `wget`

### Cookbooks
* apt
* build-essential
* redisio

Usage
-----
#### twemproxy::default
Just include `twemproxy` in your node's `run_list`:

```json
{
  "name":"my_node",
  "run_list": [
    "recipe[twemproxy]"
  ]
}
```

License and Authors

License and Authors
-------------------
Authors: Roland Cooper
