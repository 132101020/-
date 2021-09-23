#创建视图，统计用户购买次数
create view purchasetimes as
select user_id, count(type) as times
from jdata_action
where type = 'pay'
group by user_id
select max(times) from purchasetimes


#统计购买次数对应的人数
select times,count(times) as '人数'
from purchasetimes
group by times
order by times 

#统计每日消费总次数
select date,sum(times) as '日消费总次数'
from purchasetimes
group by date

#统计每日uv
select date,count(distinct user_id) as '日uv'
from jdata_action
group by date

#统计每日的付费用户数
select date,count(distinct user_id) as '日付费用户数'
from jdata_action
where type = 'pay'
group by date


