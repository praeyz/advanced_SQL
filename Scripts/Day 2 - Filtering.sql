
--Practiced on FILTERING using the the where, Between, AND , OR, like 

SET SEARCH_PATH TO greencycles;

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
--So since the PostgreSQL treats the AND clause first, its better to put our logic into a bracket. or else it treats an amount and customer id first before the OR clause


 --IN this solution, the AND clause can be used TO JOIN two entities OF WHERE statemeent, THEN an OR STATEMENT can be used futher inbetween statement
SELECT *
FROM payment p    
WHERE (amount < 2 OR amount > 10) 
AND
(customer_id = 520 OR customer_id = 200 OR customer_id = 350)
ORDER BY customer_id ASC, amount DESC


--When using betweeen, we can use AND in between statement to join different entities, the opposite is NOT BETWEEN 
SELECT
count(payment_id)
FROM payment
WHERE 
(payment_date BETWEEN '2020-01-26' AND '2020-01-27 23:59')     --we use the 23:59 AS a time IN ORDER TO INCLUDE the 27th DAY OF January
AND 
(amount BETWEEN '1.99' AND '3.99')


SELECT
*
FROM payment 
WHERE customer_id IN (12,25,67,93,124,234)
AND
amount IN (4.99,7.99,9.99)
AND 
payment_date BETWEEN '2019-12-31' AND '2020-02-01'

SELECT
count(*) FROM film 
WHERE description ILIKE '%Documentary%'

-- a tricky question where we want the first name as only three letters and the last name ending with a Y or an X 
--Note that LIKE is case sensitive while ILIKE is not case sensite. The opposite of this is NOT LIKE / NOT ILIKE
SELECT count(*) 
FROM customer c 
WHERE first_name LIKE '___'
AND (last_name LIKE '%Y' OR last_name LIKE '%X')  --WHEN USING AND, OR STATEMENT, the OR STATEMENT should be IN a bracket so AS postgresSQL can distinguish it. the AND conjuction IS ALWAYS processed first


SELECT
count(*) AS no_of_movies
FROM film
WHERE description LIKE '%Saga%'
AND (title LIKE 'A%' OR title LIKE '%R')



SELECT 
*
FROM customer 
WHERE first_name LIKE '%ER%' AND first_name LIKE '_A%'
ORDER BY last_name DESC 

SELECT 
count(*) AS number_Of_payment
FROM payment  
WHERE (amount = 0 OR amount BETWEEN 3.99 AND 7.99)
AND
payment_date BETWEEN '2020-05-01 00:00' AND '2020-05-01 23:59' --the BETWEEN clause runs FROM the opening OF the 5th till the END OF the 5th


