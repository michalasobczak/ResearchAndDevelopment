# GIS

## OS installation
Running on ```HP Pavilion x2 with Intel(R) Atom(TM) CPU Z3736F@ 1.33GHz``` and ```2GB``` of RAM. First, installed ```VirtualBox```. Then took ```ubuntu-18.04-live-server-amd64``` ISO image, install and start it. You need to switch to bridged networking in order to get access to services running in the VM. 

## Elasticsearch
Installed ```elasticserach``` version ```5.6.10``` from the official manual. Packages are as follows:

```
root@ubuntu:/home/michal# apt list | grep elastic

WARNING: apt does not have a stable CLI interface. Use with caution in scripts.

elastichosts-utils/bionic 20090817-0ubuntu1 all
elasticsearch/stable,now 5.6.10 all [installed]
elasticsearch-curator/bionic 5.2.0-1 all
golang-gopkg-olivere-elastic.v2-dev/bionic 2.0.12-1 all
golang-gopkg-olivere-elastic.v3-dev/bionic 3.0.41-1 all
libcatmandu-store-elasticsearch-perl/bionic 0.0509-1 all
libsearch-elasticsearch-perl/bionic 5.01-1 all
php-horde-elasticsearch/bionic 1.0.4-1 all
python-elasticsearch/bionic 5.4.0-1 all
python-elasticsearch-curator/bionic 5.2.0-1 all
python-elasticsearch-curator-doc/bionic 5.2.0-1 all
python-elasticsearch-doc/bionic 5.4.0-1 all
python3-elasticsearch/bionic 5.4.0-1 all
python3-elasticsearch-curator/bionic 5.2.0-1 all
rsyslog-elasticsearch/bionic 8.32.0-1ubuntu4 amd64
ruby-elasticsearch/bionic 1.0.12-1 all
ruby-elasticsearch-api/bionic 1.0.12-1 all
ruby-elasticsearch-transport/bionic 1.0.12-1 all
ruby-rails-assets-jakobmattsson-jquery-elastic/bionic 1.6.11~dfsg-1 all
```
