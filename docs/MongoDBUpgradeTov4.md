# Upgrade MongoDB from 3.4 to 4.0 and enable transactions features

If you don't have any previous installation of MongoDB, please follow this tutorial:
[Install MongoDB 4.0](MongoDBInstallv4)

## Dump your database

This command will create a dump folder in the current directory with all your data saved

```
mongodump --host localhost
```

## Upgrade MongoDB on Ubuntu or Debian

You can find install process for other Linux distribution on [Install on linux](https://docs.mongodb.com/manual/administration/install-on-linux/)

[MongoDB v4.0 Upgrade standalone](https://docs.mongodb.com/manual/release-notes/4.0-upgrade-standalone/)

### 1. Check if mongod service is running

```
sudo systemctl status mongod
```

```
● mongod.service - High-performance, schema-free document-oriented database
   Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
   Active: active (running) since Mon 2018-08-13 14:23:29 CEST; 3 months 27 days ago
     Docs: https://docs.mongodb.org/manual
 Main PID: 15294 (mongod)
    Tasks: 61
   CGroup: /system.slice/mongod.service
           └─15294 /usr/bin/mongod --config /etc/mongod.conf

août 13 14:23:29 template-debian-8 systemd[1]: Started High-performance, schema-free document-oriented database.
```

### 2. Stop mongod service

```
sudo systemctl stop mongod
```

### 3. Check if mongod service is well stopped

```
sudo systemctl status mongod
```

```
● mongod.service - High-performance, schema-free document-oriented database
   Loaded: loaded (/lib/systemd/system/mongod.service; disabled; vendor preset: enabled)
   Active: inactive (dead)
     Docs: https://docs.mongodb.org/manual

août 13 14:23:29 template-debian-8 systemd[1]: Started High-performance, schema-free document-oriented database.
déc. 10 11:26:10 template-debian-8 systemd[1]: Stopping High-performance, schema-free document-oriented database...
déc. 10 11:26:10 template-debian-8 systemd[1]: Stopped High-performance, schema-free document-oriented database.
```

### 4. Register MongoDB 4.0 public GPG Key

```
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv 9DA31620334BD75D9DCB49F368818C72E52529D4
```

### 5. Add MongoDB 4.0 repository to apt list files

This command line is specific to Debian 9, to get the right one for your distribution:

- For Ubuntu (14.04, 16.04 or 18.04), go to [Install on Ubuntu](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-ubuntu/)
- For Debian (8 "Jessie" or 9 "Stretch"), go to [Install on Debian](https://docs.mongodb.com/manual/tutorial/install-mongodb-on-debian/)

```
echo "deb http://repo.mongodb.org/apt/debian stretch/mongodb-org/4.0 main" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.0.list
```

Eventually, remove older list file for previous mongodb versions in folder
```
ls -lrt /etc/apt/sources.list.d/
```

### 6. Remove older version and database files

```
sudo apt-get purge mongodb-org*
sudo rm -rf /var/lib/mongodb
sudo mkdir /var/lib/mongodb/
sudo chown -R mongodb:mongodb /var/lib/mongodb/
```

### 7. Update apt and install new version

```
sudo apt-get update
sudo apt-get install mongodb-org
```

### 8. Restart MongoDB service

Restart

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
```

## Restore your database

In the folder where you previously execute mongodump, run the following command

```
mongorestore --host localhost
```

## Enable transaction features

This is achieved by creating a replica set
- [Transactions and replica sets](https://docs.mongodb.com/manual/core/transactions/#transactions-and-replica-sets)
- [Convert standalone to replica set](https://docs.mongodb.com/manual/tutorial/convert-standalone-to-replica-set/)

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


***

Go back to the parent page, the [OpenSILEX local installation documentation](./localInstallation.md#mongodb-and-robo-3t).
