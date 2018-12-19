/*
Exercise 6 on Building and Organizing Complex Queries
*/

/*
First Attempt:
*/

SELECT
    us.first_name || " " || us.last_name employee_name, 
    COUNT(cu.customer_id) customers_usa_gt_90
FROM customer_usa us
INNER JOIN customer_gt_90_dollars cu ON cu.customer_id = us.customer_id 
GROUP BY 1
ORDER BY employee_name;

/*
Second Attempt:
*/
WITH customers_usa_gt_90 AS
    (
    SELECT * FROM customer_usa
    UNION
    SELECT * FROM customer_gt_90_dollars
    )
    
SELECT c.first_name || " " || c.last_name employee_name, COUNT(c.customer_id)
FROM customers_usa_gt_90 c
LEFT JOIN employee e ON e.employee_id = c.support_rep_id
WHERE TITLE LIKE "Sales Support Agent";

/*
Third Attempt:
*/
WITH customers_usa_gt_90 AS
    (
    SELECT * FROM customer_usa
    INTERSECT
    SELECT * FROM customer_gt_90_dollars
    )
    
SELECT e.first_name || " " || e.last_name employee_name, COUNT(c.customer_id)
FROM customers_usa_gt_90 c
LEFT JOIN employee e ON e.employee_id = c.support_rep_id
WHERE e.title LIKE "Sales Support Agent"
GROUP BY 1
ORDER BY 1;


