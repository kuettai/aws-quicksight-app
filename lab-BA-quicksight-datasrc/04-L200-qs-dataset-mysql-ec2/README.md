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
1. In terminal as **ec2_user**, run the following commands: ```sudo su -``` to switch to root user
### Topic 1.1 Download csv file from S3 to EC2
```bash
cd ~
aws s3 cp s3://<BUCKET_NAME>//quicksight-aws-people-overview.csv .
```

### Topic 1.2
1. After that, execute the following scripts to install & setup mariadb:
```bash
yum update -y
amazon-linux-extras install -y lamp-mariadb10.2-php7.2 php7.2
yum install mariadb-server -y
systemctl start mariadb
mysql_secure_installation

## Upon prompting option
- set password for root users
- 'Y' for remaining options
```

1. Restart MariaDB to take effects
```bash
systemctl stop mariadb
systemctl enable mariadb
```

1. Login to MySQL using ROOT, to create user
```bash
mysql -u root -p

## After successfully login as root
CREATE USER 'qsuser'@'%' IDENTIFIED BY 'abc123';
GRANT ALL PRIVILEGES ON *.* TO 'qsuser'@'%';
quit;
```

1. Login as new user using password 'abc123', then create database
```sql
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
```

## Topic 2 - Attach Security Group to EC2 & QuickSight
### Topic 2.1 creates security groups
1. At AWS Console, under **Services**, go to **EC2**
1. Find **Security Groups** located on the left hand side of the menu (might need to scroll down), click
1. Click **Create security group** button
1. Put in the following information:
    1. Security group name: **QuickSightSG**
    1. Description: **Security Group for QuickSight**
    1. Scroll down, click **Create security group**
    1. **Important** After that, COPY down the Security group ID. We need it in **Topic 2.3**
1. Back to **Security Groups**, we need to create another Security Group
1. Put in the following information:
    1. Security group name: **EC2MySQLQuickSightSG**
    1. Description: **Security Group for QuickSight to access MySQL on EC2**
    1. Inbound rules -> Add rule:
    1. *Type*=**MYSQL/Aurora**,
    1. *Source*=QuickSightSG, then click on item appeared
    1. Scroll down, click **Create security group**
1. Back to **Security Groups**, we need to edit the first Security Groups to add Inbound Rules that accept all TCP connection from **EC2MySQLQuickSightSG**
1. Check **QuickSightSG**, click **Actions** -> **Edit inbound rules**
1. Inbound rules -> Add rule
    1. *Type*=**All TCP**,
    1. *Source*=EC2MySQL, then click on item appeared
    1. Scroll down, click **Create security group**


### Topic 2.2 Attach Security Group on EC2
1. At AWS Console, under **Services**, go to **EC2**
1. Find **Instances** located on the left hand side of the menu, click it
1. Identify the EC2 instance that has MySQL installed, click on the **checkbox** beside it
1. Under **Actions** -> **Networking** -> **Change Security Groups**
1. Check on **EC2MySQLQuickSightSG**, then click **Assign Security Groups** button

### Topic 2.3 Attach Security Group on QuickSight
1. Back to QuickSight homepage
1. *Note: Make sure your QuickSight is in the correct region as  your EC2*
1. Navigate to Top Right of QuickSight and click the *person* icon, it will shows your current region. Change the region if it is not where your EC2 located.
1. Click on same *person* icon, then click **Manage QuickSight**
1. Go to **Manage VPC connections**, click **Add VPC connection**
1. Put in the following information:
    1. VPC connection name: **EC2MySQL**
    1. VPC ID: **Pick the only one appear**
    1. Subnet ID: **Pick any**
    1. Security group ID: **Copy from Topic 2.1, and paste it here**
    1. Click **Create** button

## Topic 3 - Create Dataset using MySQL connection
1. Back to QuickSight homepage
1. Click on **Datasets**
1. Click on **New dataset** at top right of the screen
1. Click **MySQL**
1. Put in the following information:
    1. Data source name: **PeopleOverviewMySQL**
    1. Connection type: **EC2MySQL**
    1. Database server: **PRIVATE_IP_OF_EC2_INSTANCE**
    1. Port: **3306**
    1. Database name: **quicksight**
    1. Username: **qsuser**
    1. Password: **abc123**
    1. Enable SSL: **Uncheck**
1. Click **Validate connection**
1. Click **Create data source**
1. Select **people_overview**
1. Click **Edit/Preview data**
1. Perform reviews on table columns, and sample recordsets manually
1. Remember to **Save** the dataset by clicking on the **Save** button on top, else it will not reflect in your QuickSight

Congratulation on completing this session!
