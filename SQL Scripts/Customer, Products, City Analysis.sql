###   CUSTOMER ORDER, PRODUCTS, CITY ANALYSIS

# 1) Write an SQL query to find number of order by customers.

SELECT customer_name AS `Customer Name`,
	   count(order_id) as `Num. of Orders`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.customer_id=C.customer_id
GROUP BY customer_name
ORDER BY `Num. of Orders` DESC;

## 2) Write an SQL query to find most in demand product.

SELECT category AS `Product Category`,
	   O.product_id AS `Product ID`,
       P.product_name AS `Product Name`,
	   SUM(order_qty)  AS `Total Orders`
FROM fact_order_lines AS O
INNER JOIN dim_products AS P
	ON O.product_id=p.product_id
GROUP BY category,
         O.product_id,
		 P.product_name
ORDER BY `Total Orders` DESC ;


# 3) Write an SQL query and find how cities are performing.

SELECT CITY,
	   AVG(on_time) AS `Avg. On Time Deliveries`,
	   AVG(in_full) AS `Avg. In Full Deliveries`,
	   AVG(otif) AS `Avg. OTIF Deliveries`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
	ON O.Customer_id=C.customer_id
GROUP BY CITY;
