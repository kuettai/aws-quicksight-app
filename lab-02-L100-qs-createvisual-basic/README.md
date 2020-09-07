# Chapter 02 - Create Visual using AWS sample data
Learning Outcome:
- Organize content under Dashboard
- Create Analyses

## Prerequisite
1. Login to AWS console
2. Login to QuickSight console

## Topic 1 - Create folder
1. Click **My folders** at the left hand side of the menu
1. Click **New Folder** button at the top right
1. **Name**: demo001
1. Click **Create** button

## Topic 2 - Create Analyses
1. Click **demo001** after successfully folder successfully created
1. Click **+ New** button at the top right, choose **Analysis**
1. You will be redirect to Datasets screen. We will use **People Overview** in this exercise.
1. Click on **People Overview**, then click **Create analysis**

## Topic 3 - Setup your Analysis
### Topic 3.1 - Create barchart for Gender per Job Family
1. Under **Fields list**, click **Gender**, then click **Job Family**
1. Under **Visual types**, select **Barchart**

### Topic 3.2 - Create Total Compensation by Job Family, and sort by Highest to Lowest
1. Click **+ Add** button at the top left, then click **Add visual**
1. Under **Fields List** (Left hand side), click **Monthly Compensation**
1. Under **Field wells** (Top), drag **Monthly Compesation** from **Y axis** to **Value**
1. Click on **Monthly Compesation**, click **Aggregate: Count**, then click **Sum**
1. Click on **Monthly Compesation**, click the second icon at **Sort by**
1. Under **Fields List** (Left hand side), click **Job Family**
1. Under **Fields List** (Left hand side), drag **Region** to **Group/Color** under **Field wells**

Congratulations on setting up your first Visual Analysis using QuickSight
