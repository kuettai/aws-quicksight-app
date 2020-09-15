create view vw_people as select
  -- tenure,
  date_diff('year', joinedDate, now()) as realTenure,
  date_diff('year', dobFormatted, now()) as age,
  education,
  employeeId,
  -- employeeName,
  eventType,
  case when gender = 'Female' then 'F'
    when gender = 'Male' then 'M'
    else 'U' end as genderShortcode,
  -- isunique,
  jobFamily,
  jobLevel,
  monthlyCompensation,
  region
from vw_people_properdate;
