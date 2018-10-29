PostgreSQL# OpenSILEX Deployment

1. [Prerequisite](#prerequisite)  
  + [Software](#software)  
      - [MongoDB + Robo 3T](#mongodb--Robo3T)
      - [PostgreSQL + PostGIS](#postgresql--postgis)
      - [Netbeans + JDK](#netbeans--jdk)
      - [PHP](#php)
      - [Apache-Tomcat + rdf4j](#apache-tomcat-rdf4j)
      - [Apache2](#apache2)
      - [Composer](#composer)
      - [Git](#git)
      - [Check install](#check-install)
  + [Files](#files)
      - [Web service folder](#web-service-folder)
      - [Web application folder](#web-application-folder)
      - [Database and ontologies](#database-and-ontologies)
+ [Installation](#open-silex-installation)
    - [MongoDB Database](#mongodb-database)
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

This document explains you how to deploy OpenSILEX on your personnal computer.  
In this document commands lines are for **Ubuntu 16.04**, but for the majority of them, they are compatible with all Debian distribution which have the package manager Aptitude.

## Prerequisite

### Software

#### MongoDB + Robo 3T

##### MongoDB

All the information needed to install MongoDB is available at  [docs.mongodb.com](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition/).

Now MongoDB is installed.

**Note**<br/>
The path to the database can be changed in the `etc/mongod.conf` file.
Set the owner on the MongoDB file:
```bash
sudo chown -R mongodb:mongodb <path_to_mongo_db_file>
```
In `/etc/mongod.conf` file, you should add line: `fork: true` after
```
# how the process run
processManagement:*
```
as follows :
```
# how the process run
processManagement:*
  fork: true
```

**Note**<br/>
This line is not an obligation, in default mode MongoDB runs as fork (i.e. as a deamon) but it is preffered to force it by `fork: true` for no doubt.

Every time you change the `mongod.conf` file, you need to restart the mongod service:
```bash  
sudo systemctl restart mongod
```
In this document, we use default folder `var/lib/mongodb`  
To run MongoDB, use following command line:
```bash  
sudo mongod --config /etc/mongod.conf
```

##### Robo 3T

Download Robomongo [here](https://robomongo.org/download).

Extract the downloaded archive (replace `<version>`
 with your version of Robot3t):
```bash  
tar -xvf ~/Downloads/robo3t<version>  .tar.gz <Robo 3T repository location>
```
Go to Robo 3T repository location:
```bash  
cd <Robo 3T repository location>
```

Run the installation program:
```bash  
./robo3t<version>  /bin/robo3t
```

#### Postgresql & PostGIS

##### PostgreSQL Installation

In a terminal, run these commands:
```bash  
 sudo apt-get update
 sudo apt-get install postgresql
 sudo apt-get install postgresql-9.5-postgis-2.2
```

##### PostgreSQL configuration

The configuration files are in the `etc/postgresql/9.5/main` folder.  
To change the port of the service, edit the `postgresql.conf` file:
```bash  
nano /etc/postgresql/9.5/main/postgresql.conf
```
In the **Connection and Authentication** section, replace `port = XXXX` by `port = 5432`.

Then restart the service to take the changes into account:
```bash
sudo systemctl restart postgresql
```

#### Netbeans + jdk

##### Jdk

If jdk is already installed you can go to the next section, [Netbeans](#netbeans).

Otherwise, download the JDK 8 sources (e.g. `tar.gz` archive) at [oracle.com](http://www.oracle.com/technetwork/java/javase/downloads/index.html).

Create a JDK folder wherever you want. For example:
```bash
mkdir ~/jdk
```

In the created folder, extract the archive with this command:
```bash
tar -xvf ~/Downloads/jdk-X.X.X_linux-x64_bin.tar.gz ~/jdk/
```

##### Netbeans

Download the full version of Netbeans at [netbeans.org](https://netbeans.org/downloads/start.html?platform=linux&lang=en&option=all).

Run the downloaded script:
```bash
sh ~/Downloads/netbeans-X.X-linux.sh
```
Follow the installation steps.

Check that the **PHP** and **Glassfish/JEE** modules are installed.

Choose your installation folder for Netbeans (here `~/netbeans`) and select the jdk installation folder (in our case `~/jdk`).

#### PHP

Install PHP by running the following commands:
```bash
sudo apt-get update
sudo apt-get install php php-mbstring php-dom
```

#### Apache-Tomcat + rdf4j

##### Apache-Tomcat installation

To have a better control on the installation of Tomcat, install Tomcat from sources files (e.g. `tar.gz` archive).  

You can download Tomcat9.0 archive, core distribution, at [tomcat.apache.org](https://tomcat.apache.org/download-90.cgi).

Create an installation folder for Tomcat. We advise you to create the Tomcat folder in `/home`:

```bash
sudo mkdir /home/tomcat
```

Extract the archive in this folder (replace `<user>` by your user and `<version>` by the version you downloaded):
```bash
cd /home/tomcat/
sudo tar --owner=<user> -xvzf ~/Downloads/apache-tomcat<version>.tar.gz
```

With this procedure, Tomcat is not recognized by Ubuntu services control (`systemctl` or `services`). So you need to execute scripts which are in Tomcat `bin` folder (e.g: `startup.sh` to run and `shutdown.sh` to stop). You also need to change rights on files.

##### Apache-Tomcat configuration

Tomcat configuration files are located in the `/home/tomcat/apache-tomcat&lt;version>/conf` folder.  
To use Tomcat manager page you need to define an admin user.  
To do that edit the `tomcat-users` file:
```bash
nano /home/tomcat/apache-tomcat<version>/conf/tomcat-users.xml
```
and add lines:
```bash
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="tomcat-admin" password="azerty" roles="manager, manager-gui"/>
```

To configure port, edit `server.xml`:
```bash
nano /home/tomcat/apache-tomcat<version>/conf/server.xml
```
and replace:

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
You have to allow `encoded slash` in `/home/tomcat/apache-tomcat&lt;version>/conf/catalina.properties`. If you have the line `org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=false`, change `false` value by `true`.  
If you don't have this line, add `org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true` at the end of file.

Start the service:
```bash
/home/tomcat/apache-tomcat<version>/bin/startup.sh
```

##### Rdf4j

Download archive zip file [rdf4j.org](http://rdf4j.org/download/) and extract it (replace `<version>` by the version downloaded):
```bash
unzip ~/Downloads/eclipse-rdf4j-<version>-sdk.zip -d ~/
```
You can already copy `.war` files to the Tomcat webapps folder:
```bash
cp ~/eclipse-rdf4j-<version>/war/* /home/tomcat/apache-tomcat<version>/webapps/
```

#### Apache2

##### Apache Installation

```bash
sudo apt-get update
sudo apt-get install apache2 libapache2-mod-php7.0
```

##### Apache Configuration

With this installation configuration files are in `/etc/apache2` folder.  
To change the port you need to edit the file `port.conf`:
```bash
sudo nano /etc/apache2/ports.conf
```
change line `LISTEN XX` to `LISTEN 80`.

Restart service apache2:

```bash
sudo systemctl restart apache2
```

#### Composer

Sometimes when installing Composer from the Ubuntu package, it does not run correctly. To avoid any problem, you should install Composer from the Composer installer file via the following command line (**Curl** must be already installed):
```bash
sudo curl -sS https://getcomposer.org/installer
sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Maybe you should create a symbolic link between the new version of composer in `/usr/bin` or use the complete command. e.g. php `/usr/local/bin/composer`.

Now install the plugin that you need to use Composer:
```bash
sudo composer global require "fxp/composer-asset-plugin:^1.2.0"
```

#### Git

Git is needed to download the OpenSILEX's Web Service and Web Application. Git is already installed on most Linux native installations, but if it is not your case, you can install it as follows:
```bash
sudo apt-get install git
```
Go to the [Using Git](github.md) section of this documentation to check how OpenSILEX developpers use Git.

#### Check install

Check the configuration of Apache2, Tomcat and PostgreSQL servers (nmap must be intalled):
```bash
sudo systemctl start apache2
sudo systemctl start postgresql
/home/tomcat/apache-tomcat<version>/bin/startup
nmap 127.0.0.1
```
The answer should be:
```
PORT     STATE SERVICE
80/tcp   open  http
5432/tcp open  postgresql
8080/tcp open  http-proxy
```
For information:
- `http` is your Apache2 server
- `postgresql` is your PostgreSQL server
- `http-proxy` is your Tomcat server

They are the three services that you need so if the previous command's result is correct, you can continue to the next section [Prerequisite Files](#files).

Otherwise you have two options:  
- remember the differences and ajust for the next steps
- return to the related section ([Tomcat](#apache-tomcat-configuration), [Apache2](#apache-configuration), [PostgreSQL](#postgresql-configuration))

**Note**

 If you didn't install the programs exactly like in this document, it is possible that configuration files aren't located exactly like us.

### Files

I recommand you to create a folder where you will download all the required files:
```bash
mkdir ~/OpenSILEX
```

#### Web service folder

Get source from GitHub, directly from the `phis-ws` development repository:
```bash
cd ~/OpenSILEX
git clone https://github.com/OpenSILEX/phis-ws.git
```
Preferably, get the source from the last release at [OpenSILEX-ws/releases](https://github.com/OpenSILEX/phis-ws/releases).

#### Web application folder

Get source from GitHub, directly from the OpenSILEX-webapp development repository:
```bash
cd ~/OpenSILEX
git clone https://github.com/OpenSILEX/phis-webapp.git
```
Preferably, get the source from the last release at [OpenSILEX-webapp/releases](https://github.com/OpenSILEX/OpenSILEX-webapp/releases).

#### Ontology files

Get the source from GitHub, directly from the `ontology-phis-oepo-field` development repository:
```bash
cd ~OpenSILEX
git clone https://github.com/OpenSILEX/ontology-phis-oepo-field
```
Preferably, get the source from the last release at [ontology-OpenSILEX-oepo-field/releases](https://github.com/OpenSILEX/ontology-phis-oepo-field/releases).

#### Database file

Download the database dump file [phis_st_dump.sql](phis_st_dump.sql).

## OpenSILEX Installation

### MongoDB database

You only create a connection to a collection.
Run MongoDB:
```bash
sudo mongod --config /etc/mongod.conf
```
Run robot3t:
```bash
~/robo3t/bin/robo3t
```
Create a connection:
![robo3t-connection1](img/robo3t-connexion1.png)
Configure your connection:
![robo3t-connection2](img/robo3t-connexion2.png)
Create your database:
right click on connection name -> `Create Database` -> enter a name (`mongodb_phis` in this document).

### Rdf4j Ontologies

Go to http://localhost:8080/. You are in Tomcat server home page.

Click on `manager app`, connect with your  Tomcat user (a default user is configured in the `home/tomcat/apache-tomcat<version>/tomcat-users.xml` configuration file).  


Search `rdf4j-workbench` in the list, if isn't running, click on `Start`)

Click on the `rdf4j-workbench` link.


Click `New repository` and complete as in the picture:
![rdf4j-nr1](img/rdf4j-nr1.png)
Click `Next` and check if is corresponds to this:
![rdf4j-nr2](img/rdf4j-nr2.png)
Click `Create`.  

You will do these steps many times:  

Now, Click `Add` in the `Modify` submenu.  

![rdf4j-add](img/rdf4j-add.png)

Click on the button next to `RDF Data File` in order to select a RDF Data File.


Selec the `oepo.owl` file got previously from GitHub in the repository `ontology-OpenSILEX-oepo-field`.

Fill the field `Base URI` with the value `http://www.phenome-fppn.fr/vocabulary/2017`.

In the `Data format` field, select `RDF/XML`.

Click `Upload`.

Add also a new context for the Ontology Annotation (with the `RDF Data File` `oa.rdf` downloadedable [here](http://www.w3.org/ns/oa.rdf) and with the `Base URI` value `http://www.w3.org/ns/oa`.

### PostgreSQL database

Connect to Postgre:
```bash
sudo -i -u postgres
```

#### Create the open_silex user


Start the SQL editor:
```bash
psql
```

Run the following commands:
```sql
CREATE USER open_silex;
ALTER ROLE open_silex WITH CREATEDB;
ALTER ROLE open_silex WITH SUPERUSER;
ALTER USER open_silex WITH ENCRYPTED PASSWORD 'azerty';
```

#### Create the database

```sql
CREATE DATABASE open_silex OWNER open_silex;
```

Exit the SQL connection:
```bash
\q
```

#### Create the PostGIS EXTENSION

Connect to the database with the `open_silex` user:

```bash
psql -U open_silex -h 127.0.0.1 -d open_silex
```
and enter open_silex's current password `azerty` when asked.

Finally run these commands to create the extension:
```SQL
CREATE EXTENSION postgis;
select postgis_full_version();
```

Exit the SQL editor:
```
\q
```

#### Initialise Database

Download the dump file to import [here](OpenSILEX_st_dump.sql) (make shure you download it in a folder where you are fully owner - like the `Downloads` folder -  because of PosgreSQL ownership issue when importing data).

Import data with (replace `<location>` by de the location of the downloaded dump file):
```bash
psql -U open_silex -h 127.0.0.1 open_silex < <location>/OpenSILEX_st_dump.sql
```

With specific access rights, you can get a dump from the demonstration version:
```bash
# from postres server
pg_dump -O -U OpenSILEX open_silex > OpenSILEX_st_dump.sql
# -O : --no-owner
# -s : only schema
# -h <IP> : postgres host
# -U <user> : user
```

If you need to generate a MD5 password, you can use:
```bash
 echo -n bonjour | md5sum
```

#### Initialise Users

To start using or try OpenSILEX, two users are created automatically:
* admin@OpenSILEX.fr/admin for administrative rights
* guest@OpenSILEX.fr/guest for restricted rights
See OpenSILEX user documentation for explanation and add other users.

### Web Service

To deploy a web service with Tomcat you need a war file.  
To generate a war file from a project the easiest solution is to use Netbeans.

#### Folders

Create directories for images and
```bash
mkdir -p /home/<user>/OpenSILEX2ws/documents/instance
  mkdir /var/www/html/images
  mkdir /var/www/html/layers
  chown -R [username]:[username] /var/www/html/images
  chown -R [username]:[username] /var/www/html/layers
  chown -R [username]:[username] /home/<user>/OpenSILEX2ws/documents/
  chmod -R 775 /var/www/html/images
  chmod -R 775 /var/www/html/layers
  chmod -R 775 /home/<user>/OpenSILEX2ws/documents/
```

#### Open project

Run netbeans:
```
~/netbeans/bin/netbeans
```
Netbeans frequently meets error when he starts. If you have an error please go to the [current error](#problems-with-netbeans) section.

When netbeans started, open OpenSILEX2ws project. He is located in /home/OpenSILEX/OpenSILEX-ws/.

If problems are detected in the project: click right on the project name -> resolve problems -> resolve.  
If problems can't be resolved like that please go to the [current error](#errors-with-the-web-service) section.

#### Configuration Files

You don't need to edit your configuration files specifically with netbeans, you can use a classical text editor (nano, vim, gedit...) to edit them.

Maven profiles are used to generate war file with different configurations

Three profiles exists by default:
- **dev** (default): Profile used for local developpement with default values
- **test**: Profile used for testing purpose with no values by default
- **prod**: Profile used for production with no values by default

Specific profiles configurations are defined in a **config.properties** file which is located in folder **OpenSILEX2-ws/src/main/<profile name>/**

Netbeans users: configuration files are located in **OpenSILEX2ws -> other sources -> src/main/profiles -> <profile name>**.

Profile could be used with the following command line (-P option):

```bash
mvn install -Ptest
```

With no -P option dev profile is used.

_Informations:  
If you use netbeans to deploy war file in tomcat server, default port is 8084 but in this document we choose to deploy ourselves war file so the port need to be tomcat service port (8080).  
The choice of deploy ourselves is justificated by the universality of the procedure. Netbeans is heavy and some pc can have difficulty to run netbeans and other softwares in same time.  
If you can use netbeans you have advantage to can modify files and deploy more quickly._

_Attention:
Every time you use localhost address you need use ip address 127.0.0.1 and not the name localhost_

Edit the file **config.properties** of the **dev** profile:
You have to adapt values between **< >** but if you are doing exactly like in this document, other values are good.
You need change port with the port choose for Tomcat, in our case 8080.

```properties
# MongoDB configuration
mongo.host=127.0.0.1
mongo.port=27017
mongo.db=<MongoDB database name, eg. open_silex>

# PostgreSQL configuration
pg.host=127.0.0.1
pg.port=5432
pg.db=<PostgreSQL database name, eg. open_silex>
pg.user=<PostgreSQL user name, eg. OpenSILEX>
pg.password=<PostgreSQL user password, eg. azerty>

# RDF4J Configuration
rdf.host=127.0.0.1
rdf.port=<8080>
rdf.path=<Rdf4j .war file name, eg. rdf4j-server>
rdf.infra=<Rdf4j infrastructure name, eg. open_silex>
rdf.repo=<Rdf4j repository name, eg. open_silex>

# Webservice configuration
ws.log.dir=/home/tomcat/OpenSILEX2ws/logs

ws.host=127.0.0.1
ws.port=<8080>
ws.target=OpenSILEX2ws
ws.baseUrl=rest

ws.doc.host=127.0.0.1
ws.doc.port=<8080>
ws.doc.name=OpenSILEX2ws

ws.updir.host=127.0.0.1
ws.updir.user=<Linux session name>
ws.updir.password=<Linux session password>
ws.updir.doc=/home/OpenSILEX2ws/documents/instance

ws.images.dir=/var/www/html/images
ws.images.url=http://127.0.0.1/images

ws.layers.dir=/var/www/html/layers
ws.layers.url=http://127.0.0.1/layers
```

#### Generate war file

When all configuration files are correctly change you can generate the war file.  
To do that, in netbeans:  
**click right on project -> build with depedencies**
Your war is generated in **~/OpenSILEX/OpenSILEX-ws/target**

#### Deploy war file

Copy the war archive in tomcat webapps folder:
```bash
cp /home/OpenSILEX/OpenSILEX-ws/target/OpenSILEX2ws.war /home/tomcat/apache-tomcat/webapps/OpenSILEX2ws.war
```

#### Check web service

Your webservice is directly deployed. You can check that:  
Go to http://127.0.0.1:8080/  

_It is necessary you don't use localhost._  
You are in Tomcat server home page, click on **manager app**, connect with Tomcat user.  
Search **OpenSILEX2ws** in the list, if isn't run click start, and click on the name **OpenSILEX2ws**.  
You are on your service web, if it correctly configurate you have 2 opperationnal link.  

_You can go directly with http://127.0.0.1:8080/OpenSILEX2ws __

To check you are correctly configurate your web service:
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

The web application deployment is did by apache2. You have to copy webapp folder in apache root folder in our case /var/www/html.
```
sudo cp -r ~/OpenSILEX/OpenSILEX-webapp /var/www/html
```
Change right on this folder:
```
sudo chown -R [username]:www-data /var/www/html/OpenSILEX-webapp
  sudo chmod 775 -R /var/www/html/OpenSILEX-webapp
```
*information:  
www-data is the default apache2 username. But in rare case it can be a different name, you can check that in /etc/apache2/envars file.*

#### Configuration

To deploy in localhost it isn't necessary to open webapp with netbeans , you only need adapt configuration files so you can use classical editor.  
Netbeans users:  
Open the webapp folder with netbeans, like a php project.

open project -> **/var/www/html/OpenSILEX-webapp** -> open  
Configuration files are in: *OpenSILEX-webapp* -> *sources files* -> *config*  
Other users:  
Configuration files are in: **/var/www/html/OpenSILEX-webapp/config**   

Edit:
  - *webservices.php*  
Adapt the last line with the correct URL in our case is:
**http://127.0.0.1:8080/OpenSILEX2ws/rest**

If you are all exactly doing like in this document, it's the only configuration file you need to change. But you can check other configuration files: compare paths and URL with information written in web services configuration files.

#### Composer

Got to your webapp folder and applicate **composer update**:
```
cd /var/www/html/OpenSILEX-webapp
  sudo composer update
```
It can be so longer, and perhaps you will need install some php-smth packages:  
```
sudo apt-get install php-smth1 php-smth2
```
*(adapt smth with name given by composer)*

While you don't obtain a successful issue, fix errors and rerun **composer update**.

Maybe you need to change some owner and rights properties of new files. So, you can do :
```
sudo chown -R [username]:www-data /var/www/html/OpenSILEX-webapp
  sudo chmod 775 -R /var/www/html/OpenSILEX-webapp
```

So now, normally you have a operationnal OpenSILEX application on your localhost.
Go to **http://127.0.0.1:80/OpenSILEX-webapp** and test with log in.

If you have problems search on **Current errors** section.

## Current errors

### Problems with netbeans

+ Exit without error message when he is starting  

Some ressources are not find ou not accessible.
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

Netbeans doesn't find jdk installation, to fix it check if you are indicate the correct jdk folder to netbeans. To do that edit file ~/netbeans-8.2/etc/netbeans.conf and adapt jdk path line 57.
If the error persists it can be your jdk installation wasn't did correctly, uninstall jdk and use [this procedure](#jdk) to reinstall.

### Problems with composer

If you are installed composer with apt from ubuntu packages, please uninstall composer (think to remove cache and configuration files in ~/.cache and /etc folders) and reinstall with [this porcedure](#composer).

If doesn't fix the problem please check [composer troubleshooting page](#https://getcomposer.org/doc/articles/troubleshooting.md).

### Errors with PostgreSQL

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
If it another problem you can try fix him with resolve button. But if the problem persists it probably comes from a modification in a project files you can try find her or close project and reopen or remove all OpenSILEX web service files and redownload.

+ Not ressources / 404 or other problems with web service

Recheck path and port in web service file services.properties. If all was do exactly like this:
```
[...]
logDirectory=/home/tomcat/OpenSILEX2ws/logs

[...]
host=127.0.0.1:8080
basePath=/OpenSILEX2ws/rest
[...]
webAppHost=127.0.0.1
webAppPort=8080
[...]
webAppApiDocsName=OpenSILEX2ws
[...]
webAppApiBasePath=/OpenSILEX2ws/resources

[...]
uploadFileServerPort=22
# Adresse de sauvegarde des donn\u00e9es
uploadFileServerIP=127.0.0.1
uploadFileServerUsername=[linux session username]
uploadFileServerPassword=[linux session password]
uploadFileServerDirectory=/home/<user>/OpenSILEX2ws/documents/instance
uploadImageServerDirectory=/var/www/html/images
layerFileServerDirectory=/var/www/html/layers
layerFileServerAddress=http://127.0.0.1/layers
[...]

```
+ Error with test brapiv1token

Your database is inaccessible or wrong.
Verify you PostgreSQL server with nmap or your favorite tool for port gestion.
If it isn't running, restart the service:
```
sudo systemctl restart postgresql
```
If the service running but you have a problem it comes from the configurations files, verify paths, URL and port in service.properties file and URL, port and database name in OpenSILEX_sql_config file.

If all your configurations files are good it can be a mistake in your database.

### Errors with the web application

+ No home page

Browser can't access to the page, it can come from right on the web application files in /var/www/html/OpenSILEX-webapp. Check rights with `ls -l` command line, and make change if something is wrong.  
You have to all files:  
owner: username (name of your session on the pc)  
group: www-data (or the name of you apache user)  
```
sudo chown -R [username]:www-data /var/html/OpenSILEX-webapp
```
rights: rwxrwxr-x  
```
sudo chmod -R 775 /var/html/OpenSILEX-webapp
```
+ Can't log in

It can be a configuration file of the web application (/var/www/html/OpenSILEX-webapp/config) or a configuration file of the web service or a problem with de postgresql database.
In your configurations file check URL and port.
With psql check if your database isn't wrong.

+ Githun token

If you get an error "GitHub API limit (60 calls/hr) is exhausted..." during composer insallation, you need to connect Github and get a Personal access tokens. See https://github.com/settings/tokens.

#### Other problems concerned webapp and web service

In lot of case problems come from configuration files verify every informations in these files.

When you modify a web service configuration you have to rebuild and redeploy war file.
Think to remove old version in tomcat webapp folder before copy your new version.
<!--stackedit_data:
eyJoaXN0b3J5IjpbLTYzNTc4MjA2NiwtMTcyMzM0Njc1OCwtMT
A5OTg1NTI4MiwtOTUyOTI4MTM4XX0=
-->
