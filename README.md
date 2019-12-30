# Datawarehouse
Datawarehouse according to Kimball models. It is developed in SQL Server 2016 Developer.

## Installation
The source is [AdventureWorks2016CTP3](https://www.microsoft.com/en-us/download/details.aspx?id=49502) without modifications.
In the folder release there is a script to install all the implementations. By default it is installed in a database named Datewarehouse. 

## Implemented
In the dimension Customer it is applied the slowly Changing Dimension 2 in Region and Slowly Dimension 1 in the fields Store and EmailPromotion.
Dimension Date. Although the key recommended by Kimball is a smart integer (yyyymmdd), I have implemented it with a Date data type, because contains 3 bytes instead of 4 bytes and it should improve the performance of the queries.
Creation/deletion of partitions (more information in CubesMetadata folder)

## Folders
* Database

Source database backup to download

Script to create the database Datawarehouse with all the objects implemented in the data warehouse and load them (InstallDatawarehouse.sql).

* Source

The data is extracted from the source AdventureWorks2016CTP3. As long as there is only one souce and it's the same database as the source, and also to simplify the project, in this process can be performed light transformations. It is an schema in the database.

* ETL

Transformation get performed. It is an schema in the database. There is also the file LoadAllTablesFull.sql to perform a Full load of all the tables.

* Logging

Logs of the processes. It is an schema in the database.

* DWH

Tables of the Datawarehouse. It is an schema in the database.

* CubesMetadata
Objects to create/delete automatically partitions when there are multiple partitions in a Measure Group. To understand better how it works take a look at Test/CreateDeletePartitions.sql

* Test

Scripts used to test that the processes are implented properly.

