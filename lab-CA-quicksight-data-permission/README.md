[WIP]
Not covers:
- QuickSight Group (this only applicable to Active Directory)

Keywords:
- QuickSight Row Level Security (RLS) to restrict access [Applied as Original Dataset, not Analysis, not Dashboard]
- Readers
- Create Dashboard

Session covers:
- Create different readers with different roles
- Use CSV files as RLS dataset
- Use Database's table as RLS dataset


====
[Chapter 01]
- Create Reader
- Publish Dashboard
- Upload rls01.csv as RLS dataset
- Configure PeopleOverviewDataset with RLS using rls01.csv, use "ALLOW"
- Login as NONAPACUSER to view Dashboard (should see only EMEA / US data, shows also filter)
- Configure PeopleOverviewDataset, to use "DENY" this time
- Login as NONAPACUSER to view Dashboard (should see only APAC, shows also filter)

====
[Chapter 02]
