DROP TABLE IF EXISTS RETAIL_SALES;
CREATE DATABASE sales_analysis;
CREATE TABLE RETAIL_SALES(
transactions_id INT PRIMARY KEY,
sale_date DATE,
sale_time TIME,	
customer_id	INT,
gender VARCHAR(10),
age	INT,
category VARCHAR(50),	
quantiy	INT,
price_per_unit FLOAT,
cogs FLOAT,
total_sale FLOAT);

SELECT * FROM RETAIL_SALES;

SELECT COUNT(*) FROM RETAIL_SALES;

--- NULL values
SELECT * FROM RETAIL_SALES
WHERE 
sale_date IS NULL
OR
transactions_id IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
or
gender IS NULL
OR
age IS NULL
or
category IS NULL
or
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
or
total_sale IS NULL;

--- DELETE
DELETE FROM RETAIL_SALES
WHERE
sale_date IS NULL
OR
transactions_id IS NULL
OR
sale_time IS NULL
OR
customer_id IS NULL
or
gender IS NULL
OR
age IS NULL
or
category IS NULL
or
quantiy IS NULL
OR
price_per_unit IS NULL
OR
cogs IS NULL
or
total_sale IS NULL;

--- DATA EXPLORATION

--- How many sales we have?
SELECT COUNT(*) AS TOTAL_SALES FROM retail_sales;

--- How many unique customers and category we have?
SELECT COUNT(DISTINCT customer_id) AS TOTAL_SALES FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

--- Data Analysis & Business key problems & Answers
--- Data Analysis & Findings

--- Q1. Write a SQL query to retrieve all columns for sales made on '2022-11-05'

SELECT * FROM retail_sales
WHERE sale_date = '2022-11-05';

--- Q2. Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
SELECT * FROM retail_sales
WHERE CATEGORY = 'Clothing' 
AND 
quantiy >= 4; 
# AND to_char(sale_date, 'YYYY-MM') = '2022-11';

--- Q3. Write a SQL query to calculate the total sales (total_sale) for each category.
SELECT CATEGORY,
sum(TOTAL_SALE) AS NET_SALE,
COUNT(*) AS TOTAL_ORDERS
FROM retail_sales
GROUP BY 1;

--- Q4. Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category
SELECT ROUND(AVG(AGE),2) AS AVG_AGE 
FROM retail_sales
WHERE CATEGORY = 'Beauty';

--- Q5. Write a SQL query to find all transactions where the total_sale is greater than 1000
SELECT * FROM retail_sales
WHERE total_sale > 1000;

--- Q6. Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.
SELECT
category,
gender,
COUNT(*) AS TOTAL_TRANS
FROM retail_sales
group by
category,
gender
order by 1;

--- Q7. Write a SQL query to calculate the average sale for each month. Find out best selling month in each year.
SELECT 
       year,
       month,
    avg_sale
FROM 
(    
SELECT 
    YEAR(SALE_DATE) AS YEAR,
	MONTH(SALE_DATE) AS MONTH,
    AVG(total_sale) as avg_sale,
    RANK() OVER(PARTITION BY YEAR(SALE_DATE) , MONTH(SALE_DATE)  ORDER BY AVG(total_sale) DESC) as rank
FROM retail_sales
GROUP BY 1, 2
) as t1
WHERE rank = 1;

--- Q8. Write a SQL query to find the top 5 customers based on the highest total sales
SELECT 
customer_id,
sum(total_sale) as total_sales
from retail_sales
group by 1
order by 1 desc
limit 5;

--- Q9. Write a SQL query to find the number of unique customers who purchased items from each category
SELECT 
CATEGORY,
COUNT(DISTINCT CUSTOMER_ID) AS UNIQUECust
FROM retail_sales
GROUP BY CATEGORY;

--- Q10. Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)
WITH HOURLY_SALE
AS
(SELECT *, 
	CASE
		WHEN  HOUR(SALE_TIME) < 12 THEN 'MORNING'
        WHEN  HOUR(SALE_TIME) Between 12 AND 17 THEN 'AFTERNOON'
        ELSE 'EVENING'
	END AS SHIFT
FROM retail_sales
)
SELECT
SHIFT, 
COUNT(*) AS TOTAL_ORDERS
FROM HOURLY_SALE
GROUP BY SHIFT;

--- END OF PROJECT
