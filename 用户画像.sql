#创建用户信息视图
create view user_info as
select user_id,age,user_lv_cd,city_level,
case sex
when '0' then '男'
when '1' then '女'
when '2' then '保密'
end sex 
from jdata_user

select p.user_id,p.times,u.age,u.sex,u.user_lv_cd,u.city_level
from purchasetimes p left join user_info u
on p.user_id = u.user_id
order by p.times desc
limit 200
