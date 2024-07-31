CREATE DATABASE Supply_chain;
USE supply_chain;

SELECT * FROM fact_orders_aggregate;

ALTER TABLE fact_orders_aggregate
RENAME COLUMN `ï»¿order_id` TO `Order_id`;

SELECT * FROM fact_order_lines;
SELECT * FROM dim_targets_orders;
SELECT * FROM dim_customers;
SELECT * FROM dim_date;

ALTER TABLE dim_date
RENAME COLUMN `ï»¿date` TO `Date`;

SELECT * FROM dim_products;