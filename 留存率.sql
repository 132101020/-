#创建试图，用户行为时间与第一次行为时间
create view usedate as
select a.user_id,a.date,b.firstday
from
(select user_id,date from jdata_action
group by user_id,date) a
inner join 
(select user_id,min(date) as firstday 
from jdata_action
group by user_id) b
on a.user_id = b.user_id
order by a.user_id,a.date



#计算第一次使用日期与使用日期的间隔
create view diffdate as
select user_id,date,firstday,datediff(date,firstday) as diff_date
from usedate

select * from diffdate

#计算每天的留存数量
create view retention as
select firstday,
sum(case when diff_date = 0 then 1 else 0 end) as day0,
sum(case when diff_date = 1 then 1 else 0 end) as day1,
sum(case when diff_date = 2 then 1 else 0 end) as day2,
sum(case when diff_date = 3 then 1 else 0 end) as day3,
sum(case when diff_date = 4 then 1 else 0 end) as day4,
sum(case when diff_date = 5 then 1 else 0 end) as day5,
sum(case when diff_date = 6 then 1 else 0 end) as day6,
sum(case when diff_date = 7 then 1 else 0 end) as day7,
sum(case when diff_date = 8 then 1 else 0 end) as day8,
sum(case when diff_date = 9 then 1 else 0 end) as day9,
sum(case when diff_date = 10 then 1 else 0 end) as day10,
sum(case when diff_date = 11 then 1 else 0 end) as day11,
sum(case when diff_date = 12 then 1 else 0 end) as day12,
sum(case when diff_date = 13 then 1 else 0 end) as day13,
sum(case when diff_date = 14 then 1 else 0 end) as day14
from diffdate
group by firstday
order by firstday

#计算留存率
select firstday,
concat(round(day1*100/day0,1),'%') as day1,
concat(round(day3*100/day0,1),'%') as day3,
concat(round(day5*100/day0,1),'%') as day5,
concat(round(day7*100/day0,1),'%') as day7,
concat(round(day10*100/day0,1),'%') as day10
from retention
group by firstday
order by firstday

