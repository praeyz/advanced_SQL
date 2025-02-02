SELECT
count(rental_id)
FROM rental r 
WHERE return_date IS NULL 

SELECT
payment_id,
amount
FROM payment p 
WHERE amount <= 2


--So since the PostgreSQL treats the AND clause first, its better to put our logic into a bracket. or else it treats an amount and customer id first before the or clause
SELECT
*
FROM payment p 
WHERE 
(amount = 10.99 OR amount = 9.99)
AND
customer_id = 200
--So since the PostgreSQL treats the AND clause first, its better to put our logic into a bracket. or else it treats an amount and customer id first before the or clause


 --IN this solution, the AND clause can be used TO JOIN two entities OF WHERE statemeent, THEN an OR STATEMENT can be used futher inbetween statement
ORDER BY customer_id ASC, amount DESC
SELECT *
FROM payment p    
WHERE (amount < 2 OR amount > 10) 
AND (customer_id = 520 OR customer_id = 200 OR customer_id = 350) 


--When using betweeen, we can use AND in between statement to join different entities
SELECT
count(payment_id)
FROM payment
WHERE 
(payment_date BETWEEN '2020-01-26' AND '2020-01-27 23:59')     --we use the 23:59 AS a time IN ORDER TO INCLUDE the 27th DAY OF January
AND 
(amount BETWEEN '1.99' AND '3.99')





