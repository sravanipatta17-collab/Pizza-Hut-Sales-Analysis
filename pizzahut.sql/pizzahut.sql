use pizzahut;

# Total Orders Count
select count(order_id) as totalorders
from orders;

# Revenue Calculation 
SELECT sum(quantity * price) AS total_revenue
FROM order_details as od
JOIN pizzas as p ON od.pizza_id=p.pizza_id;

# Most Expensive Pizza
select max(price) from pizzas;

# Most Ordered Pizza Sale
select p.size,sum(od.quantity) as total_orders
from order_details as od join pizzas as p
on od.pizza_id=p.pizza_id
group by p.size
order by total_orders desc
limit 1;

# Top 5 Popular Pizzas
select pt.name as pizza_name,sum(od.quantity) as tot_quantity
from order_details as od  
join pizzas as p on  od.pizza_id=p.pizza_id
join pizza_types as pt on p.pizza_type_id=pt.pizza_type_id
group by pt.name
order by tot_quantity desc
limit 5;

# Pizza Quantity by Category
select pt.category,
       sum(od.quantity) as tq_ord
from pizzas as p join pizza_types as pt 
on p.pizza_type_id = pt.pizza_type_id
join order_details as od
on p.pizza_id=od.pizza_id
group by pt.category
order by tq_ord;

# Order Trends by Hour
select extract(hour from order_time) as order_hour, count(*) as total_order
from orders
group by order_hour
order by order_hour;

# Average Daily Pizza Orders
select * from pizzahut.orders;
select avg(daily_total) as avg_daily_pizzas
from (
      select o.order_date,sum(od.quantity) as daily_total
      from orders o
      join order_details od on o.order_id = od.order_id
      group by o.order_date
) as daily_orders;

# Top Pizza Types by Revenue
select 
       pt.name as pizza_type,
       sum(od.quantity * p.price) as total revenue
from order_details od
join pizzas p
     on od.pizza_id = p.pizza_id
join pizza_types pt
     on p.pizza_type_id = pt.pizza_type_id
group by pt.name
order by total_revenue desc
limit 3;