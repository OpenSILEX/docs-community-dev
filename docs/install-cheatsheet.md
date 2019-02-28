# OpenSILEX installation cheatsheet

## Prerequisite
Required operating system : Linux.
Suggested Linux distribution: [Ubuntu 16.04 LTS](http://releases.ubuntu.com/16.04/).

<style>
div.orange { background-color:#ffe1a2; border-radius: 5px; padding: 20px;}
</style>
<div class = "orange" markdown="1">
Environment:

- [JDK 8](http://www.oracle.com/technetwork/java/javase/downloads/index.html) (minimal Java version, compatibility up to java version 11.0.1)
- [Maven 3.6](https://maven.apache.org/install.html) *software project management*
- [PHP 7.0](https://packages.ubuntu.com/xenial/httpd/libapache2-mod-php7.0) *scripting language*
- [Composer](https://getcomposer.org/download/) *dependency manager for PHP*
- [Git](https://git-scm.com/downloads) *versioning software*
</div>
<br>

<style>
div.blue { background-color:#e6f0ff; border-radius: 5px; padding: 20px;}
</style>
<div class = "blue" markdown="1">
Web servers:

- [Tomcat 9.0](https://tomcat.apache.org/download-90.cgi?Preferred=ftp://ftp.osuosl.org/pub/apache/) *Java Servlet Container*
- [Apache 2.4](https://httpd.apache.org/docs/2.4/) *HTTP Server*
</div>

<br>



<style>
div.pink { background-color:#f7e4ee; border-radius: 5px; padding: 20px;}
</style>
<div class = "pink" markdown="1">
Database management systems:

- [MongoDB 4.0](https://docs.mongodb.com/manual/administration/install-on-linux/) *for noSQL databases*
- [PostgreSQL 9.5](https://www.postgresql.org/docs/9.5/release-9-5.html) *for SQL databases*
- [PostGIS 2.2](https://postgis.net/docs/postgis_installation.html#install_short_version) (minimal PostGIS version)
- [RDF4J 2.4.5](http://rdf4j.org/download/) *for triplestores*
</div>

<br>




<style>
div.green { background-color:#c8eec8; border-radius: 5px; padding: 20px;}
</style>
<div class = "green" markdown="1">
Suggested tools:

- [Robo 3T](https://robomongo.org/download) *GUI client for MongoDB*
- [NetBeans](https://netbeans.org/community/releases/82/install.html) *IDE*
</div>

## OpenSILEX Databases
<div class = "orange" markdown="1">
### PostgreSQL

```sql
CREATE DATABASE opensilex OWNER opensilex;
CREATE EXTENSION postgis;
select postgis_full_version();
```
Importer le dump:
`psql -U opensilex opensilex < Documents/opensilex_st_dump.sql`
</div>
<br>

<div class = "blue" markdown="1">
### Rdf4J
Créer le repository :
- Type : **Native Java Store**
- ID : opensilex
- Title : opensilex
Ajouter les ontologies :
- OESO :
  - Téléchargeable sur Github : https://github.com/OpenSILEX/ontology-vocabularies
  - URI du contexte : http://www.opensilex.org/vocabularies/oeso
- OEEV :
  - Téléchargeable sur Github : https://github.com/OpenSILEX/ontology-vocabularies
  - URI du contexte : http://www.opensilex.org/vocabularies/oeev
- OA :
  - Téléchargeable via le lien : http://www.w3.org/ns/oa.rdf
  - URI du contexte : http://www.w3.org/ns/oa
</div>
<br/>
<div class = "pink" markdown="1">
## MongoDB
Créer la base `opensilex`.
</div>
<br/>

## OpenSILEX web service configurations

<div class = "green" markdown="1">
### MongoDB configuration
mongo.host=localhost
mongo.port=27017
mongo.db=opensilex
</div>
<br/>
<div class = "orange" markdown="1">
### PostgreSQL configuration
pg.host=localhost
pg.port=5432
pg.db=opensilex
pg.user=username
pg.password=password
</div>
<br/>
<div class = "blue" markdown="1">
### RDF4J Configuration
rdf.base.uri=http://www.opensilex.org/
rdf.host=localhost
rdf.port=8084
rdf.path=rdf4j-server
rdf.infra=opensilex
rdf.infra.code=DMO
rdf.repo=opensilex
rdf.vocabulary.context=http://www.opensilex.org/vocabulary/oeso
</div>
<br/>
<div class = "green" markdown="1">
### Others configurations
ws.log.dir=/home/tomcat/phis2ws/logs

ws.host=localhost
ws.port=8084
ws.target=phis2ws
ws.baseUrl=rest

ws.doc.host=localhost
ws.doc.port=8084
ws.doc.name=phis2ws

ws.updir.host=opensilex
ws.updir.user=username
ws.updir.password=password
ws.updir.doc=/home/opensilex/documents/instance

ws.images.dir=/var/www/html/images
ws.images.url=http://localhost/images

ws.layers.dir=/var/www/html/layers
ws.layers.url=http://localhost/layers
</div>

</div>

## OpenSILEX webapp configurations

<div class = "orange" markdown="1">
### config/web_services.php
```php
define('WS_PHIS_PATH', 'http://localhost:8084/phis2ws/rest/');
define('WS_PHIS_PATH_DOC', 'http://localhost:8084/phis2ws');
```
</div>
<br/>

<div class = "blue" markdown="1">
### config/config.php
```php
$appli = 'phis-webapp';
$hostname = 'localhost';
```
</div>
<br/>

<div class = "pink" markdown="1">
### config/params.php
```php
'platform' => 'Demo'
```
</div>
<br/>

<div class = "green" markdown="1">
### index.php
```php
<meta http-equiv="refresh" content="0;URL=http://localhost/phis-webapp/web">
```
</div>
<br/>

<!---
Jersey
Yii2
--->
