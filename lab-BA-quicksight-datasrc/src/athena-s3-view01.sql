create view vw_people_properdate as select
  tenure,
  date_parse(date, '%Y-%m-%d %H:%i:%s') as joinedDate,
  date_parse(DOB, '%Y-%m-%d %H:%i:%s') as dobFormatted,
  education,
  employeeId,
  employeeName,
  eventType,
  gender,
  isunique,
  jobFamily,
  jobLevel,
  monthlyCompensation,
  region
from people_overview_csv;
