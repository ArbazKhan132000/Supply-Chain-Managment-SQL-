###   SCM PERFORMANCE METRICS

# 1) Find total number of order lines.


SELECT count(order_id) AS `Total Numbers Order Lines`
FROM fact_order_lines;


# 2) Find total number of orders.


SELECT count(distinct(order_id)) AS `Total Numbers of Order`
FROM fact_order_lines;


# 3) Write a SQL Query to calculate the Volume Fill Rate (VOFR %) with respect to city and present the quantity in 'Million',


SELECT City,
       CONCAT(Round((SUM(order_qty)/1000000),2),' ','M') AS `Ordered Quantity`,
	   CONCAT(ROUND((SUM(delivery_qty)/1000000),2),' ','M') AS `Delivered Quantity`,
	   ROUND((SUM(delivery_qty)/SUM(order_qty))*100,2) AS `VOFR %`
FROM fact_order_lines AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `VOFR %`;


# 4) Write a SQL Query to calculate the On Time Delivery % with respect to city.


SELECT City,
	   SUM(on_time) AS `On Time Delivery`,
	   (SUM(on_time)/count(Order_id))*100 AS `On Time Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `On Time Delivery %`;


# 5) Write a SQL Query to calculate the in Full Delivery  with respect to city.


select * from fact_orders_aggregate;
SELECT City,
       SUM(in_full) AS `In Full Delivery`,
	   (SUM(in_full)/count(Order_id))*100 AS `In Full Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `In Full Delivery %`;


# 6) Write a SQL Query to calculate the On Time In Full Delivery  with respect to city.


SELECT City,
       SUM(otif) AS `OTIF Delivery`,
	   (SUM(otif)/count(order_id))*100 AS `OTIF Delivery %`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `OTIF Delivery %`;


# 7) Write an SQL Query to compare the In full,On time deliveries and On time in full deliveries and sort them in descending order of VOFR with respect to city. 

SELECT City,
       (SUM(on_time)/count(Order_id))*100 AS `On Time Delivery %` ,
	   (SUM(in_full)/count(Order_id))*100 AS `In Full Delivery %`,
	   (SUM(otif)/count(order_id))*100 AS `OTIF Delivery %`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `OTIF Delivery %` Desc;



