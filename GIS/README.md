# GIS

## OS installation
Running on ```HP Pavilion x2 with Intel(R) Atom(TM) CPU Z3736F@ 1.33GHz``` and ```2GB``` of RAM. First, installed ```VirtualBox```. Then took ```ubuntu-18.04-live-server-amd64``` ISO image, install and start it. You need to switch to bridged networking in order to get access to services running in the VM. 

## Elasticsearch
First, installed Java 8. Then, installed ```elasticserach``` version ```5.6.10``` from the official manual. Install Kibana. As there is little memory, I set up only 64 MB for ```ms``` and ```mx``` JVM properties. Configure the following:
```
/etc/elasticsearch/elasticsearch.yml
/etc/kibana/kibana.yml
/etc/elasticsearch/jvm.options
```

Remember to add firewall rules.

## Switch to OSM
```
apt-get --no-install-recommends -y install git unzip curl build-essential software-properties-common
apt-get --no-install-recommends install -y postgresql-10-postgis-2.4 postgresql-contrib-10 proj-bin libgeos-dev
add-apt-repository -y ppa:kakrueger/openstreetmap
apt-get update
apt-get --no-install-recommends install -y osm2pgsql osmctools
apt-get install postgresql-10-postgis-2.4-scripts
```

Configure ```overcommit```:

```
sudo tee /etc/sysctl.d/60-overcommit.conf <<EOF
# Overcommit settings to allow faster osm2pgsql imports
vm.overcommit_memory=1
EOF
sudo sysctl -p /etc/sysctl.d/60-overcommit.conf
```

Initialize database:

```
sudo -u postgres createuser -s $USER
createdb gis
psql -d gis -c 'CREATE EXTENSION hstore; CREATE EXTENSION postgis;'
```

Get some stylesheets:

```
cd
mkdir osm
cd osm
git clone https://github.com/gravitystorm/openstreetmap-carto.git
```

## OSM PBF data
We need to get some data to work with:

```
cd ~/osm
https://download.geofabrik.de/europe/poland/lubelskie-latest.osm.pbf
```

