
--JOIN combines columns
--Union combine rows, Join occurs on syntaxs

/*
SELECT first_name, sales FROM vancouver
UNION
SELECT first_nmae, sales FROM delhi

--The Order matters, as the datatype must match
--The Number of columns must also match 
--duplicates are decoupled. In the output there wount be any duplicate. To solve this, use UNION ALL 
*/

--SUBQUERIES

SELECT 
    * 
FROM 
    film f 
WHERE length > (SELECT AVG(length)FROM film f )



--Return all the films that are avaliable in the inventory in store 2 more than 3 times.
SELECT 
    *
FROM 
    film 
WHERE 
    film_id IN (SELECT
                    film_id
                FROM 
                    inventory i 
                WHERE 
                    store_id = 2 
                GROUP BY
                    film_id 
                HAVING count(*) > 3);
            
            
--Return all customers first name and lastnames that have made payment on '2020-01-25'                     
SELECT 
    first_name,
    last_name
FROM 
    customer c 
WHERE
    customer_id IN  (SELECT 
                        customer_id 
                     FROM 
                        payment 
                     WHERE 
                        DATE(payment_date) = '2020-01-25')

--Return all customers first names and email addresses  that have spent more than 30$    
SELECT 
    first_name,
    email 
FROM 
    customer 
WHERE
    customer_id IN (SELECT
                        customer_id
                    FROM 
                        payment
                    GROUP BY
                        customer_id
                    HAVING sum(amount) > 30 )

    

--Return all customers first name and last name that are from carlifornia and have spent more than $100 in total 
SELECT
    c.first_name, 
    c.last_name
FROM 
    customer c
    INNER JOIN address a ON c.address_id = a.address_id 
WHERE
    a.district = 'California'
AND 
    customer_id IN (SELECT 
                        customer_id
                    FROM 
                        payment p 
                    GROUP BY
                        customer_id 
                    HAVING
                        sum(amount) > 100);

                        
--SUBQUERY FROM 
                        
--what is the average total amount spent per day(average daily renue)
SELECT
    ROUND(AVG("average daily revenue"), 2)  AS daily_revenue_average
FROM
    (SELECT 
        DATE(payment_date),
        ROUND(SUM(amount),2) AS "average daily revenue"  
    FROM
        payment
    GROUP BY
        DATE(payment_date));


--SUBQUERIES IN

--show all the payments together with how much the payment amount is below the maximum payment amount
SELECT 
    *,
    ((SELECT max(amount) FROM payment) - amount) AS difference
FROM 
    payment;
    

/*
CORRELEATED SUBQUERIES WHERE
*/

--  note that in this subquery, every row gets evaluated independently
--Subquery does not work independently
--subquery gets evaluated for every single row

--*QUESTION: show only the payments that have the highest amount per customer

SELECT 
    *
FROM 
    payment p1
WHERE amount = --picks the amount FROM the FIRST ROW annd THEN evaluates it against the subquery
    (SELECT max(amount) FROM payment p2  --now we have the maximum amount
    WHERE  p1.customer_id = p2.customer_id) --For EACH distinct customer 
    



--*QUESTION: Show only those movie titles, their associated film_id and replacement_cost with the
-- lowest replacement_costs for in each rating category - also show the rating 


--Algorithm
--Start from the subquery 
    --find the lowest replacement cost first 
    --evaluate it for each category (1.rating category = 2.rating category)
--Now the main query 
    --select the required colums to see
    --filter by the replacement cost 


SELECT 
    title,
    film_id,
    replacement_cost,
    rating 
FROM
    film f1
WHERE replacement_cost =
      (SELECT  MIN(replacement_cost) FROM film f2
       WHERE f1.rating = f2.rating);


--*QUESTION : Show only those movie titles, their associated film_id 
--and the length that have the highest length in
-- each rating category - also show the rating 

--Algorithm 
--Start from the sub query 
    -- find the maximum length 
    -- evaluate it for each rating category(1.rating = 2.rating)
--Now the main query 
    --selects the required column to see 
    --filter by the length 
    
SELECT 
    title,
    film_id,
    length,
    rating
FROM 
    film f1
WHERE 
    length = 
        (SELECT max(length) FROM film f2
        WHERE f1.rating = f2.rating)




/*CORRELATED SUBQUERIES IN SELECT */

--we can build up a new column using what we learnt in correlated  WHERE


/*
SHOW ALL the payments plus the total amount FOR EVERY customer AS well AS the number OF payments OF EACH customer 
*/

SELECT
    *,
    (SELECT count(amount) FROM payment p3
    WHERE p1.customer_id = p3.customer_id),
    (SELECT SUM(amount) FROM payment p2
    WHERE p1.customer_id = p2.customer_id)
FROM 
    payment p1 
ORDER BY
    customer_id, amount DESC


/*
Show only the films with the highest replacement costs in their
rating category plus show the average replacement cost in their rating category  
*/


--Algorithm 
    -- Start with films with highest replacement cost using the WHERE
    -- Then we can add a column for the average 

SELECT 
    title,
    replacement_cost,
    rating,
    (SELECT AVG(replacement_cost) FROM film f3
     WHERE f3.rating = f1.rating)
FROM
    film f1
WHERE 
    replacement_cost = (SELECT MAX(replacement_cost) FROM film f2
                        WHERE f1.rating = f2.rating )


/*
 * Show only those payments with the highest payment for each customer's
first name - Including the payment_id of that payment
 */


SELECT
    first_name,
    payment_id,
    amount
FROM
    payment p
INNER JOIN 
    customer c   
    ON p.customer_id = c.customer_id
WHERE
    amount =
            (SELECT MAX(amount) FROM payment p2
            WHERE p.customer_id = p2.customer_id)



