#用户购买时间分布

select date,count(type),count(distinct user_id)
from jdata_action
where type = 'pay'
group by date 
order by date

select hour,count(type),count(distinct user_id)
from jdata_action 
where type = 'pay'
group by hour 
order by hour

select weekday,count(type),count(distinct user_id)
from jdata_action
where type = 'pay'
group by weekday 
order by weekday