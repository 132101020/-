#用户活跃时间分布

select date,count(type),count(distinct user_id)
from jdata_action
where type = 'pv'
group by date 
order by date;

select hour,count(type),count(distinct user_id)
from jdata_action
where type = 'pv'
group by hour 
order by hour

select weekday,count(type),count(distinct user_id)
from jdata_action 
where type = 'pv'
group by weekday 
order by weekday



