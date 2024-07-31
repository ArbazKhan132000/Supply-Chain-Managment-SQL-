# Supply Chain Management SQL Project

## Project Insights

- **Total Number of Order Lines:**
  - Provides a count of all order lines in the dataset.
- **Total Number of Orders:**
  - Counts distinct orders, giving insight into the volume of individual transactions.
- **Volume Fill Rate (VOFR %):**
  - Measures the percentage of ordered quantity delivered, segmented by city.
- **On-Time Delivery %:**
  - Calculates the percentage of orders delivered on time, per city.
- **In-Full Delivery %:**
  - Determines the percentage of orders delivered in full, per city.
- **On-Time In-Full Delivery %:**
  - Combines both on-time and in-full delivery metrics to assess overall delivery performance.
- **Comparison of Delivery Metrics:**
  - Compares on-time delivery, in-full delivery, and OTIF delivery rates across cities to identify top performers.

## SQL Queries

```sql
-- 1. Total Number of Order Lines
SELECT count(order_id) AS `Total Numbers Order Lines`
FROM fact_order_lines;

-- 2. Total Number of Orders
SELECT count(distinct(order_id)) AS `Total Numbers of Order`
FROM fact_order_lines;

-- 3. Volume Fill Rate (VOFR %) by City
SELECT City,
       CONCAT(Round((SUM(order_qty)/1000000),2),' ','M') AS `Ordered Quantity`,
       CONCAT(ROUND((SUM(delivery_qty)/1000000),2),' ','M') AS `Delivered Quantity`,
       ROUND((SUM(delivery_qty)/SUM(order_qty))*100,2) AS `VOFR %`
FROM fact_order_lines AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `VOFR %`;

-- 4. On-Time Delivery % by City
SELECT City,
       SUM(on_time) AS `On Time Delivery`,
       (SUM(on_time)/count(Order_id))*100 AS `On Time Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `On Time Delivery %`;

-- 5. In-Full Delivery % by City
SELECT City,
       SUM(in_full) AS `In Full Delivery`,
       (SUM(in_full)/count(Order_id))*100 AS `In Full Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `In Full Delivery %`;

-- 6. On-Time In-Full Delivery % by City
SELECT City,
       SUM(otif) AS `OTIF Delivery`,
       (SUM(otif)/count(order_id))*100 AS `OTIF Delivery %`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `OTIF Delivery %`;

-- 7. Comparison of Delivery Metrics by City
SELECT City,
       (SUM(on_time)/count(Order_id))*100 AS `On Time Delivery %`,
       (SUM(in_full)/count(Order_id))*100 AS `In Full Delivery %`,
       (SUM(otif)/count(order_id))*100 AS `OTIF Delivery %`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `OTIF Delivery %` DESC;
