# Faasos Data Analysis with MySQL

This project involves an exploratory data analysis (EDA) of a simulated Faasos dataset using SQL. The main goal was to practice SQL skills and gain insights into customer orders and driver deliveries.

---

## Table of Contents

* [Project Overview](#project-overview)
* [Dataset](#dataset)
* [Analysis Performed](#analysis-performed)
* [How to Use](#how-to-use)
* [Future Enhancements](#future-enhancements)

---

## Project Overview

This project uses MySQL to query Faasos order and delivery data. Key areas of analysis include:

* Identifying **peak order times and days**.
* Analyzing **order modifications** (additions/removals).
* Calculating **delivery metrics** like average duration, distance, and driver speed.
* Assessing **driver performance** based on successful deliveries.

The SQL queries demonstrate data cleaning, aggregation, and conditional logic to answer business questions.

---

## Dataset

The analysis uses a simulated Faasos dataset, primarily consisting of two tables:

* `customer_orders`: Details about customer orders (ID, date, items included/excluded).
* `driver_order`: Driver assignment and delivery outcomes (pickup time, distance, duration, cancellation status).

---

## Analysis Performed

The project includes the following analyses:

1.  **Order Volume:** Found the customer with the most successful roll deliveries in one order.
2.  **Order Changes:**
    * Cleaned item modification columns.
    * Counted orders with modifications.
    * Analyzed modifications per customer and for delivered orders.
3.  **Order Trends:** Identified the busiest hours and days for orders.
4.  **Delivery Performance:**
    * Calculated average delivery time, pickup time, and distance.
    * Determined shortest/longest delivery times and average speed per delivery/driver.
5.  **Driver Success:** Calculated the successful delivery rate for each driver.

---

## How to Use

To run this analysis:

1.  **Set up MySQL:** Ensure MySQL is installed and you have a client to connect.
2.  **Prepare Data:** Create a database (e.g., `faasos_db`) and load your `customer_orders` and `driver_order` tables with data.
3.  **Execute Queries:** Connect to `faasos_db` and run the SQL queries. Be aware that some queries modify data (`UPDATE`, `ALTER TABLE`).

---

## Future Enhancements

* **Data Visualization:** Use tools like Power BI or Python libraries (Matplotlib, Seaborn) to visualize insights.
* **Advanced SQL:** Explore more complex SQL features.
* **Optimization:** Add indexes for better performance on large datasets.
* **Predictive Analysis:** If more data is available, predict demand or delivery times.
* **Customer Segmentation:** Further analyze customer ordering habits.
