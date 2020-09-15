CREATE EXTERNAL TABLE `people_overview_csv`(
  `tenure` bigint,
  `date` string,
  `dob` string,
  `education` string,
  `employeeId` string,
  `employeeName` string,
  `eventType` string,
  `gender` string,
  `isunique` boolean,
  `jobFamily` string,
  `jobLevel` string,
  `monthlyCompensation` double,
  `notes` string,
  `region` string)
ROW FORMAT SERDE 'org.apache.hadoop.hive.serde2.OpenCSVSerde'
  WITH SERDEPROPERTIES ("separatorChar" = ",")
LOCATION
  's3://<BUCKET_NAME>/'
TBLPROPERTIES (
  'classification'='csv',
  'columnsOrdered'='true',
  'compressionType'='none',
  'skip.header.line.count'='1',
  'typeOfData'='file')
