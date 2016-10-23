-- KPIs - key performance indicators for a company

/* =================
Database Schema

purchases

id		int
user_id		int
price		real
refunded_at	text
created_at	text

gameplays

id		int
user_id		int
created_at	text
platform	text

================= */

-- purchases
select *
from purchases
order by id
limit 10;

-- gameplays
select *
from gameplays
order by id
limit 10;

-- Daily Revenue
select date(created_at), round( sum(price), 2 ) as daily_rev
from purchases
where refunded_at is null
group by 1
order by 1;

-- DAU - Daily Active Users
select date(created_at), platform, count(distinct user_id) as dau
from gameplays
group by 1, 2
order by 1, 2;

-- Daily ARPPU - Daily Average Revenue Per Purchasing User
select date(created_at), round(sum(price) / count(distinct user_id), 2) as arppu
from purchases
where refunded_at is	 null
group by 1
order by 1;

