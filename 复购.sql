#创建视图，有复购行为的用户，user_id与times
create view repurchasetimes as
select user_id, count(type) as times
from jdata_action
where type = 'pay'
group by user_id
having count(type) >= 2
drop view purchasetimes

#查找复购用户消费次数对应的人数
select times,count(times) as '人数'
from purchasetimes
group by times
order by times desc

#消费次数超过20的用户有多少
select count(times) as '人数'
from purchasetimes
where times > 20


#消费次数在10--20之间的用户有多少
select count(times) as '人数'
from purchasetimes
where times > 10 and times <= 20


#消费次数不多于10次的复购用户数
select count(times) as '人数'
from purchasetimes
where times >= 2 and times <= 10


#复购率
select((select count(user_id) from repurchasetimes)/
(select count(distinct user_id) from jdata_action where type = 'pay'))
as '复购率'



