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
\q
```
import [dump](https://opensilex.github.io/docs-community-dev/assets/opensilex_st_dump.sql):
`psql -U opensilex opensilex < Documents/opensilex_st_dump.sql`
</div>
<br>

<div class = "blue" markdown="1">
### Rdf4J
Create repository :
- Type : **Native Java Store**
- ID : opensilex
- Title : opensilex
Import ontologies :
- OESO :
  - Downloadable on Github : https://github.com/OpenSILEX/ontology-vocabularies (latest release)
  - URI of the context : http://www.opensilex.org/vocabularies/oeso
- OEEV :
  - Downloadable on Github : https://github.com/OpenSILEX/ontology-vocabularies (latest release)
  - URI of the context : http://www.opensilex.org/vocabularies/oeev
- OA :
  - Downloadable on : http://www.w3.org/ns/oa.rdf
  - URI of the context : http://www.w3.org/ns/oa
</div>
<br/>
<div class = "pink" markdown="1">
## MongoDB
Create an `opensilex` database (optionnal).
</div>
<br/>

## OpenSILEX web service configurations

The source code is available at `https://github.com/OpenSILEX/phis-ws/releases`. Use the following command line to download the latest release:
```
git clone --branch 3.2.4 https://github.com/OpenSILEX/phis-ws.git
```

<div class = "green" markdown="1">
### MongoDB configuration
```
mongo.host=localhost
mongo.port=27017
mongo.db=opensilex
```
</div>
<br/>
<div class = "orange" markdown="1">
### PostgreSQL configuration
```
pg.host=localhost
pg.port=5432
pg.db=opensilex
pg.user=username
pg.password=password
```
</div>
<br/>
<div class = "blue" markdown="1">
### RDF4J Configuration
```
#	Base	of	the	generated	URIs	-	can	be	personalized:
rdf.base.uri=http://www.opensilex.org/
#	RDF4J	localisation	and	repository	ID:
rdf.host=localhost
rdf.port=8080
rdf.path=rdf4j-server
rdf.repo=opensilex
#	Managed	infrastructure	-	can	be	personalized:rdf.infra=opensilex
#	3	letters	code	for	the	infrastructure:
rdf.infra.code=OSX
#	Context	of	the	vocabulary.	Oeso	by	default:
rdf.vocabulary.context=http://www.opensilex.org/vocabulary/oeso
```
</div>
<br/>
<div class = "green" markdown="1">
### Others configurations
```
#	Logs	repertory.	You	need	to	create	this	directory
#	(do	not	forget	the	access	rights!)
ws.log.dir=/home/training/opensilex/logs
#	The	web	service	url	access	will	be:
#	http://{ws.host}:{ws.port}/{ws.target}/{ws.baseUrl}
ws.host=localhost
ws.port=8080
#	Name	of	the	application	-	can	be	personalized	in	the	pom.xml	file
ws.target=opensilex
ws.baseUrl=rest
ws.doc.host=localhost
ws.doc.port=8080
ws.doc.name=opensilex
ws.pageSize.max=2097152
ws.updir.host=opensilex
ws.updir.user=username
ws.updir.password=password
#	Files	storage	directory	(do	not	forget	the	access	rights)
ws.updir.doc=/home/training/opensilex/documents/{rdf.infra}
#	Images	storage	directory	(do	not	forget	the	access	rights)
ws.images.dir=/var/www/html/images
ws.images.url=http://localhost/images
ws.layers.dir=/var/www/html/layers
ws.layers.url=http://localhost/layers
```
</div>

## OpenSILEX webapp configurations

The	source	code	is	available	at	 	https://github.com/OpenSILEX/phis-webapp/releases
Use	the	following	command	line	to	download	the	latest	release:
`git	clone	--branch	3.2.4	https://github.com/OpenSILEX/phis-webapp.git`

Change	webapp	files	group	to	allow	apache	to	read	them:
`chown	-R	training:www-data	/home/training/opensilex/phis-webapp`

<div class = "orange" markdown="1">
### config/web_services.php
```php
//	http://{ws.host}:{ws.port}/{ws.target}/{ws.baseUrl}/
define('WS_PHIS_PATH',	'http://localhost:8080/opensilex/rest/');
//	http://{ws.host}:{ws.port}/{ws.name}
define('WS_PHIS_PATH_DOC',	'http://localhost:8080/opensilex');
```
</div>
<br/>

<div class = "blue" markdown="1">
### config/config.php
```php
# Application name, accessible at the URL http://$hostname/$appli
$appli = 'opensilex';
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
<meta http-equiv="refresh" content="0;URL=http://localhost/phis/web">
```
</div>
<br/>
