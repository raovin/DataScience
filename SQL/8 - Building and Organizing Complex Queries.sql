/*
Exercise 8 on Building and Organizing Complex Queries
*/

/*
First Attempt:
*/

SELECT 

SELECT cu.country, cu.first_name || " " || cu.last_name customer_name, inv.total total_purchased
FROM customer  cu
INNER JOIN invoice inv ON inv.customer_id = cu.customer_id
GROUP BY 1
ORDER BY 1;
/*
Result: Shows Highest purchase per customer not total 
*/

WITH sales_per_customer AS
    (
    SELECT 
        inv.customer_id,
        cu.country,
        inv.total
        FROM invoice inv
        INNER JOIN customer cu ON cu.customer_id = inv.customer_id 
        GROUP BY 1
        ORDER BY 2
    )

SELECT customer_id, country, sum(total) FROM sales_per_customer GROUP BY customer_id

WITH sales_per_customer AS

SELECT 
    customer_id, 
    sum(total) total
    FROM invoice 
    GROUP BY 1 
    ORDER BY 2;
    
SELECT MAX(total) FROM sales_per_customer



/* 
MY SOLUTION
*/
WITH sales_per_customer AS
(
SELECT
    inv.customer_id customer_id,
    inv.total total,
    cu.first_name || " " || cu.last_name customer_name,
    cu.country country     
    FROM invoice inv
    INNER JOIN customer cu ON inv.customer_id = cu.customer_id
),
sales_per_country AS
(
SELECT 
    customer_id, 
    customer_name, 
    country, 
    SUM(total) total_customer 
    FROM sales_per_customer 
    GROUP BY customer_id 
    ORDER BY 4
)

SELECT country, customer_name, CAST(total_customer AS DECIMAL(16,2)) total_purchased FROM sales_per_country GROUP BY country;


/* 
Swapping the following two lines causes an error:
*/
CAST(total_customer AS DECIMAL(16,2)) total_purchased
vs 
ROUND(MAX(total_customer),3) total_purchased
vs
SELECT country, customer_name, total_customer FROM sales_per_country GROUP BY country;


/* 
Dataquest Solution
*/
WITH
    customer_country_purchases AS
        (
         SELECT
             i.customer_id,
             c.country,
             SUM(i.total) total_purchases
         FROM invoice i
         INNER JOIN customer c ON i.customer_id = c.customer_id
         GROUP BY 1, 2
        ),
    country_max_purchase AS
        (
         SELECT
             country,
             MAX(total_purchases) max_purchase
         FROM customer_country_purchases
         GROUP BY 1
        ),
    country_best_customer AS
        (
         SELECT
            cmp.country,
            cmp.max_purchase,
            (
             SELECT ccp.customer_id
             FROM customer_country_purchases ccp
             WHERE ccp.country = cmp.country AND cmp.max_purchase = ccp.total_purchases
            ) customer_id
         FROM country_max_purchase cmp
        )
SELECT
    cbc.country country,
    c.first_name || " " || c.last_name customer_name,
    cbc.max_purchase total_purchased
FROM customer c
INNER JOIN country_best_customer cbc ON cbc.customer_id = c.customer_id
ORDER BY 1 ASC