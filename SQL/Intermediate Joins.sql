SELECT c.first_name || " " || c.last_name customer_name,
       COUNT(i.invoice_id) number_of_purchases,
       SUM(i.total) total_spent,
       CASE
            WHEN SUM(i.total)  < 40 THEN "small spender"
            WHEN SUM(i.total)  > 100 THEN "big spender"
            ELSE "regular spender"
            END
            customer_category
FROM customer c
INNER JOIN invoice i ON i.customer_id = c.customer_id
GROUP BY 1
ORDER BY customer_name;

SELECT
   c.first_name || " " || c.last_name customer_name,
   COUNT(i.invoice_id) number_of_purchases,
   SUM(i.total) total_spent,  
   CASE
       WHEN sum(i.total) < 40 THEN 'small spender'
       WHEN sum(i.total) > 100 THEN 'big spender'
       ELSE 'regular'
       END
       AS customer_category
FROM invoice i
INNER JOIN customer c ON i.customer_id = c.customer_id
GROUP BY 1 ORDER BY 1;

