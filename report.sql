--1
Select a.account_id, a.company_name, o.date_opened, round(sysdate - o.date_opened) as Duration
from account_info a 
inner join opportunity o
on a.account_id = o.account_id
where sysdate - o.date_opened < 30
order by Duration desc;

--2
SELECT AE_ID, USER_NAME AS ACCOUNT_EXECUTIVE, Territory
  FROM ACCOUNT_EXECUTIVE
 WHERE AE_ID = ANY
       (SELECT MEETING_ID 
          FROM MEETING
         WHERE MEETING_TYPE = 'Discovery Call')
;

--3
select  a.territory, count(m.meeting_id) as Meetings_Booked
from sales_representative a
left join
meeting  m
on a.sdr_id = m.sdr_id
group by a.territory
order by Meetings_Booked desc
;

--4
select
A.account_id,A.Company_Name,trim(O.Opportunity_ID) as "Opportunity_ID",
case when to_char(floor(months_between(sysdate,O.date_opened))) > 2 
then 'need to close' 
else 'opening' 
end as "status"
from account_info A
inner join Opportunity O
on A.Account_ID = O.Account_ID
where A.Company_Name = '&Company_Name';

--5
with territory as (
select s.territory, t.task_type,
case when floor(months_between(t.date_completed,t.date_scheduled))>6 then 'Disqualified'
     when floor(months_between(t.date_completed,t.date_scheduled)) between 2 and 6 then 'recycled'
     else 'Prospecting' 
end as Evaluation
from sales_representative s
join task t 
on s.sdr_id = t.sdr_id
where to_char(t.date_completed,'yyyy') in ('2022'))
select * from 
(select count(*) as "Florida's recycled " from territory 
where evaluation = 'recycled' and territory = 'Florida'),
(select count(*) as "California's recycled " from territory 
where evaluation = 'recycled' and territory = 'California'),
(select count(*) as "Florida's Disqualified " from territory 
where evaluation = 'Disqualified' and territory = 'Florida'),
(select count(*) as "California's Disqualified " from territory 
where evaluation = 'Disqualified' and territory = 'California'),
(select count(*) as "Florida's Prospecting " from territory 
where evaluation = 'Prospecting' and territory = 'Florida'),
(select count(*) as "California's Prospecting " from territory 
where evaluation = 'Prospecting' and territory = 'California')
;


with territory as (
select s.territory,
case when floor(months_between(t.date_completed,t.date_scheduled))>6 then 'Disqualified'
     when floor(months_between(t.date_completed,t.date_scheduled)) between 2 and 6 then 'recycled'
     else 'Prospecting' 
end as Evaluation
from sales_representative s
join task t 
on s.sdr_id = t.sdr_id
where to_char(t.date_completed,'yyyy') in ('2021'))
select * from 
(select count(*) as "Florida's recycled " from territory 
where evaluation = 'recycled' and territory = 'Florida'),
(select count(*) as "California's recycled " from territory 
where evaluation = 'recycled' and territory = 'California'),
(select count(*) as "Florida's Disqualified " from territory 
where evaluation = 'Disqualified' and territory = 'Florida'),
(select count(*) as "California's Disqualified " from territory 
where evaluation = 'Disqualified' and territory = 'California'),
(select count(*) as "Florida's Prospecting " from territory 
where evaluation = 'Prospecting' and territory = 'Florida'),
(select count(*) as "California's Prospecting " from territory 
where evaluation = 'Prospecting' and territory = 'California')
;



