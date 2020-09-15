# Chapter 02 - Import dataset through files storing in S3
Learning Outcome:
- Upload file to AWS S3 bucket
- Create new dataset using file storing in S3 bucket

## Prerequisite
1. Login to AWS console
1. Login to QuickSight console
1. Have download the data file from ../src/quicksight-aws-people-overview.csv
1. Download S3 manifest from ../src/s3manifest.json

## Topic 1 - Upload file to S3 bucket
### Topic 1.1 - Create S3 Bucket
1. At AWS Console, under **Services**, go to **S3**
1. Click **+ Create bucket** button
1. Give a Bucket name, says **qs-demo001-[yourname]-2020**
1. Region: *Use_the_region_you_are_in*
1. Click **Create** button at the bottom left of the screen

### Topic 1.2 - Upload csv file
1. Click on the *name* of the newly Created bucket
1. In next screen, click on **Upload**, **Add files**, select the "csv" file you downloaded mentioned in **Prerequisite**
1. Click **Upload** at the bottom left of the screen
1. Wait until the upload has completed

## Topic 2 - Quicksight to load data from S3
### Topic 2.1 - Grant permission for QuickSight to access S3 bucket
1. Back to QuickSight homepage
1. On the top right, click on your <userid>, then click **Manage QuickSight**
1. On the left, click on **Security & permissions**, then click **Add or remove** button
1. Under **Amazon S3**, click on **Details**, click **Select S3 buckets** button
1. Check on the checkbox's of the S3 Bucket created in **Topic 1.1**, then click **Finish** button at the bottom right of the screen
1. Click **Update** button at the bottom right of the screen

### Topic 2.2 - Configure S3 manifest json file
1. Make sure you download ../src/s3manifest.json
1. Open s3manifest.json with your favorite text editor
1. Change **<REGION>** to your region, e.g **ap-southeast-1**
1. Change **<BUCKET>** to the bucket name created in **Topic 1.1**, e.g **qs-demo001-kuettai-2020**
1. Change **<FILENAME>** to the data file name, e.g **quicksight-aws-people-overview.csv**
1. The **URIs** should looks like this: ``https://s3-ap-southeast-1.amazonaws.com/qs-demo001-kuettailearn-2020/quicksight-aws-people-overview.csv``

### Topic 2.3 - Add new dataset, source from S3
?? download manifest.json ??
1. Back to QuickSight homepage
1. Click on **My folders**, **demo001**
1. Click on **+ New**, then **Dataset**
1. Click on **S3**
1. For **Data source name**, input *PeopleOverviewS3*, Change **Upload a manifest file** from *URL* to *Upload*. Click on the *input box* and select the manifest.json file you configured in Topic 2.2
1. Click **Connect** (it takes around 5-20seconds), then **Edit/Preview data**
1. Remember to **Save** the dataset by clicking on the **Save** button on top, else it will not reflect in your QuickSight

Congratulation on completing this session
