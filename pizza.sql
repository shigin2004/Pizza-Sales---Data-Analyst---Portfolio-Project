select * from pizza_sales ;

- ### KPI'S

# 1) Total Revenue
select sum(total_price) as Total_Revenue from pizza_sales ;

# 2) Average Order value
select (sum(total_price)/count(distinct order_id)) as avg_order_value from pizza_sales;

# 3) Total Pizzas Sold
select sum(quantity) as Total_Pizzas_Sold from pizza_sales;

# 4) Total Orders
select count(distinct order_id) as Total_Orders from pizza_sales;

# 5) Average Pizza's Per Order
select cast(sum(quantity) / count(distinct order_id) as decimal(10,2)) as Avg_Pizza_per_Order from pizza_sales;

alter table pizza_sales
add new_order_date DATE;

set SQL_SAFE_UPDATES = 0;

UPDATE pizza_sales
set new_order_date = STR_TO_DATE(order_date , '%d-%m-%y');

# 6) Daily Trend For Total Orders
select dayname(dw,order_date) as order_day , count(distinct order_id) as Total_orders from pizza_sales
group by dayname(dw,order_date);

# 7) Hourly Trend for Total Orders
select HOUR(order_time) as order_hours,
       count(distinct order_id) as total_orders
       from pizza_sales
       group by HOUR(order_time)
       order by HOUR(order_time);
       
# 8) % of sales by pizza category
SELECT pizza_category, CAST(SUM(total_price) AS DECIMAL(10,2)) as total_revenue,
CAST(SUM(total_price) * 100 / (SELECT SUM(total_price) from pizza_sales) AS DECIMAL(10,2)) AS PCT
FROM pizza_sales
GROUP BY pizza_category;

# 9)% os sales by pizza size
select pizza_size,cast(sum(total_price) as decimal(10,2)) as Total_Revenue,
cast(sum(total_price)*100 / (select sum(total_price) from pizza_sales) as decimal(10,2)) as PCT 
from pizza_sales
group by pizza_size
order by PCT desc;

# 10) Total pizza sold by Category
select pizza_category , sum(quantity) as Total_Pizza_Sold
from pizza_sales 
group by pizza_category;

# 11) Top 5 pizza's by Revenue
select pizza_name , cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by sum(total_price) desc limit 5;

# 12) Bottom 5 pizza's by Revenue
select pizza_name , cast(sum(total_price) as decimal(10,2)) as Total_Revenue
from pizza_sales
group by pizza_name
order by sum(total_price) asc limit 5;




       










