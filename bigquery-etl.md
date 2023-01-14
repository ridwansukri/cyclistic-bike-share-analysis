#  ETL Processing

At this stage, we will create an ETL process from scratch, starting from creating VM Instances and Storage Buckets until the data is ready for use.

This is ETL structure that we will use:
![ETL Process](https://archive.org/download/etl-process/etl-process.png)


## Create Buckets
First, we need to create a Bucket from the Cloud Storage which will collect all the files from the VM Instance. We call this bucket *bike-dataset* with single region *us-east1 (South Carolina)*
![Bucket Storage](https://github.com/ridwansukri/cyclistic-bike-share-analysis/blob/main/images/1.png)

## Create VM Instance
Next, we create a VM instance with the name *vm-bucket-gcsfuse* with *us-east1* region *us-east1-b* zone. For machine configuration, we choose the E2 series,
Debian 10 image type with 20GB of storage size. Don't forget to change *Access Scopes* to *Allow full access to all cloud APIs*.
Click *Create* botton on the bottom to complete the VM Instance creation process.
![VM Instance](https://github.com/ridwansukri/cyclistic-bike-share-analysis/blob/main/images/2.png)
![VM Instance](https://github.com/ridwansukri/cyclistic-bike-share-analysis/blob/main/images/3.png)

## Connect to Remote Server via SSH Browser
We remote to the Linux Server using SSH-in-Browser which is on the VM Instance menu. After logging in to SSH-in-browser, use this command line to downloads and installs the updates for each outdated package and dependency on Debian system
```
sudo apt-get update
```
![update](https://github.com/ridwansukri/cyclistic-bike-share-analysis/blob/main/images/4.png "update debian")


Install wget2 with this command

```
sudo apt-get install wget2 -y
```
 ![install-wget2](https://github.com/ridwansukri/cyclistic-bike-share-analysis/blob/main/images/5.png "Install wget2")























```
CREATE TABLE `bike_dataset.joined_dataset` AS(
SELECT * FROM `bike_dataset.202*`
);
```

```
CREATE TABLE `bike_dataset.bike_trip` AS (
    SELECT a.ride_id,
           a.rideable_type,
           a.started_at,
           a.ended_at,
           a.start_station_name,
           a.start_station_id,
           a.end_station_name,
           a.end_station_id,
           a.start_lat,
           a.start_lng,
           a.end_lat,
           a.end_lng,
           a.member_casual,
        TIMESTAMP_DIFF(a.ended_at, a.started_at, SECOND) AS trip_duration,
        EXTRACT(YEAR FROM a.started_at) AS YEAR,
        EXTRACT(MONTH FROM a.started_at) AS MO,
        EXTRACT(DAY FROM a.started_at) AS DY,
        EXTRACT(HOUR FROM a.started_at) AS HR,
        EXTRACT(DAYOFWEEK FROM a.started_at) AS day_start,
    FROM `bike_dataset.joined_dataset` AS a
    ORDER BY started_at DESC
);
```
