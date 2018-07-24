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

Remember to add firewall rules. Please take note that ```elasticsearch``` does not work on 32 bits OS officially.


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

Import data:

```
sudo -u postgres -i
osm2pgsql --create \
--slim \
--cache 128 --number-processes 1 --hstore \
--style /home/michal/osm/openstreetmap-carto/openstreetmap-carto.style \
--multi-geometry \
/home/michal/osm/lubelskie-latest.osm.pbf \
-d gis -U postgres
```

Import took 2720s and it is around 2GB of PostgreSQL data.


## Rendering

### Preparation

Install some packages:

```
apt install libboost-all-dev git-core tar unzip wget bzip2 build-essential autoconf libtool \
libxml2-dev libgeos-dev libgeos++-dev libpq-dev libbz2-dev libproj-dev munin-node munin \
libprotobuf-c0-dev protobuf-c-compiler libfreetype6-dev libtiff5-dev libicu-dev libgdal-dev \
libcairo-dev libcairomm-1.0-dev apache2 apache2-dev libagg-dev liblua5.2-dev ttf-unifont lua5.1 \
liblua5.1-dev libgeotiff-epsg curl
```

### Mapnik

```Mapnik``` installation:

```
apt-get install autoconf apache2-dev libtool libxml2-dev libbz2-dev libgeos-dev libgeos++-dev \
libproj-dev gdal-bin libmapnik-dev mapnik-utils python-mapnik
```

### mod_tile and renderd

```mod_tile``` and ```renderd``` installation:

```
cd 
mkdir src
cd src
git clone -b switch2osm git://github.com/SomeoneElseOSM/mod_tile.git
cd mod_tile
./autogen.sh
./configure
make
make install
make install-mod_tile
ldconfig
```

stylesheets additional installation:

```
apt install npm nodejs
npm install -g carto
carto -v 
```

converting ```mml``` into ```xml```:

```
carto project.mml > mapnik.xml
```

download shape files:

```
cd
cd osm/openstreetmap-carto/scripts
./get-shapefiles.py
```

```renderd``` configuration edit with appropriate number of cores ```/usr/local/etc/renderd.conf```.

### Apache

configure ```Apache```:

```
mkdir /var/lib/mod_tile
chown renderaccount /var/lib/mod_tile
mkdir /var/run/renderd
chown renderaccount /var/run/renderd
```

edit ```/etc/apache2/conf-available/mod_tile.conf``` with the following:

```
LoadModule tile_module /usr/lib/apache2/modules/mod_tile.so
```

and run ```a2enconf mod_tile```

edit ```/etc/apache2/sites-available/000-default.conf``` adding 

```
LoadTileConfigFile /usr/local/etc/renderd.conf
ModTileRenderdSocketName /var/run/renderd/renderd.sock
# Timeout before giving up for a tile to be rendered
ModTileRequestTimeout 0
# Timeout before giving up for a tile to be rendered that is otherwise missing
ModTileMissingRequestTimeout 30
```

between ```ServerAdmin``` and ```DocumentRoot```.
