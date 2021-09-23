#总访问量
select count(*) as pv
from action
where type = 'pv'；

#总访客数
select count(distinct user_id) as uv
from action
where type = 'pv';

#付费用户数
select count(distinct user_id) as user_pay
from action
where type = 'pay';

#付费用户访问量
select type,count(*) as pv_pay
from action
where user_id in(select distinct user_id 
									from action
									where type = 'pay')
and type = 'pv';

#跳失率
select(
select count(*)
from(select user_id
from action
group by user_id
having count(type) = 1) a )/ 
(select count(distinct user_id) as uv from action) 
as exit_rate



									