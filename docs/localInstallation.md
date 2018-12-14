---
title: Phis Deployment
layout: default
---
# Phis Deployment

1. [Prerequisite](#prerequisite)  
  + [Software](#software)  
      - [MongoDB and Robo3t](#mongodb-and-robo3t)
      - [Postgresql and Postgis](#postgresql-and-postgis)
      - [Netbeans and JDK](#netbeans-and-jdk)
      - [Php](#php)
      - [Apache Tomcat and RDF4J](#apache-tomcat-and-rdf4j)
      - [Apache2](#apache2)
      - [Composer](#composer)
      - [Git](#git)
      - [Check install](#check-install)
  + [Files](#files)
      - [Web service folder](#web-service-folder)
      - [Web application folder](#web-application-folder)
      - [Database and ontologies](#database-and-ontologies)
+ [Installation](#phis-installation)
    - [Mongodb Database](#mongodb-database)
    - [Postgresql Database](#postgresql-database)
    - [Rdf4j ontologies](#rdf4j-ontologies)
    - [Web service](#web-service)
    - [Web application](#web-application)
+ [Current errors](#current-errors)
    - [Problems with netbeans](#problems-with-netbeans)
    - [Problems with Composer](#problems-with-composer)
    - [Errors with postgresql](#errors-with-postgresql)
    - [Errors with the web service](#errors-with-the-web-service)
    - [Errors with the web application](#errors-with-the-web-application)
    - [Other problems concerned webapp and web service](#other-problems-concerned-webapp-and-web-service)

## Introduction  
This document explains you how to deploy Phis on your personnal computer.  
In this document, commands are for **Ubuntu 16.04**. However, the majority of these commands are compatible with all Debian distributions which have the package manager Aptitude.

## Prerequisite

### Software

#### MongoDB and Robo3t

##### MongoDB
All the information needed to install MongoDB is available at [docs.mongodb.com](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition/).

Now you have a Mongodb service.

You can change path to database in the **/etc/mongod.conf** file. But your location need to exist before starting mongodb service and you have to attribute correct rights on this folder:
```
    chown -R mongodb:mongodb <path_to_mongo_db_file>
```
In **/etc/mongod.conf** file, you should add line
```
  fork: true
```
after
```
  # how the process runs
  processManagement:*
```
(In classical case newline should be line 29)  
This line is not mandatory, in default mode mongodb runs as fork (i.e. as a deamon) but it is advised to force it by *fork: true* and avoid problems.

Every time you change **mongod.conf** file, you need restart mongod service.
```
  sudo systemctl restart mongod
```
In this document, we use default folder **/var/lib/mongodb**.  
To run mongodb, use following command line:
```
  sudo mongod --config /etc/mongod.conf
```


##### Robo3t

Download [robomongo](https://robomongo.org/download).
Extract:
```
  tar -xvf ~/Downloads/robo3t[...].tar.gz ~
```
Now to run robo3t do:
```
  cd
  ./robo3t/bin/robo3t
```


#### Postgresql + postgis

##### Postgresql Installation
Open a terminal and run:
```
 sudo apt-get update
 sudo apt-get install postgresql
 sudo apt-get install postgresql-9.5-postgis-2.2
```

##### Postgresql configuration
Configuration files are in **/etc/postgresql/9.5/main** folder.  
To change port, edit **postgresql.conf** file:
```
  nano /etc/postgresql/9.5/main/postgresql.conf
```
and in the **CONNECTION AND AUTHENTICATION** section change **port = XXXX** by **port = 5432**.
Restart service:
```
  sudo systemctl restart postgresql
```

#### Netbeans and JDK


##### Jdk
Install jdk where you want but you need to keep in mind its location.  
If jdk is already installed you can go to the next section, [Netbeans](#netbeans).

Download the jdk 8 sources (e.g. tar.gz archive) [oracle.com](http://www.oracle.com/technetwork/java/javase/downloads/index.html).  
Create a jdk folder.  
For example:
```bash
  mkdir ~/jdk
```

Extract the archive in this folder:
```bash
  tar -xvf ~/Downloads/jdk-X.X.X_linux-x64_bin.tar.gz ~/jdk/
```


##### Netbeans

Download the full version [netbeans.org](https://netbeans.org/downloads/start.html?platform=linux&lang=en&option=all).  
Run the script:
```bash
  sh ~/Downloads/netbeans-X.X-linux.sh
```
Follow the installation steps.

Check **PHP** and **Glassfish/JEE** module are installed.

Choose your installation folder for Netbeans (for us is ~/netbeans) and indicate the jdk installation folder. In our case it is ~/jdk.


#### PHP
```bash
  sudo apt-get update
  sudo apt-get install php php-mbstring php-dom
```


#### Apache Tomcat and RDF4J


##### Apache Tomcat installation

To have a better control over the installation of Tomcat you will install Tomcat from sources files (e.g. tar.gz archive).  

You can download Tomcat9.0 archive, core distribution, [tomcat.apache.org](https://tomcat.apache.org/download-90.cgi).

Create an installation folder for Tomcat. To simplify what follows you should create the Tomcat folder in /home:

```bash
  sudo mkdir /home/tomcat
```

and extract archive in this folder:
```bash
  cd /home/tomcat/
  sudo tar --owner=<user> -xvzf ~/Downloads/apache-tomcat.tar.gz
```

With this procedure, Tomcat is not recognized by Ubuntu services control (systemctl or services). So you need to execute scripts which are in Tomcat **bin** folder (ex: **startup.sh** to run and **shutdown.sh** to stop). You also need to change rights on files.


##### Apache Tomcat configuration
Tomcat configuration files are located in the **/home/tomcat/apache-tomcat/conf** folder.  
To use Tomcat manager page you need to define an admin user.  
To do that edit the **tomcat-users** file:
```bash
  nano /home/tomcat/apache-tomcat/conf/tomcat-users.xml
```
and add lines:
```bash
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="tomcat-admin" password="azerty" roles="manager, manager-gui"/>
```

To configure port, edit **server.xml**:
```bash
  nano /home/tomcat/apache-tomcat/conf/server.xml
```
and change:

```XML
<Connector port="XXXX" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
```

by:
```XML
<Connector port="8080" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
```
You have to allow **encoded slash** in **/home/tomcat/apache-tomcat/conf/catalina.properties**. If you have the line **"org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=false"**, change false value by true.  
If you don't have this line add **"org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true"** at the end of file.

Start the service:
```bash
  /home/tomcat/apache-tomcat/bin/startup.sh
```


##### RDF4J

Download archive zip file [rdf4j.org](http://rdf4j.org/download/).
Extract, for example:
```bash
  unzip ~/Downloads/eclipse-rdf4j-x.x.x-sdk.zip -d ~/
```
You can already copy .war files to the Tomcat webapps folder:
```bash
  cp ~/eclipse-rdf4j-x.x.x/war/* /home/tomcat/apache-tomcat/webapps/
```


#### Apache2

##### Apache Installation

```bash
  sudo apt-get update
  sudo apt-get install apache2 libapache2-mod-php7.0
```


##### Apache Configuration

With this installation configuration files are in /etc/apache2 folder.  
To change the port you need to edit the file port.conf:
```bash
  nano /etc/apache2/ports.conf
```
change line **LISTEN xx** to **LISTEN 80**.

Restart service apache2:

```bash
  sudo systemctl restart apache2
```


#### Composer
Sometimes when you install composer from ubuntu package, composer does not run correctly. To avoid problems, you should install composer from the composer installer file, via the following command line:

```bash
  sudo curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Maybe you should create a symbolic link between the new version of composer in /usr/bin or use the complete command. e.g. php /usr/local/bin/composer


Install now the plugin that you need to use composer.

```bash
  sudo composer global require "fxp/composer-asset-plugin:^1.2.0"
```




#### Git
You need git to download phis web service and web application.  
Git is already installed on ubuntu 16 default install, but if it is not, you can install it :
```bash
  sudo apt-get install git
```
Go to the [Using git](github.md) section of this documentation to check how OpenSILEX developpers use git.


#### Check install

For a good start you shall check  the configuration of apache2, tomcat and postgresql servers.

To do a quickly check, run the following commands lines:
```bash
  sudo systemctl start apache2
  sudo systemctl start postgresql
  /home/tomcat/apache-tomcat/bin/startup
  nmap 127.0.0.1
```
If nmap is not installed on your PC, don't install it because it is only used for checking ports.

The answer should be:
```
PORT     STATE SERVICE
80/tcp   open  http
631/tcp  open  ipp
5432/tcp open  postgresql
8009/tcp open  ajp13
8080/tcp open  http-proxy
```
For information:
- http is your Apache2 server
- postgresql is your Postgresql server
- http-proxy is your Tomcat server


They are the three services that you need. So if they are like previously (80 -> http, 5432 -> postgresql and 8080 -> http-proxy), you can continue to the next section [Prerequisite Files](#files).
But if you are one or plus which are different you have two options:  
- remember the differences and adapt yourself for the next. You can continue too.
- Please return to the concern program section ([tomcat](#apache-tomcat-configuration), [apache2](#apache-configuration),[postgresql](#postgresql-configuration))

N.B.: If you didn't install programs exactly like in this document, it is possible that configurations files aren't located exactly like us.



### Files
I recommand you to create a folder where you will download all the required files.
```bash
  mkdir ~/Phis
```


#### Web service folder
Get source from github, directly from the phis-ws development repository:
```bash
  cd ~Phis
  git clone https://github.com/OpenSILEX/phis-ws.git
```
Preferably, get the source from the last release at [phis-ws/releases](https://github.com/OpenSILEX/phis-ws/releases).

#### Web application folder
Get source from github, directly from the phis-webapp development repository:
```bash
  cd ~Phis
  git clone https://github.com/OpenSILEX/phis-webapp.git
```
Preferably, get the source from the last release at [phis-webapp/releases](https://github.com/OpenSILEX/phis-webapp/releases).

#### Ontology files
Get source from github, directly from the ontology-phis-oepo-field development repository:
```bash
  cd ~Phis
  git clone https://github.com/OpenSILEX/ontology-phis-oepo-field
```
Preferably, get the source from the last release at [ontology-phis-oepo-field/releases](https://github.com/OpenSILEX/ontology-phis-oepo-field/releases).

#### Database file

Download the database dump file [phis_st_dump.sql](assets/phis_st_dump.sql).


## Phis Installation

### Mongodb database

You only create a connection to a collection.
Run mongodb:
```bash
  sudo mongod --config /etc/mongod.conf
```
Run robot3t:
```bash
  ~/robo3t/bin/robo3t
```
Create a connexion:
![robo3t-connexion1](img/robo3t-connexion1.png)
Configure your connection:
![robo3t-connexion2](img/robo3t-connexion2.png)
Create your database:
Right click on connection name -> create a database -> enter a name (in this document it will be "diaphen")
Now, you can close robo3t.



### Rdf4j ontologies

Go to http://localhost:8080/
You are in Tomcat server home page, click on **manager app**, connect with tomcat-admin user.  
Search **rdf4j-workbench** in the list, if it isn't in the list,deploy it, and click on the name **rdf4j-workbench**.  
Click **New repository** and complete as in the picture:
![rdf4j-nr1](img/rdf4j-nr1.png)
Click **next**, check if all is as on this second picture:
![rdf4j-nr2](img/rdf4j-nr2.png)
Click **create**.  

You will do these steps many times :  

Now, click **Add** in *Modify* menu.  

![rdf4j-add](img/rdf4j-add.png)


Click **Parcourir...** selection **oepo.owl** file get previously from GitHub repository **ontology-phis-oepo-field**

Add it in the context   **<http://www.phenome-fppn.fr/vocabulary/2017>** with base URI and context fields.

In **RDFData format** select **RDF/XML**.

Click **Upload**  


Add also a new context for the ontology annotation
Add [oa.rdf](assets/oa.rdf) file in **<http://www.w3.org/ns/oa>** context.


### Postgresql and Postgis


#### Creating phis users
```SQL
  sudo -i -u postgres
  psql
  CREATE USER phis;
  ALTER ROLE phis WITH CREATEDB;
  ALTER ROLE phis WITH SUPERUSER;
  ALTER USER phis WITH ENCRYPTED PASSWORD 'azerty';
  \q #leave psql
  exit #disconnect postgre
```

#### Creating Database
```SQL
  sudo -i -u postgres
  psql
  CREATE DATABASE diaphen OWNER phis;
  \q
  exit
  psql -U phis diaphen #connection like phis user on the diaphen database
  CREATE EXTENSION postgis;
  select postgis_full_version();
  \q
```
If you have an error connecting to the user phis (+ FATAL: authentification peer:), see [Errors with postgresql](#Errors-with-postgresql) in the error section.

#### Initialising Database
Importing data with:
```bash
  psql -U phis diaphen < ~/Phis/phis_st_dump.sql
```
You can find [dump file](assets/phis_st_dump.sql).

With specific access rights you can get a dump from demonstration version.
```bash
# from postres server
pg_dump -O -U phis diaphen > phis_st_dump.sql
# -O : --no-owner
# -s : only schema
# -h <IP> : postgres host
# -U <user> : user
```

If you need to generate a MD5 password, you can use:
```bash
   echo -n bonjour | md5sum
```

#### Initialising Users
To start using or try Phis, two users are created automatically:
* admin@phis.fr/admin for administrative rights
* guest@phis.fr/guest for restricted rights
See Phis user documentation for explanation and add other users.


### Web service

To deploy a webservice with Tomcat you need a war file.  
To generate a war file from a project the easiest solution is to use Netbeans.


#### Folders
Create directories for images and
```bash
  mkdir -p /home/<user>/phis2ws/documents/instance
  mkdir /var/www/html/images
  mkdir /var/www/html/layers
  chown -R [username]:[username] /var/www/html/images
  chown -R [username]:[username] /var/www/html/layers
  chown -R [username]:[username] /home/<user>/phis2ws/documents/
  chmod -R 775 /var/www/html/images
  chmod -R 775 /var/www/html/layers
  chmod -R 775 /home/<user>/phis2ws/documents/
```


#### Open project
Run netbeans:
```
  ~/netbeans/bin/netbeans
```
Netbeans frequently meets error when he starts. If you have an error please go to the [current error](#problems-with-netbeans) section.

When netbeans starts, open phis2ws project. It is located in ~/Phis/phis-ws/.

If problems are detected in the project: right click on the project name -> resolve problems -> resolve.  
If problems can't be resolved like that please go to the [current error](#errors-with-the-web-service) section.


#### Configuration Files

You don't need to edit your configuration files specifically with netbeans, you can use a classical text editor (nano, vim, gedit...) to edit them.

Maven profiles are used to generate war files with different configurations.

Three profiles exists by default:
- **dev** (default): Profile used for local developpement with default values
- **test**: Profile used for testing purpose with no values by default
- **prod**: Profile used for production with no values by default

Specific profiles configurations are defined in a **config.properties** file which is located in folder **phis2-ws/src/main/{profile name}/**

Netbeans users: configuration files are located in `~/Phis/phis-ws/phis2-ws/src/main/profiles {profile name}`.

Profile could be used with the following command line (-P option):

```bash
mvn install -Ptest
```

Without -P option dev profile is used.

_Informations:  
If you use netbeans to deploy war file in tomcat server, default port is 8084 but in this document we choose to deploy ourselves war file so the port need to be tomcat service port (8080).  
The choice of deploying ourselves is justified by the universality of the procedure. Netbeans is heavy and some pc can have difficulty to run netbeans and other softwares at the same time.  
If you can use netbeans you have the advantage to modify files and deploy them faster._

_Attention:
Every time you use localhost address you need use ip address 127.0.0.1 and not the name localhost_

Edit the file **config.properties** of the **dev** profile:
You have to adapt values between **< >** but if you are doing exactly like in this document, other values are good.
You need change port with the port choose for Tomcat, in our case 8080.

```properties
# MongoDB configuration
mongo.host=127.0.0.1
mongo.port=27017
mongo.db=<MongoDB database name, eg. diaphen>

# PostgreSQL configuration
pg.host=127.0.0.1
pg.port=5432
pg.db=<PostgreSQL database name, eg. diaphen>
pg.user=<PostgreSQL user name, eg. phis>
pg.password=<PostgreSQL user password, eg. azerty>

# RDF4J Configuration
rdf.host=127.0.0.1
rdf.port=<8080>
rdf.path=<Rdf4j .war file name, eg. rdf4j-server>
rdf.infra=<Rdf4j infrastructure name, eg. diaphen>
rdf.repo=<Rdf4j repository name, eg. diaphen>

# Webservice configuration
ws.log.dir=/home/tomcat/phis2ws/logs

ws.host=127.0.0.1
ws.port=<8080>
ws.target=phis2ws
ws.baseUrl=rest

ws.doc.host=127.0.0.1
ws.doc.port=<8080>
ws.doc.name=phis2ws

ws.updir.host=127.0.0.1
ws.updir.user=<Linux session name>
ws.updir.password=<Linux session password>
ws.updir.doc=/home/phis2ws/documents/instance

ws.images.dir=/var/www/html/images
ws.images.url=http://127.0.0.1/images

ws.layers.dir=/var/www/html/layers
ws.layers.url=http://127.0.0.1/layers
```

#### Generate war file

When all configuration files are correct you can generate the war file.  
To do that, in netbeans:  
**click right on project -> build with depedencies**
Your war is generated in **~/Phis/phis-ws/target**


#### Deploy war file

Copy the war archive in tomcat webapps folder:
```bash
  cp ~/Phis/phis-ws/target/phis2ws.war /home/tomcat/apache-tomcat/webapps/phis2ws.war
```


#### Check web service

Your webservice is directly deployed. You can check that:  
Go to http://127.0.0.1:8080/  

_It is necessary you don't use localhost._  
You are in Tomcat server home page, click on **manager app**, connect with Tomcat user.  
Search **phis2ws** in the list, if it isn't in the list, deploy it, then click on the name **phis2ws**.  
You are on your service web, if it is correctly configurated you have 2 opperationnal links.  

_You can go directly with http://127.0.0.1:8080/phis2ws __

To check you are correctly configurating your web service:
Go to **Documentation link**, try **brapiv1token**:
post -> click on example -> try it out  
If you haven't:
```
Response Code

201
```
please go to [current error](#errors-with-th-web-service) section.



### Web application


#### Folder


The web application deployment is done by apache2. You have to copy webapp folder in apache root folder. In our case /var/www/html.
```
  sudo cp -r ~/Phis/phis-webapp /var/www/html
```
Change right on this folder:
```
  sudo chown -R [username]:www-data /var/www/html/phis-webapp
  sudo chmod 775 -R /var/www/html/phis-webapp
```
*information:  
www-data is the default apache2 username. But in rare case it can be a different name, you can check that in /etc/apache2/envars file.*


#### Configuration


To deploy in localhost it isn't necessary to open webapp with netbeans, you only need to adapt configuration files so you can use classical editor.  
Netbeans users:  
Open the webapp folder with netbeans, like a php project.

open project -> **/var/www/html/phis-webapp** -> open  
Configuration files are in: *phis-webapp* -> *sources files* -> *config*  
Other users:  
Configuration files are in: **/var/www/html/phis-webapp/config**   

Edit:
  - *webservices.php*  
Adapt the last line with the correct URL in our case is:
**http://127.0.0.1:8080/phis2ws/rest**

If you are doing exactly like in this document, it's the only configuration file you need to change. But you can check other configuration files: compare paths and URL with information written in web services configuration files.



#### Composer

Go to your webapp folder and applicate **composer update**:
```
  cd /var/www/html/phis-webapp
  sudo composer update
```
It can be very long, and perhaps you will need install some php-smth packages:  
```
  sudo apt-get install php-smth1 php-smth2
```
*(adapt smth with name given by composer)*

While you don't obtain a successful issue, fix errors and rerun **composer update**.

Maybe you need to change some owner and rights properties of new files. So, you can do :
```
  sudo chown -R [username]:www-data /var/www/html/phis-webapp
  sudo chmod 775 -R /var/www/html/phis-webapp
```

So now, normally you have a operationnal phis application on your localhost.
Go to **http://127.0.0.1:80/phis-webapp** and test with log in.

If you have problems search on **Current errors** section.



## Current errors

### Problems with netbeans

+ Exit without error message when he is starting  

Some ressources are not found ou not accessible.
Check rights on files/folders in ~/.netbeans/8.2.
```
ls -l ~/.netbeans/8.2
```
To run netbeans, owner of all files/folders should be the regular pc user. You can fix it with:
```
sudo chown -R [username]:[username] ~/.netbeans
```
Netbeans need also regular user can read and write all files of the folder. To fix it:
```
sudo chmod -R ug+rw ~/.netbeans
```

+ Errors concerned jdk/jre:

Netbeans doesn't find jdk installation, to fix it check if you indicate the correct jdk folder to netbeans. To do that edit file ~/netbeans-8.2/etc/netbeans.conf and adapt jdk path line 57.
If the error persists it can be your jdk installation wasn't done correctly, uninstall jdk and use [this procedure](#jdk) to reinstall.


### Problems with composer

If you installed composer with apt from ubuntu packages, please uninstall composer (think to remove cache and configuration files in ~/.cache and /etc folders) and reinstall with [this porcedure](#composer).

If it doesn't fix the problem please check [composer troubleshooting page](#https://getcomposer.org/doc/articles/troubleshooting.md).


### Errors with postgresql

+ FATAL: authentification peer:  

Edit file **/etc/postgresql/9.5/main/pg_hba.conf** and change line 90:
```bash
local all all peer
```
by
```bash
local all all md5
```
and restart service:
```bash
sudo systemctl restart postgresql
```
+ Distance connection impossible

Edit file /etc/var/postgresql/9.5/main/pg_hba.conf
You need to adapt all with correct ip address, for example:
```
hosts all all <ipaddress> md5
```
Edit file /etc/var/postgresql/9.5/main/postgresql.conf
change line:
```
listen_addresses: '*'
```
and restart service:
```
sudo systemctl restart postgresql
```


### Errors with the web service

+ Errors with generation of war file  

In netbeans:
Click right on project name -> resolve problems
If it detects plugins problems I recommand you to fix them yourself with tool menu -> plugins.
If it another problem you can try fix him with resolve button. But if the problem persists it probably comes from a modification in a project files you can try find it or close project and reopen or remove all phis web service files and download again.

+ Not ressources / 404 or other problems with web service

Recheck path and port in web service file services.properties. If every lines are exactly like this:
```
[...]
logDirectory=/home/tomcat/phis2ws/logs

[...]
host=127.0.0.1:8080
basePath=/phis2ws/rest
[...]
webAppHost=127.0.0.1
webAppPort=8080
[...]
webAppApiDocsName=phis2ws
[...]
webAppApiBasePath=/phis2ws/resources

[...]
uploadFileServerPort=22
# Adresse de sauvegarde des donn\u00e9es
uploadFileServerIP=127.0.0.1
uploadFileServerUsername=[linux session username]
uploadFileServerPassword=[linux session password]
uploadFileServerDirectory=/home/<user>/phis2ws/documents/instance
uploadImageServerDirectory=/var/www/html/images
layerFileServerDirectory=/var/www/html/layers
layerFileServerAddress=http://127.0.0.1/layers
[...]

```
+ Error with test brapiv1token

Your database is inaccessible or wrong.
Verify you postgresql server with nmap or your favorite tool for port gestion.
If it isn't running, restart the service:
```
sudo systemctl restart postgresql
```
If the service is running but you have a problem it comes from the configurations files, verify paths, URL and port in service.properties file and URL, port and database name in phis_sql_config file.

If all your configurations files are good it can be a mistake in your database.



### Errors with the web application

+ No home page

Browser can't access to the page, it can come from right on the web application files in /var/www/html/phis-webapp. Check rights with `ls -l` command line, and make change if something is wrong.  
Each files have:  
owner: username (name of your session on the pc)  
group: www-data (or the name of you apache user)  
```
  sudo chown -R [username]:www-data /var/html/phis-webapp
```
rights: rwxrwxr-x  
```
  sudo chmod -R 775 /var/html/phis-webapp
```
+ Can't log in

It can be a configuration file of the web application (/var/www/html/phis-webapp/config) or a configuration file of the web service or a problem with de postgresql database.
In your configurations file check URL and port.
With psql check if your database isn't wrong.

+ Github token

If you get an error "GitHub API limit (60 calls/hr) is exhausted..." during composer insallation, you need to connect Github and get a Personal access tokens. See https://github.com/settings/tokens.



#### Other problems concerning the webapp and the web service

In most case problems come from configuration files, verify every informations in these files.

When you modify a web service configuration you have to rebuild and redeploy war file.
Think to remove old version in tomcat webapp folder before copy your new version.
