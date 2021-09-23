#创建视图，用户第一次浏览的时间
create view firstaction as
select user_id,min(date) as firstday 
from jdata_action
group by user_id

#统计每日新增的用户数
select firstday,count(distinct user_id)
from firstaction 
group by firstday;


select date,count(*)
from jdata_action 
where user_id in
(select f.user_id from firstaction f join jdata_action a
on f.user_id = a.user_id) 
group by date;



