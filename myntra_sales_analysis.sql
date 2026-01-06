/* =====================================================
   Myntra Sales Analysis using SQL
   Dataset: early_sales.csv (39+ records)
   ===================================================== */

-- 1. Create Database
CREATE DATABASE MyntraSalesDB;
USE MyntraSalesDB;

-- 2. Create Table
CREATE TABLE sales (
    invoiceno INT,
    stockcode VARCHAR(20),
    quantity INT,
    invoicedate DATETIME,
    unitprice DECIMAL(10,2)
);

-- 3. Sample Data Insert (structure reference)
-- Data loaded from CSV (early_sales.csv)

-- 4. Total number of sales transactions
SELECT COUNT(*) AS total_transactions
FROM sales;

-- 5. Total quantity sold
SELECT SUM(quantity) AS total_quantity_sold
FROM sales;

-- 6. Total revenue generated
SELECT SUM(quantity * unitprice) AS total_revenue
FROM sales;

-- 7. Average order value
SELECT AVG(quantity * unitprice) AS avg_order_value
FROM sales;

-- 8. Top 5 products by total quantity sold
SELECT 
    stockcode,
    SUM(quantity) AS total_quantity
FROM sales
GROUP BY stockcode
ORDER BY total_quantity DESC
LIMIT 5;

-- 9. Top 5 products by revenue
SELECT 
    stockcode,
    SUM(quantity * unitprice) AS total_revenue
FROM sales
GROUP BY stockcode
ORDER BY total_revenue DESC
LIMIT 5;

-- 10. Daily sales revenue
SELECT 
    DATE(invoicedate) AS sale_date,
    SUM(quantity * unitprice) AS daily_revenue
FROM sales
GROUP BY DATE(invoicedate)
ORDER BY sale_date;

-- 11. Identify high-value transactions (value > average)
SELECT 
    invoiceno,
    stockcode,
    quantity,
    unitprice,
    (quantity * unitprice) AS transaction_value
FROM sales
WHERE (quantity * unitprice) >
      (SELECT AVG(quantity * unitprice) FROM sales);

-- 12. Product contribution to total revenue
SELECT 
    stockcode,
    ROUND(
        (SUM(quantity * unitprice) /
        (SELECT SUM(quantity * unitprice) FROM sales)) * 100, 2
    ) AS revenue_percentage
FROM sales
GROUP BY stockcode
ORDER BY revenue_percentage DESC;
