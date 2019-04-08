# Install MongoDB 4.0 and enable transactions features

If you already have an installed version of MongoDB please follow this tutorial:
[Upgrade MongoDB from 3.4 to 4.0](MongoDBUpgradeTov4)

## Install MongoDB on Ubuntu or Debian

You can find install process for other Linux distribution on [Install on linux](https://docs.mongodb.com/manual/administration/install-on-linux/).

All of the command lines presented here come from the official documentation [Install MongoDB Community Edition on Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#install-mongodb-community-edition-on-ubuntu).

### 1. Register MongoDB 4.0 public GPG Key

Import the public key used by the package management system as described in the [MongoDB official documentation](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/#import-the-public-key-used-by-the-package-management-system):

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
```

### 2. Add MongoDB 4.0 repository to apt list files

This command line is specific to Debian 9, to get the right one for your distribution:

- For Ubuntu (14.04, 16.04 or 18.04), go to [Install on Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
- For Debian (8 "Jessie" or 9 "Stretch"), go to [Install on Debian](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/)

```
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
```
### 3. Update apt and install new MongoDB version

```
sudo apt-get update
sudo apt-get install mongodb-org
```

### 4. Start MongoDB service

```
sudo systemctl enable mongod
sudo systemctl start mongod
```

Try to connect

```
mongo
```

The following text should appear:

```
MongoDB shell version v4.0.4
connecting to: mongodb://127.0.0.1:27017
Implicit session: session { "id" : UUID("bca506e0-589d-482d-a8f2-6da60e56b80c") }
MongoDB server version: 4.0.4
Server has startup warnings:
2018-12-10T12:28:02.828+0100 I STORAGE  [initandlisten]
2018-12-10T12:28:02.828+0100 I STORAGE  [initandlisten] ** WARNING: Using the XFS filesystem is strongly recommended with the WiredTiger storage engine
2018-12-10T12:28:02.828+0100 I STORAGE  [initandlisten] **          See http://dochub.mongodb.org/core/prodnotes-filesystem
2018-12-10T12:28:03.489+0100 I CONTROL  [initandlisten]
2018-12-10T12:28:03.489+0100 I CONTROL  [initandlisten] ** WARNING: Access control is not enabled for the database.
2018-12-10T12:28:03.489+0100 I CONTROL  [initandlisten] **          Read and write access to data and configuration is unrestricted.
2018-12-10T12:28:03.489+0100 I CONTROL  [initandlisten]
---
Enable MongoDB's free cloud-based monitoring service, which will then receive and display
metrics about your deployment (disk utilization, CPU, operation statistics, etc).

The monitoring data will be available on a MongoDB website with a unique URL accessible to you
and anyone you share the URL with. MongoDB may use this information to make product
improvements and to suggest MongoDB products and deployment options to you.

To enable free monitoring, run the following command: db.enableFreeMonitoring()
To permanently disable this reminder, run the following command: db.disableFreeMonitoring()
---
```

You can quit mongo by entering `exit`.

## Enable transaction features

This is achieved by creating a replica set
- [Transactions and replica sets](https://docs.mongodb.com/manual/core/transactions/#transactions-and-replica-sets)
- [Convert standalone to replica set](https://docs.mongodb.com/manual/tutorial/convert-standalone-to-replica-set/)

### 1. Edit your config file

Edit the configuration file /etc/mongod.conf and add the following config
You can choose any name to replace "opensilex" in the /etc/mongod.conf file:

```
replication:
  replSetName: "opensilex"
```

To change the configuration file, you should access it with super-user privilege, using the text editor of you choice, for instance:

```
sudo gedit /etc/mongod.conf
```

Do not forget to uncomment the line displaying `replication:` by removing the `#` at the start of the line.

### 2. Restart MongoDB service

```
sudo systemctl restart mongod
```

### 3. Connect to mongo and initialize replica set

```
mongo
```

```
> rs.initiate()
```

Here, the name you gave to your replica set (e.g. opensilex) by changing the /etc/mongod.conf file should be displayed.

You can check the status of the replica set with the following command:

```
> rs.status()
```


## Enable authentication

### 1. create superadmin user :

```javascript
use admin
db.createUser(
  {
    user: "useradmin",
    pwd: "pwd",
    roles: [ { role: "userAdminAnyDatabase", db: "admin" } ]
  }
)
```

### 2. activate authentication:

In the config file `/etc/mongod.conf`, add the following config :
```properties
security:
    authorization: "disabled"
```
If you want autorize the remote connection (mongodb server is installed remotely) you must comment the following lines :
```properties
# network interfaces
net:
 port: 27017
 bindIp: 127.0.0.1
```

3. Optional - you can test authenfication:
```javascript
use admin
db.auth("superadmin", "mydatabase")
```

4. Create an admin account for the opensilex database:

The role readWrite allow to :

- create collection
- create, modify, read and delete data
- create index

If the mongo server hosts several opensilex instances you can create one user per database.

```javascript
db.createUser(
 {
   user: "opensilex",
   pwd: "azerty",
   roles: [ { role: "readWrite", db: "opensilex" } ]
 }
)

```
Check access :

```
mongo -u "opensilex" -p "azerty" --authenticationDatabase "mydatabase" "mydatabase"
```

***

Go back to the parent page, the [OpenSILEX local installation documentation](./localInstallation.md#mongodb-and-robo-3t).
