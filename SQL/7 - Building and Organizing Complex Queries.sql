/*
Exercise 6 on Building and Organizing Complex Queries
*/

/*
First Attempt:
*/

WITH india AS
    (
    SELECT * FROM invoice 
    WHERE billing_country = "india"
    )
    other
    (
    SELECT customer_id, SUM(total) total* FROM india
    )

SELECT
    first_name || " " || last_name customer_name, 
    SUM(total) total_purchases
FROM other
ORDER BY customer_name;


/*
Second Attempt:
*/

WITH customers_india AS
    (
    SELECT * FROM customer 
    WHERE country = "india"
    ),
    sales_per_customer AS
    (
    SELECT customer_id, SUM(total) total FROM invoice
    GROUP BY customer_id 
    )

SELECT
    c.first_name || " " || c.last_name customer_name, 
    i.total total_purchases
FROM customers_india c
INNER JOIN sales_per_customer i ON i.customer_id = c.customer_id
ORDER BY 1;