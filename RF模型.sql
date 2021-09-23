#创建视图，最近购买时间
create view r as
select user_id,max(date) as recently_pay
from jdata_action
where type = 'pay'
group by user_id


#创建视图，对r值进行等级评分
create view r等级 as
select user_id,recently_pay,datediff('2018-04-14',recently_pay) as 最近一次消费时间间隔,
(case when datediff('2018-04-14',recently_pay) < 3 then 5
when datediff('2018-04-14',recently_pay) <= 5 then 4
when datediff('2018-04-14',recently_pay) <= 7 then 3
when datediff('2018-04-14',recently_pay) <= 10 then 2
else 1 end) as R
from r

#创建视图，购买次数
create view f as
select user_id,count(user_id) as count_pay
from jdata_action
where type = 'pay'
group by user_id




#创建视图，对f值进行等级评分
create view f等级 as
select user_id,count_pay,
(case when count_pay <= 1 then 1
when count_pay <= 2 then 2
when count_pay <= 3 then 3
when count_pay <= 4 then 4
else 5 end) as F
from f


select avg(F)  as avg_f from f等级

select avg(R)  as avg_r from r等级

create view rfm as
select a.*,b.count_pay,b.F,
(case when a.R > (select avg(R)  as avg_r from r等级) and b.F > (select avg(F)  as avg_f from f等级) then '高价值客户'
when a.R > (select avg(R)  as avg_r from r等级) and b.F < (select avg(F)  as avg_f from f等级) then '深耕客户'
when a.R < (select avg(R)  as avg_r from r等级) and b.F > (select avg(F)  as avg_f from f等级) then '唤回客户'
when a.R < (select avg(R)  as avg_r from r等级) and b.F < (select avg(F)  as avg_f from f等级) then '挽留客户' end ) 
as '用户分层'
from r等级 as a,f等级 as b
where a.user_id = b.user_id

select * from rfm


create view rfm汇总 as 
select a.*, b.f, b.f值, 
(case when a.r > 3.7794 and b.f>1.0601 then '高价值客户' 
when a.r < 3.7794 and b.f>1.0601 then '唤回客户' 
when a.r > 3.7794 and b.f<1.0601 then '深耕客户' 
when a.r < 3.7794 and b.f<1.0601 then '挽留客户' end) as 客户分类 
from r等级划分 as a, f等级划分 as b where a.user_id = b.user_id
