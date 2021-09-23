create view cate as
select p.sku_id,cate,
sum(case when a.type = 'pv' then 1 else 0 end) as '浏览量',
sum(case when a.type = 'pay' then 1 else 0 end) as '购买量',
concat(round(sum(case when a.type = 'pay' then 1 else 0 end)*100/
sum(case when a.type = 'pv' then 1 else 0 end),1),'%') as '购买转化率'
from jdata_product p join jdata_action a
on p.sku_id = a.sku_id
group by cate

drop view cate

#浏览量前10的类目
select * from cate
order by 浏览量 desc
limit 10

#购买量前10的类目
select * from cate
order by 购买量 desc
limit 10


create view sku as
select p.sku_id,p.cate,
sum(case when a.type = 'pv' then 1 else 0 end) as '浏览量',
sum(case when a.type = 'pay' then 1 else 0 end) as '购买量',
concat(round(sum(case when a.type = 'pay' then 1 else 0 end)*100/
sum(case when a.type = 'pv' then 1 else 0 end),1),'%') as '购买转化率'
from jdata_product p join jdata_action a
on p.sku_id = a.sku_id
group by p.cate,p.sku_id

drop view sku
select * from sku
order by 浏览量 desc
limit 10

select * from sku
order by 购买量 desc
limit 10

select c.cate,s.sku_id
from cate c join sku s
on c.sku_id = s.sku_id
order by s.浏览量
limit 10
