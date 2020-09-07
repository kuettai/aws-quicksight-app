# Chapter 03 - Manage datasets
Learning Outcome:
- Visualize Dataset
- Create new meaningful fields from original field

## Prerequisite
1. Login to AWS console
2. Login to QuickSight console

## Topic 1 - Visualize Dataset
Go back to QuickSight homepage by clicking on the QuickSight icon located at the top left of the screen.
1. Click **Datasets**
1. Click **People Overview**, then click **Edit data set**
1. Look at the **table** at the bottom right of the screen

## Topic 2 - Create Custom Fields
### Topic 2.1 - Create Age from Date field
1. Click **Add calculated field** button
1. Click **Add name**, type **Custom-Age**, press **Enter**
1. Copy this ``dateDiff({Date of Birth}, now(), 'YYYY')`` and put in the blank space below the **name**
1. Click **Save** button at the top right of screen

### Topic 2.2 - Create income group from Monthly Compensation
1. Click **Add calculated field** button
1. Click **Add name**, type **Custom-SalaryRange**, press **Enter**
1. Copy this ``ifelse({Monthly Compensation} > 10000, '1. High', {Monthly Compensation} > 7000, '2. Average', '3. Low')`` and put in the blank space below the **name**
1. Click **Save** button at the top right of screen

### Topic 2.3 - Verify & Save dataset
1. Look at the dataset at bottom right of screen, scroll to the most right to see the 2 newly added **Calculated fields**, *Custom-Age* & *Custom-SalaryRange*
1. Click **Save** at top-center of the screen

Congratulations on setting up your first Visual Analysis using QuickSight
