# Chapter 04 - Import dataset from MySQL inside EC2
Learning Outcome:
- Create EXTERNAL TABLE in Athena referencing csv file in S3 bucket
- Create new dataset using Athena in QuickSight

Not Including:
- How to create EC2, refers: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/EC2_GetStarted.html
- How to create IAM Role with permission to S3 & link IAM Role to EC2, refers: https://docs.aws.amazon.com/IAM/latest/UserGuide/id_roles_use_switch-role-ec2.html

## Prerequisite
1. Login to AWS console
1. Login to QuickSight console
1. EC2 instance, running on **Amazon Linux 2** and **IAM Role with S3 access** on the EC2

## Topic 1 - Install MySQL/MariaDB Server on EC2
1. *Expecting you to login to EC2 already, if not, refers: https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html
1. In terminal as **ec2_user**, run the following commands: ``sudo su -`` to switch to root user
1. After that, execute the following scripts to install & setup mariadb:
``bash
yum update -y
yum install mariadb-server -y
systemctl start mariadb
mysql_secure_installation

## Upon prompting option
- set password for root users
- 'Y' for remaining options
``

1. Restart MariaDB to take effects
``bash
systemctl stop mariadb
systemctl enable mariadb
``

1. Login to MySQL using ROOT, to create user
``bash
mysql -u root -p

## After successfully login as root
CREATE USER 'qsuser'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON *.* TO 'qsuser'@'%';
quit;
``

1. Login as new user using password 'abc123', then create database
``sql
mysql -u qsuser -p

## After successfully login as qsuser
CREATE DATABASE quicksight;
USE quicksight;

## Create table
CREATE TABLE people_overview(
  tenure INT,
  joindate varchar(256),
  dob varchar(256),
  education varchar(256),
  employeeId varchar(256),
  employeeName varchar(256),
  eventType varchar(256),
  gender varchar(256),
  isunique varchar(256),
  jobFamily varchar(256),
  jobLevel varchar(256),
  monthlyCompensation decimal,
  notes varchar(256),
  region varchar(256));

## Import CSV data
LOAD DATA LOCAL INFILE '/root/quicksight-aws-people-overview.csv'
INTO TABLE people_overview
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

## Validate data
SELECT COUNT(*) from people_overview;

## Exit MySQL terminal
quit;
``

## Topic 2 - Download CSV file from S3 into EC2
1. *Note: Presumed that you have setup IAM Roles and attach to EC2, else refers to Prerequisite*
1. Run the following bash script: ``aws s3 cp s3://qs-demo001-<YOUR_NAME>-2020/quicksight-aws-people-overview.csv .``. Remember to replace the value \<YOUR_NAME\> to correct value
1. *Note: If you encounter permission error, fix your IAM Roles Policy and make sure it is attach to EC2*
1. *Note: If you encounter file/bucket not-exists error, make sure the bucket name and file name in the command in correct*
1. To validate the file is there: ``wc -l quick*``, it should displays **1957 quicksight-aws-people-overview.csv**





## Topic 2 - Create External Table in Athena
### Topic 2.1 - Configure Athena (First Timer only)
1. At AWS Console, under **Services**, go to **Athena**
1. Click **Get Started** button
1. Click **Settings** on the top right corner
1. Under **Query result location**, use the S3 Bucket Name created at Topic 1
1. Click **Save** button at bottom right corner

### Topic 2.2 - Create External Table
1. In the textarea under **New query 1**, copy the following SQL ``create DATABASE qsdemo001;`` and click **Run query** button
1. Open up *athena-s3-table.sql* downloaded, change the ``<BUCKET_NAME>>`` to the **bucket name** where csv file is located
1. Copy the text, replace the entire text in **New query 1**, and click **Run query** button
1. Replace the SQL with the following ``select * from people_overview_csv;`` and click **Run query** button. You should be able to see list of records at **Results** section. It is located below the **Run query** button

### Topic 2.3 - Create Views
1. *Note: The next step below is to create a view with proper datetime datatype; The datatype for both `date of birth` & `date` is in VARCHAR*
1. Copy the text in *athena-s3-view01.sql*, replace existing SQL in **New query 1**, and click **Run query** button
1. *Note: The next step below is to create another view to drop off unncessary fields, and populate 3 new fields, namely: `Age`, `genderShortcode` & `realTenure`*
1. Copy the text in *athena-s3-view02.sql*, replace existing SQL in **New query 1**, and click **Run query** button
1. To validate result, run the following query ``select * from vw_people;``, and click **Run query** button

## Topic 3 - QuickSight to load data from Athena
### Topic 3.1 - Grant permission for QuickSight to access S3 bucket
1. Back to QuickSight homepage
1. On the top right, click on your <userid>, then click **Manage QuickSight**
1. On the left, click on **Security & permissions**, then click **Add or remove** button
1. Under **Amazon Athena**, click on **Details**, click **Select S3 buckets** button
1. Check on the checkbox's of the S3 Bucket created in **Topic 1**, then click **Finish** button at the bottom right of the screen
1. Click **Update** button at the bottom right of the screen

### Topic 3.2 - Changing your QuickSight Region
1. *Note: QuickSight and Athena Database must be in the same region for QuickSight to detect it*
1. Click on the *Person* icon at top right corner, change QuickSight region (e.g. us-east-1) to your Athena's region (e.g. ap-southeast-1)
1. The introduction screen will appear. You may proceed with the introduction again or you may close the pop up windows

### Topic 3.3 - Add new dataset, source from Athena
1. Back to QuickSight homepage
1. Click on **Datasets**
1. Click on **New dataset**
1. Click on **Athena**
1. For **Data source name**, input *PeopleOverviewAthena*, Click **Validate connection** button. After validation completed, click on **Create data source** button
1. Database, choose **qsdemo001**
1. Tables, choose **vw_people**
1. Click **Edit/Preview data**
1. Perform reviews on table columns, and sample recordsets manually
1. Remember to **Save** the dataset by clicking on the **Save** button on top, else it will not reflect in your QuickSight

Congratulation on completing this session!
