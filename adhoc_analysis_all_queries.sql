
-- 1. Find the market where customer 'Atliq Exclusive' operates in the APAC region.
SELECT DISTINCT market
FROM dim_customer
WHERE customer = 'Atliq Exclusive' AND region = 'APAC';


-- 2. Compare the number of unique products sold in FY2020 and FY2021 and find the percentage change.
WITH cte1 AS (
    SELECT fiscal_year, COUNT(DISTINCT f.product_code) AS unique_products_2020 
    FROM fact_sales_monthly f
    JOIN dim_product p ON f.product_code = p.product_code
    WHERE fiscal_year = '2020'
    GROUP BY fiscal_year
),
cte2 AS (
    SELECT fiscal_year, COUNT(DISTINCT f.product_code) AS unique_products_2021
    FROM fact_sales_monthly f
    JOIN dim_product p ON f.product_code = p.product_code
    WHERE fiscal_year = '2021'
    GROUP BY fiscal_year
)
SELECT unique_products_2020, unique_products_2021,
ROUND((unique_products_2021 - unique_products_2020) / unique_products_2020 * 100, 2) AS pct_chg
FROM cte1
CROSS JOIN cte2;


-- 3. Get the count of distinct products in each segment.
SELECT segment, COUNT(DISTINCT product_code) AS product_count
FROM dim_product
GROUP BY segment
ORDER BY product_count DESC;


-- 4. Compare the number of products sold in FY2020 and FY2021 for each segment.
WITH cte1 AS (
    SELECT segment, COUNT(DISTINCT f.product_code) AS product_count_2020 
    FROM fact_sales_monthly f
    JOIN dim_product p ON f.product_code = p.product_code
    WHERE fiscal_year = '2020'
    GROUP BY segment
),
cte2 AS (
    SELECT segment, COUNT(DISTINCT f.product_code) AS product_count_2021 
    FROM fact_sales_monthly f
    JOIN dim_product p ON f.product_code = p.product_code
    WHERE fiscal_year = '2021'
    GROUP BY segment
)
SELECT *, (product_count_2021 - product_count_2020) AS diff
FROM cte1
JOIN cte2 USING (segment)
ORDER BY diff DESC;


-- 5. Get the products with the highest and lowest manufacturing cost.
SELECT product_code, product, manufacturing_cost
FROM fact_manufacturing_cost
JOIN dim_product USING (product_code)
WHERE manufacturing_cost = (SELECT MAX(manufacturing_cost) FROM fact_manufacturing_cost)
   OR manufacturing_cost = (SELECT MIN(manufacturing_cost) FROM fact_manufacturing_cost)
ORDER BY manufacturing_cost DESC;


-- 6. Find top 5 customers in India market by average pre-invoice discount in FY2021.
SELECT customer_code, customer, ROUND(AVG(pre_invoice_discount_pct), 2)*100 AS avg_discount_pct
FROM dim_customer
JOIN fact_pre_invoice_deductions USING (customer_code)
WHERE market = 'India' AND fiscal_year = 2021
GROUP BY customer_code, customer
ORDER BY avg_discount_pct DESC
LIMIT 5;


-- 7. Get monthly sales trend of 'Atliq Exclusive' customer.
SELECT 
    MONTHNAME(s.date) AS Month, 
    s.fiscal_year, 
    ROUND(SUM(gross_price * sold_quantity) / 1000000, 2) AS gross_sales_amount 
FROM fact_gross_price g
JOIN fact_sales_monthly s USING(product_code, fiscal_year)
JOIN dim_customer c USING(customer_code)
WHERE customer = 'Atliq Exclusive'
GROUP BY Month, fiscal_year
ORDER BY fiscal_year;


-- 8. Calculate quarterly sales quantity for FY2020.
WITH qtrly_sales AS (
    SELECT 
        date, 
        CONCAT('Q', CEIL(MONTH(ADDDATE(date, INTERVAL 4 MONTH)) / 3)) AS qtr, 
        sold_quantity
    FROM fact_sales_monthly
    WHERE fiscal_year = 2020
)
SELECT 
    qtr,
    ROUND(SUM(sold_quantity) / 1000000, 2) AS Total_sold_quantity 
FROM qtrly_sales
GROUP BY qtr
ORDER BY Total_sold_quantity DESC;


-- 9. Show sales contribution by channel in FY2021.
WITH cte AS (
    SELECT 
        channel, 
        SUM(gross_price * sold_quantity) AS gross_sales 
    FROM fact_gross_price
    JOIN fact_sales_monthly USING(product_code, fiscal_year)
    JOIN dim_customer USING(customer_code)
    WHERE fiscal_year = 2021
    GROUP BY channel
)
SELECT 
    channel, 
    ROUND(gross_sales / 1000000, 2) AS gross_sales_mln, 
    CONCAT(ROUND((gross_sales / (SELECT SUM(gross_sales) FROM cte)) * 100, 2), '%') AS percentage
FROM cte
ORDER BY percentage DESC;


-- 10. Find top 3 selling products by division in FY2021.
WITH div_sales AS (
    SELECT 
        division, 
        product_code, 
        product, 
        SUM(sold_quantity) AS total_sold_quantity,
        RANK() OVER (PARTITION BY division ORDER BY SUM(sold_quantity) DESC) AS rank_order  
    FROM fact_sales_monthly
    JOIN dim_product USING(product_code)
    WHERE fiscal_year = 2021
    GROUP BY division, product_code, product
)
SELECT *
FROM div_sales
WHERE rank_order <= 3;
