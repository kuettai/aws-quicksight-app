# Chapter 01 - Import dataset through files storing in S3
Learning Outcome:
- Create EXTERNAL TABLE in Athena referencing csv file in S3 bucket
- Create new dataset using Athena in QuickSight

## Prerequisite
1. Login to AWS console
1. Login to QuickSight console
1. Completed **02-L200-qs-dataset-s3**
1. Download src/athena-s3-table.sql
1. Download src/athena-s3-view01.sql
1. Download src/athena-s3-view02.sql

## Topic 1 - Create new S3 bucket to store Athena Output
1. At AWS Console, under **Services**, go to **S3**
1. Click **+ Create bucket** button
1. Give a Bucket name, says **qs-demo001-[yourname]-athena-2020**
1. Region: *Use_the_region_you_are_in*
1. Click **Create** button at the bottom left of the screen

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
1. *The next step below is to create a view with proper datetime datatype; The datatype for both `date of birth` & `date` is in VARCHAR*
1. Copy the text in *athena-s3-view01.sql*, replace existing SQL in **New query 1**, and click **Run query** button
1. *The next step below is to create another view to drop off unncessary fields, and populate 3 new fields, namely: `Age`, `genderShortcode` & `realTenure`*
1. Copy the text in *athena-s3-view02.sql*, replace existing SQL in **New query 1**, and click **Run query** button
1. To validate result, run the following query ``select * from vw_people;``, and click **Run query** button

## Topic 3 - QuickSight to load data from Athena
### Topic 2.1 - Grant permission for QuickSight to access S3 bucket
1. Back to QuickSight homepage
1. On the top right, click on your <userid>, then click **Manage QuickSight**
1. On the left, click on **Security & permissions**, then click **Add or remove** button
1. Under **Amazon Athena**, click on **Details**, click **Select S3 buckets** button
1. Check on the checkbox's of the S3 Bucket created in **Topic 1.1**, then click **Finish** button at the bottom right of the screen
1. Click **Update** button at the bottom right of the screen

### Topic 2.2 - Configure S3 manifest json file
1. Make sure you download ../src/s3manifest.json
1. Open s3manifest.json with your favorite text editor
1. Change **<REGION>** to your region, e.g **ap-southeast-1**
1. Change **<BUCKET>** to the bucket name created in **Topic 1**, e.g **qs-demo001-quicksight-kuettai-2020**
1. Change **<FILENAME>** to the data file name, e.g **quicksight-aws-people-overview.csv**
1. The **URIs** should looks like this: ``https://s3-ap-southeast-1.amazonaws.com/qs-demo001-kuettailearn-2020/quicksight-aws-people-overview.csv``

### Topic 2.3 - Add new dataset, source from Athena
?? download manifest.json ??
1. Back to QuickSight homepage
1. Click on **My folders**, **demo001**
1. Click on **+ New**, then **Dataset**
1. Click on **S3**
1. For **Data source name**, input *PeopleOverviewS3*, Change **Upload a manifest file** from *URL* to *Upload*. Click on the *input box* and select the manifest.json file you configured in Topic 2.2
1. Click **Connect** (it takes around 5-20seconds), then **Edit/Preview data**
1. Remember to **Save** the dataset by clicking on the **Save** button on top, else it will not reflect in your QuickSight

Congratulation on completing this session
