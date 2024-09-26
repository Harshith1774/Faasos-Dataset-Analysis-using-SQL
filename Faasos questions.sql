-- EXPLORATORY DATA ANALYSIS ON FAASOS DATASET USING MY-SQL

-- maximum number of rolls delivered in a single order

select customer_id, count(customer_id) as number_orders from
(
	select customer_id, a.order_id, cancellation from customer_orders a join driver_order b on a.order_id=b.order_id
) as joined
where joined.cancellation=0
group by customer_id
order by number_orders desc
limit 1;

-- No or orders that had some changes

update customer_orders set not_include_items= case
when trim(not_include_items)= '' or trim(not_include_items)= 'NaN' then null
else not_include_items
end;

update customer_orders set extra_items_included= case
when trim(not_include_items)= '' or trim(extra_items_included)= 'NaN' then null
else extra_items_included
end;

commit;

select count(order_id) as No_order_changes from customer_orders where not_include_items is not null or extra_items_included is not null;

-- No of orders for ech customer that had changes

select customer_id,count(not_include_items) as inclusions, count(extra_items_included) as exclusions 
from customer_orders
where not_include_items is not null or extra_items_included is not null
group by customer_id;

-- How many delivered rolls had inclusions or exclusions

select customer_id,count(not_include_items) as inclusions, count(extra_items_included) as exclusions 
from customer_orders a join driver_order b
on a.order_id=b.order_id and cancellation= 0
where not_include_items is not null or extra_items_included is not null
group by customer_id;

-- Which hour of the day were most orders placed

select hour_buckets, count(a.order_id) as number_of_orders from(
select *,concat(hour(order_date),'-',hour(order_date)+1)as hour_buckets from customer_orders) a
group by hour_buckets
order by number_of_orders desc, hour_buckets asc
limit 3;

-- which days had the highest number of orders

select dayname(order_date) as daynames, count(*) as dayname_count from customer_orders group by daynames;

-- Average duration of the order delivery

update driver_order set duration= replace(duration,'minutes','');
update driver_order set duration= replace(duration,'mins','');
update driver_order set duration= replace(duration,'minute','');
commit;
alter table driver_order modify column duration INT; 
select concat(round(avg(duration),2),'  ','mins') as avg_delivery_time from driver_order;

-- Avg time taken to pickup order after the order was placed

select TIMESTAMPDIFF(MINUTE, CAST(order_date AS DATETIME), CAST(pickup_time AS DATETIME))
from customer_orders a join driver_order b
on a.order_id=b.order_id
where order_date is not null or pickup_time is not null;

-- avg distance travelled 

select concat(round(avg(a.distance),2),' ','km') as avg_distance from
(select cast(replace(distance, 'km','') as float) as distance from driver_order) a;

-- avg distance travelled for each of the customer
update driver_order set distance=cast(replace(distance, 'km','') as float);
commit;

select customer_id, avg(distance) as avg_distance from customer_orders a join driver_order b
on a.order_id=b.order_id
where b.cancellation =0
group by customer_id;

-- difference between shortest and longest delivery times

select max(duration)-min(duration) from driver_order;

-- average speed for each delivery

select order_id,concat(round(distance/(duration/60),2),' ','km/hr') as avg_speed 
from driver_order;

-- average speed for each driver

select driver_id,round(sum(distance)/sum(duration/60),2) as avg_speed 
from driver_order
group by driver_id;

-- successful delivery percentage of each driver

select driver_id,sum(case when cancellation=0 then 1 else 0 end)*100/ count(driver_id) as success_rate 
from driver_order 
group by driver_id;