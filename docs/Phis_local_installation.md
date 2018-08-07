# Phis Deployment

1. [Prerequisite](#prerequisite)  
  + [Software](#software)  
      - [Mongodb + robo3t](#mongodb-robo3t)
      - [Postgresql + postgis](#postgresql-postgis)
      - [Netbeans + jdk](#netbeans-jdk)
      - [Php](#php)
      - [Apache-tomcat + rdf4j](#apache-tomcat-rdf4j)
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
This document explain you how to deploy PHIS on your personnal computer.  
In this document commands lines are for Ubuntu 16.04, but for the majority of them, they are compatible with all Debian distribution which have the package manager Aptitude.

## Prerequisite
### Software
#### Mongodb + robo3t
##### Mongodb
All the information you need to install mongodb correctly is [here](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition/).

Now you have a Mongodb service.
You can change path to database in the /etc/mongod.conf file. But your location need to exist before starting mongodb service and you have to attribute correct rights on this folder:
```
    chown -R mongodb:mongodb <path mongo db>
```
In /etc/mongod.conf file, you should add line
```
  fork: true
```
after
```
  # how the process runs
  processManagement:*
```
(In classical case newline should be line 29)  
This line is not an obligation, in default mode mongodb run as fork is define true but I prefer write to remove doubt.

Every time you change mongod.conf file, you need restart mongod service.
```
  sudo systemctl restart mongod
```
In this document, we use default folder /var/lib/mongod.  
To run mongodb, use following command line:
```
  sudo mongod --config /etc/mongod.conf
```

##### Robo3t

Download [sources files](https://robomongo.org/download).
Extract:
```
  tar -xvf ~/Downloads/robo3t[...].tar.gz ~
```
Now to run robo3t you do:
```
  ~/robo3t/bin/robo3t
```

#### Postgresql + postgis
##### Postgresql Installation
Open a shell and tape:
```
 sudo apt-get update
 sudo apt-get install postgresql
 sudo apt-get install postgresql-9.5-postgis-2.2
```
##### Postgresql configuration
Configuration files are in the /etc/postgresql/9.5/main folder.  
To change the port edit the file postgresql.conf:
```
  nano /etc/postgresql/9.5/main/postgresql.conf
```
and in the CONNECTION AND AUTHENTICATION section change **port = XXXX** by **port = 5432**.
Restart service:
```
  sudo systemctl restart postgresql
```

#### Netbeans + jdk
##### jdk
In first install jdk as you want but you need to keep in mind its location.  
If jdk is already installed you can go to the next section, [Netbeans](#netbeans).

Download the jdk 8 sources (e.g. tar.gz archive) [here](http://www.oracle.com/technetwork/java/javase/downloads/index.html).  
Create a jdk folder.  
For example:

```
  mkdir ~/jdk
```

Extract the archive in this folder:
```
  tar -xvf ~/Downloads/jdk-X.X.X_linux-x64_bin.tar.gz ~/jdk/
```
##### Netbeans

Download the full version [here](https://netbeans.org/downloads/start.html?platform=linux&lang=en&option=all).  
Run the script:

```
  sh ~/Downloads/netbeans-X.X-linux.sh
```
Follow the installation steps.

Check you will install PHP and glassfish/JEE module.

Choose your installation folder for Netbeans (for us is ~/netbeans) and indicate the jdk installation folder. In our case it is ~/jdk.

#### PHP

```
  sudo apt-get update
  sudo apt-get install php php-mbstring php-dm
```

#### Apache-Tomcat + rdf4j
##### Apache-Tomcat installation

To have a better control on the installation of tomcat you will install tomcat from sources files (e.g. tar.gz archive).  

You can download tomcat9.0 archive  [here](https://tomcat.apache.org/download-90.cgi).

Create a folder installation for Tomcat. To simplify what follows you should to create a tomcat folder in /home:

```
  mkdir /home/tomcat
```

and extract archive in this folder:
```
  tar -xvf ~/Downloads/apache-tomcat.tar.gz
```

With this procedure, tomcat is not recognized by ubuntu services control (systemctl or services). So to use them, you need to execute scripts which are in tomcat bin folder (ex: startup.sh to run and shutdown.sh to stop).

##### Apache-Tomcat configuration
The tomcat configuration files are located in the /home/tomcat/apache-tomcat/conf folder.  
To use tomcat manager page you need to define an admin user.  
To do that edit the tomcat-users.xml file:
```
  nano /home/tomcat/apache-tomcat/conf/tomcat-users.xml
```
and add lines:
```
<role rolename="manager"/>
<role rolename="manager-gui"/>
<user username="tomcat-admin" password="azerty" roles="manager, manager-gui"/>
```

To configure port edit server.xml:
```
  nano /home/tomcat/apache-tomcat/conf/server.xml
```
and change:

```
<Connector port="XXXX" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
   <!-- A "Connector" using the shared thread pool-->
   <!--
   <Connector executor="tomcatThreadPool"
              port="XXXX" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
   -->
```

to:
```
<Connector port="8080" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
   <!-- A "Connector" using the shared thread pool-->
   <!--
   <Connector executor="tomcatThreadPool"
              port="8080" protocol="HTTP/1.1"
              connectionTimeout="20000"
              redirectPort="8443" />
   -->
```
You have to allow encoded slash in the /home/tomcat/apache-tomcat/conf/catalina.properties. If you have the line "org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=false", change false value by true.  
If you don't have this line add "org.apache.tomcat.util.buf.UDecoder.ALLOW_ENCODED_SLASH=true" at the end of file.

Restart the service:
```
  /home/tomcat/apache-tomcat/bin/shutdown.sh
  /home/tomcat/apache-tomcat/bin/startup.sh
```

##### Rdf4j

Download archive zip file [here](http://rdf4j.org/download/).
Extract, for example:
```
  unzip ~/Downloads/eclipse-rdf4j-x.x.x-sdk.zip -d ~/
```
You can already copy .war files to the tomcat webapps folder:
```
  cp ~/eclipse-rdf4j-x.x.x/war/* /home/tomcat/apache-tomcat/webapps/
```

#### Apache2
##### Apache Installation
```
  sudo apt-get update
  sudo apt-get install apache2 libapache2-mod-php7.0
```
##### Apache Configuration
With this installation configuration files are in /etc/apache2 folder.  
To change the port you need to edit the file port.conf:
```
  nano /etc/apche2/ports.conf
```
change line **LISTEN xx** to **LISTEN 80**.

Restart service apache2:

```
  sudo systemctl restart apache2
```
#### Composer
Sometimes when you install composer from ubuntu package, composer does not run correctly. To avoid problems, you shall install composer from the composer installer file, via the following command line:

```
  curl -sS https://getcomposer.org/installer | sudo php -- --install-dir=/usr/local/bin --filename=composer
```

Install now the plugin that you need to use composer.

```
  composer global require "fxp/composer-asset-plugin:^1.2.0"
```
#### Git
You need git to download phis web service and web application.  
Git is already installed on ubuntu 16 default install, but if is not you can install them:
```
  sudo apt-get install git
```
To learn to used git, you should read [this](github.md).

#### Check install

For a good start you shall check  the configuration of apache2, tomcat and postgresql servers.

To do a quickly check tape following commands lines:
```
  sudo systemctl start apache2
  sudo systemctl start postgresql
  /home/tomcat/apache-tomcat/bin/startup
  nmap 127.0.0.1
```
If nmap is not installed on your PC, you do not install it because it is only used for checking ports.

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
- http is your apache2 server
- postgresql is your postgresql server
- http-proxy is your tomcat server


They are the three services that you need. So if they are like previously (80 -> http, 5432 -> postgresql and 8080 -> http-proxy), you can continue to the next section [Prerequisite Files](#files).
But if you are one or plus which are different you have two options:  
- remember the differences and adapt yourself for the next. You can continue too.
- Please return to the concern program section ([tomcat](#apache-tomcat-configuration), [apache2](#apache-configuration),[postgresql](#postgresql-configuration))

N.B.: If you didn't install programs exactly like in this document, it is possible that configurations files aren't located exactly like us.

### Files
I recommand you to create a folder where you will download all needing files.
```
  mkdir ~/Phis
  cd ~/Phis
```

#### Web service folder
```
  git clone https://github.com/OpenSILEX/phis-ws.git
```

#### Web application folder
```
  git clone https://github.com/OpenSILEX/phis-webapp.git
```

#### Database and ontologies
Download [this archive]().
Extract
```
  unzip ~/Downloads/db_ontologies.zip -d ~/Phis/
```

## Phis Installation
### Mongodb database

You only create a connection to a collection.
Run mongodb:
```
  sudo mongod --config /etc/mongod.conf
```
Run robot3t:
```
  ~/robo3t/bin/robo3t
```
Create a connexion:
![robo3t-connexion1](img/robo3t-connexion1.png)
Configure your connexion:
![robo3t-connexion2](img/robo3t-connexion2.png)
Create your database:
clic right on connection name -> create a database -> enter a name (in this document it will be "diaphen")
Now, you can close robo3t.

### Rdf4j ontologies

Go to http://localhost:8080/
You are in tomcat server home page, clic on **manager app**, connect with tomcat user.  
Search **rdf4j-workbench** in the list, if isn't run clic start, and clic on the name **rdf4j-workbench**.  
Clic **New repository** and complete as in the picture:
![rdf4j-nr1](img/rdf4j-nr1.png)
Clic **next**, check if all is as on this second picture:
![rdf4j-nr2](img/rdf4j-nr2.png)
Clic **create**.  

You will do these steps three times with the three .owl files:  
Now, clic **Add** in *Modify* menu.  
![rdf4j-add](img/rdf4j-add.png)
Clic **Parcourir...** selection one .owl file downloading previously in db_ontologies folder.  
Erase URI with: *http://www.phenome-fppn.fr/vocabulary/2017*  
and clic on context chan. Normally, he automaticaly changes.  
In **data format** select RDF/XML.  
Clic **upload**  

### Postgresql database
#### Creating phis users
```
  sudo -i -u postgres
  psql
  CREATE USER phis;
  ALTER ROLE phis WITH CREATEDB;
  ALTER ROLE phis WITH SUPERUSER;
  ALTER USER phis WITH ENCRYPTED 'azerty';
  \q #leave psql
  exit #disconnect postgre
```

#### Creating Database
```
  sudo -i -u postgre
  psql
  CREATE DATABASE diaphen OWNER phis;
  \q
  exit
  psql -U phis diaphen #connection like phis user on the dipahen database
  CREATE EXTENSION postgis;
  select postgis_full_version();
  \q
```

#### Initialising Database
```
  psql -U phis diaphen < ~/phis/phis_fiel_dump
```
### Web service

To deploy a webservice with tomcat you need a war file.  
To generate a war file until a project the easiest solution is used netbeans.

#### Folders
```
  mkdir -p /home/phis2ws/documents/instance
  mkdir /var/www/html/images
  mkdir /var/www/html/layers
  chown -R [username]:[username] /var/www/html/images
  chown -R [username]:[username] /var/www/html/layers
  chown -R [username]:[username] /home/phis2ws/documents/
  chmod -R 775 /var/www/html/images
  chmod -R 775 /var/www/html/layers
  chmod -R 775 /home/phis2ws/documents/
```
#### Open project
Run netbeans:
```
  ~/netbeans/bin/netbeans
```
Netbeans frequently meets error when he starts. If you have an error please go to the [current error](#problems-with-netbeans) section.

When netbeans started, open phis2ws project. He is located in /home/Phis/phis-ws/.

If problems are detected in the project: clic right on the project name -> resolve problems -> resolve.  
If problems can't be resolved like that please go to the [current error](#errors-with-the-web-service) section.

#### Configuration Files

This section isn't necessary doing with netbeans. If netbeans running slowly on your pc you can used a classical text editor (nano, vim, gedit...) to edit configuration files.

Netbeans users: configuration files are located in phis2ws -> other sources -> src/main/resources -> default package.

Other users: configuration files are in ~/Phis/phis-ws/phis2ws/src/main/resouces

_Informations:  
If you use netbeans to deploy war file in tomcat server, default port is 8084 but in this document we choose to deploy ourselves war file so the port need to be tomcat service port (8080).  
The choice of deploy ourselves is justificated by the universality of the procedure. Netbeans is heavy and some pc can have difficulty to run netbeans and other softwares in same time.  
If you can use netbeans you have advantage to can modify files and deploy more quickly._

_Attention:
Every time you use localhost address you need use ip address 127.0.0.1 and not the name localhost_

Edit these files:
  - *services.properties*  
You have to adapt paths but if you are doing exactly like in this document, default values are good.  
You need change port with the port choose for Tomcat, in our case 8080.
You have to adapt lines 63 to 69:
* uploadFileServerIP=127.0.0.1
* uploadFileServerUsername=[linux session name]
* uploadFileServerPassword=[linux session password]
* uploadFileServerDirectory=/home/phis2ws/documents/instance
* uploadImageServerDirectory=/var/www/html/images
* layerFileServerDirectory=/var/www/html/layers
* layerFileServerAddress=http://127.0.0.1/layers  


  - *phis_sql_config.properties*
Adapt second line:  
url = jdb:postgresql://127.0.0.1:5432/diaphen
* 5432: your postgresql service ports  
* diaphen: database name
* username=phis
* password=azerty  


  - *mogodb_nosql_config.properties*  
Like previously, you must adapt port, URL, and database.  
url=mongodb://127.0.0.1:27017
db=diaphen  
* 27017: your mongodb service port
* diaphen: name of your mongodb database, create with robo3t


  - *sesame_rdf.config*  
sesameServer=http://127.0.0.1:8080/rdf4j-server/  
platform=diaphen  
repositoryID=diaphen  
* 8080: tomcat port
* red4j-server: name of .war file deployed after rdf4j download
* diaphen: name of your repository create with rdf4j web service.

#### Generate war file

When all configuration files are correctly change you can generate the war file.  
To do that, in netbeans:  
*clic right on project -> build with depedencies*  
Your war is generating in *~/Phis/phis-ws/target*

#### Deploy war file

Rename and copy the war archive in tomcat webapps folder:
```
  cp /home/Phis/phis-ws/target/phis2ws-v0.1.war /home/tomcat/apache-tomcat/webapps/phis2ws.war
```
#### Check web service

Your webservice is directly deployed. You can check that:  
Go to http://127.0.0.1:8080/  
_It is necessary you don't use localhost._  
You are in tomcat server home page, clic on **manager app**, connect with tomcat user.  
Search **phis2ws** in the list, if isn't run clic start, and clic on the name **phis2ws**.  
You are on your service web, if it correctly configurate you have 2 opperationnal link.  
_You can go directly with http://127.0.0.1:8080/phis2ws_

To check you are correctly configurate your web service:
Go to **Documentation link**, try **brapiv1token**:
post -> clic on example -> try it out  
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
  cp -r ~/Phis/phis-webapp /var/www/html
```
Change right on this folder:
```
  chown -R [username]:www-data /var/www/html/phis-webapp
  chmod 775 -R /var/www/html/phis-webapp
```
*information:  
www-data is the default apache2 username. But in rare case it can be a different name, you can check that in /etc/apache2/envars file.*

#### Configuration
To deploy in localhost it isn't necessary to open webapp with netbeans , you only need adapt configuration files so you can use classical editor.  
Netbeans users:  
Open the webapp folder with netbeans, like a php project.  
open project -> /var/www/html/phis-webapp -> open  
Configuration files are in: phis-webapp -> sources files -> config  
Other users:  
Configuration files are in: /var/www/html/phis-webapp/config   

Edit:
  - *webservices.php*  
Adapt the last line with the correct URL in our case is:
http://www.127.0.0.1:8080/phis2ws/rest  

If you are all exactly doing like in this document, it's the only configuration file you need to change. But you can check other configuration files: compare paths and URL with information written in web services configuration files.

#### Composer
Got to your webapp folder and applicate **composer update**:
```
  cd /var/www/html/phis-webapp
  composer update
```
It can be so longer, and perhaps you will need install some php-smth packages:  
```
  sudo apt-get install php-smth1 php-smth2
```
*(adapt smth with name given by composer)*

While you don't obtain a successful issue, fix errors and rerun **composer update**.

So now, normally you have a operationnal phis application on your localhost.
Go to http://127.0.0.1:80/phis-webapp and test with log in.

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
chown -R [username]:[username] ~/.netbeans
```
Netbeans need also regular user can read and write all files of the folder. To fix it:
```
chmod -R ug+rw ~/.netbeans
```

+ Errors concerned jdk/jre:

Netbeans doesn't find jdk installation, to fix it check if you are indicate the correct jdk folder to netbeans. To do that edit file ~/netbeans-8.2/etc/netbeans.conf and adapt jdk path line 57.
If the error persists it can be your jdk installation wasn't did correctly, uninstall jdk and use [this procedure](#jdk) to reinstall.

### Problems with composer

If you are installed composer with apt from ubuntu packages, please uninstall composer (think to remove cache and configuration files in ~/.cache and /etc folders) and reinstall with [this porcedure](#composer).

If doesn't fix the problem please check [composer troubleshooting page](#https://getcomposer.org/doc/articles/troubleshooting.md).

### Errors with postgresql

+ FATAL: authentification peer:  

Edit file /var/log/postgresql-9.5-main.log and change line 90:
```
local all all peer
```
by
```
local all all md5
```
and restart service:
```
sudo systemctl restart Postgresql
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
Clic right on project name -> resolve problems
If it detects plugins problems I recommand you to fix them yourself with tool menu -> plugins.
If it another problem you can try fix him with resolve button. But if the problem persists it probably comes from a modification in a project files you can try find her or close project and reopen or remove all phis web service files and redownload.

+ Not ressources / 404 or other problems with web service

Recheck path and port in web service file services.properties. If all was do exactly like thi:
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
uploadFileServerDirectory=/home/phis2ws/documents/instance
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
If the service running but you have a problem it comes from the configurations files, verify paths, URL and port in service.properties file and URL, port and database name in phis_sql_config file.

If all your configurations files are good it can be a mistake in your database.

### Errors with the web application

+ No home page

Browser can't access to the page, it can come from right on the web application files in /var/www/html/phis-webapp. Check rights with ls -l command line, and make change if something is wrong.  
You have to all files:  
owner: username (name of your session on the pc)  
group: www-data (or the name of you apache user)  
```
  chown -R [username]:www-data /var/html/phis-webapp
```
rights: rwxrwxr-x  
```
  chmod -R 775 /var/html/phis-webapp
```
+ Can't log in

It can be a configuration file of the web application (/var/www/html/phis-webapp/config) or a configuration file of the web service or a problem with de postgresql database.
In your configurations file check URL and port.
With psql check if your database isn't wrong.

#### Other problems concerned webapp and web service

In lot of case problems come from configuration files verify every informations in these files.

When you modify a web service configuration you have to rebuild and redeploy war file.
Think to remove old version in tomcat webapp folder before copy your new version.
