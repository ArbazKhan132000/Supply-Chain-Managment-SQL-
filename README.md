# Supply Chain Management SQL Project

##Overview
This project analyzes supply chain data using SQL to extract insights related to order lines, orders, and delivery performance. Key performance indicators (KPIs) such as Volume Fill Rate (VOFR), On Time Delivery, and In Full Delivery are calculated and presented by city. Additional analysis includes customer orders, product demand, and city performance.

##Database Schema
The analysis uses the following tables:
###dim_customers : This table contains all the information about customers.
###dim_products.csv: This table contains all the information about products.
###dim_date : This table contains the dates at daily, monthly level and week numbers of the year.
###dim_targets_orders : This table contains all target data at the customer level.
###fact_order_lines : This table contains all information about orders and each item inside the orders.
###fact_orders_aggregate : This table contains information about OnTime, InFull and OnTime Infull information aggregated at the order level per customer.


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
```

-- 2. Total Number of Orders
SELECT count(distinct(order_id)) AS `Total Numbers of Order`
FROM fact_order_lines;
```

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
```

-- 4. On-Time Delivery % by City
SELECT City,
       SUM(on_time) AS `On Time Delivery`,
       (SUM(on_time)/count(Order_id))*100 AS `On Time Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `On Time Delivery %`;
```

-- 5. In-Full Delivery % by City
SELECT City,
       SUM(in_full) AS `In Full Delivery`,
       (SUM(in_full)/count(Order_id))*100 AS `In Full Delivery %` 
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `In Full Delivery %`;
```

-- 6. On-Time In-Full Delivery % by City
SELECT City,
       SUM(otif) AS `OTIF Delivery`,
       (SUM(otif)/count(order_id))*100 AS `OTIF Delivery %`
FROM fact_orders_aggregate AS O
INNER JOIN dim_customers AS C
    ON O.customer_id=C.customer_id
GROUP BY City
ORDER BY `OTIF Delivery %`;
```

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
```

##Recommendation :
Improve VOFR:

Focus on Cities with Low VOFR: Identify cities with lower VOFR percentages and investigate the causes, such as supply chain disruptions or logistical inefficiencies.
Optimize Inventory Management: Ensure that inventory levels align with demand forecasts to improve order fulfillment rates.
Enhance On-Time Delivery:

Address Delivery Delays: Analyze the reasons behind delivery delays in cities with low On Time Delivery percentages. Implement corrective measures such as better route planning or improving supplier performance.
Improve Logistics Coordination: Strengthen coordination with logistics partners to ensure timely deliveries.
Increase In-Full Deliveries:

Review Order Fulfillment Processes: Investigate issues causing incomplete orders and refine fulfillment processes to ensure that all ordered items are delivered.
Implement Better Tracking Systems: Use tracking systems to monitor the status of orders and identify any issues early in the fulfillment process.
Boost OTIF Performance:

Integrate On-Time and In-Full Strategies: Combine efforts to improve both on-time and in-full delivery metrics for a comprehensive approach to OTIF performance.
Regularly Monitor and Adjust: Continuously monitor OTIF performance and adjust strategies based on real-time data and feedback.
Customer and Product Analysis:

Target High-Value Customers: Focus on high-value customers who place the most orders and ensure their needs are met efficiently.
Stock In-Demand Products: Ensure that the most in-demand products are always in stock to meet customer demands and avoid lost sales.
City-Specific Strategies:

Tailor Strategies by City: Implement city-specific strategies based on the performance metrics and characteristics of each city. Customize inventory and delivery strategies to suit local conditions.

## Conclusion
This project provides valuable insights into supply chain performance metrics by city, supporting data-driven decision-making. The SQL queries are crafted to efficiently extract and analyze key metrics, aiding in the optimization and management of the supply chain.

## License
This project is licensed under the MIT License - see the LICENSE file for details.

Contact
For any questions or feedback, please contact [your email address].overall supply chain efficiency.

## Files Included

- `supply_chain_analysis.sql`: SQL script containing the queries used for analysis.
- `README.md`: Project description and documentation.

## License

This project is licensed under the MIT License.

