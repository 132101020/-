#pv-pay
select count(distinct b.user_id) as pay,count(distinct a.user_id) as pv
from 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pv') a
left join
(select distinct user_id ,sku_id,action_time from jdata_action where type = 'pay'
and user_id not in (select distinct user_id from jdata_action
										where type = 'cart')
and user_id not in (select distinct user_id from jdata_action
										where type = 'fav')
) b
on a.user_id = b.user_id
and a.sku_id = b.sku_id
and a.action_time < b.action_time

#pv-cart-pay
select count(distinct a.user_id) as pv,count(distinct b.user_id) as pv_cart,
count(distinct c.user_id) as pv_cart_pay
from 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pv') a
left join
(select distinct user_id ,sku_id,action_time from jdata_action where type = 'cart'
and user_id not in (select distinct user_id from jdata_action
										where type = 'fav')
) b
on a.user_id = b.user_id
and a.sku_id = b.sku_id
and a.action_time <= b.action_time
left join 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pay') c
on b.user_id = c.user_id
and b.sku_id = c.sku_id
and b.action_time <= c.action_time

#pv-fav-pay
select count(distinct a.user_id) as pv,count(distinct b.user_id) as pv_fav,
count(distinct c.user_id) as pv_fav_pay
from 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pv') a
left join
(select distinct user_id ,sku_id,action_time from jdata_action where type = 'fav'
and user_id not in (select distinct user_id from jdata_action 
										where type = 'cart')
) b
on a.user_id = b.user_id
and a.sku_id = b.sku_id
and a.action_time <= b.action_time
left join 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pay') c
on b.user_id = c.user_id
and b.sku_id = c.sku_id
and b.action_time <= c.action_time

#pv-fav-cart-pay
select count(distinct a.user_id) as pv,count(distinct b.user_id) as pv_fav,
count(distinct c.user_id) as pv_fav_cart,count(distinct d.user_id) as pv_fav_cart_pay
from 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pv') a
left join
(select distinct user_id ,sku_id,action_time from jdata_action where type = 'fav') b
on a.user_id = b.user_id
and a.sku_id = b.sku_id
and a.action_time <= b.action_time
left join 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'cart') c
on b.user_id = c.user_id
and b.sku_id = c.sku_id
and b.action_time <= c.action_time
left join 
(select distinct user_id,sku_id, action_time from jdata_action where type = 'pay') d
on c.user_id = d.user_id
and c.sku_id = d.sku_id
and c.action_time <= d.action_time

