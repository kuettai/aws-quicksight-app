# Chapter 04 - Using Filter in Visual
Learning Outcome:
- Using custom fields with existing Visual
- Create Filter Parameter in Visual

## Prerequisite
1. Login to AWS console
2. Login to QuickSight console

## Topic 1 - Back to Visualize
1. Back to QuickSight homepage
1. Click on **My folders**, **demo001**, **People Overview analysis**

## Topic 2 - Create new visual using newly created custom fields
### Topic 2.1 - Create visual to understand No. of employee in each Age range
1. Click **+ Add** at the top left, **Add visual**
1. Under **Visual types**, click **Line chart**
1. Under **Fields list**, click **Custom-Age**
1. Click **Field wells** at the top
1. Drag **Custom-Age (Sum)** from **Value** to **X axis**

### Topic 2.2 - Create visual to understand No. of employee in each Salary Group
1. Click **+ Add** at the top left, **Add visual**
1. Under **Visual types**, click **Vertical bar chart**
1. Under **Fields list**, click **Custom-SalaryRange**

## Topic 3 - Add Filter to the visual
### Topic 3.1 - Visual to have capabilities to filter by Region
#### Topic 3.1.1 - Create Parameter for Region
1. At the left hand side of the menu, click **Parameters**
1. Click **Create one...**,
1. **Name**: *ParamRegion*
1. **Values**: *Multiple values*
1. Click **Create** button

#### Topic 3.1.2 - Add this Parameter as Control to Sheet
1. Beside **ParamRegion**, click on the **'v'**, **Add control**.
1. **Display name**: *Region*
1. **Values**: *Link to a data set field*
1. **Select a data set**: *People Overview*
1. **Select a column**: *Region*
1. Click on **Add** button

#### Topic 3.1.3 - Create Filter for Region
1. At the left hand side of the menu, click **Filter**
1. Click **Create one...**, then click **Region**
1. Click on **Region**
1. Under **Filter type**, choose **Custom filter**
1. Check on the checkbox for **Use parameters**
1. Click **Yes** when prompt about *Change the scope of this filter?*
1. **Select a parameter**, choose **ParamRegion**
1. Click **Apply** button

#### Topic 3.1.4 - Test the newly added control
1. Click on the **Region** dropdown in Sheet 1, change the values to see how each visualise being updated

### Topic 3.2 - Visual to have capabilities to filter by SalaryRange (Custom Field)
Repeat Topic 3.1.

Congratulations! You learnt to create Parameter, Control & Filter in QuickSight
