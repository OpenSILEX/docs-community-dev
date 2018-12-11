# Install MongoDB 4.0 and enable transactions features

If you already have an installed version of MongoDB please follow this tutorial:
@see [V2.7 - Upgrade MongoDB from 3.4 to 4.0](MongoDBUpgradeTov4)

## Install MongoDB on Ubuntu or Debian

You can find install process for other Linux distribution on https://docs.mongodb.com/manual/administration/install-on-linux/

@see https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/

### 1. Register MongoDB 4.0 public GPG Key

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
```

### 2. Add MongoDB 4.0 repository to apt list files

This command line is specific to Debian 9, to get the right one for your distribution:

- For Ubuntu (14.04, 16.04 or 18.04), go to https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/
- For Debian (8 "Jessie" or 9 "Stretch"), go to https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/

```
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
```
### 3. Update apt and install new version

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

> 
```

## Enable transaction features

This is achieved by creating a replica set
@see https://docs.mongodb.com/manual/core/transactions/#transactions-and-replica-sets
@see https://docs.mongodb.com/manual/tutorial/convert-standalone-to-replica-set/

### 1. Edit your config file

Edit the configuration file /etc/mongod.conf and add the following config
You can choose any name to replace "opensilex"

```
replication:
  replSetName: "opensilex"
```

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

You can check the status of the replica set with the following command:

```
> rs.status()
```