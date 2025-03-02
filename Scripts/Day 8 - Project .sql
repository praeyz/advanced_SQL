/*Question 1:
Level: Simple
Topic: DISTINCT
Task: Create a list of all the different (distinct) replacement costs of the films.

Question: What's the lowest replacement cost?*/

SET search_path TO greencycles

SELECT 
    DISTINCT(replacement_cost)
FROM
    film
ORDER BY
    1 ASC 
LIMIT
    1;
----------------------------------------------------------------------------------------------------------
/*Question 2:
Level: Moderate
Topic: CASE + GROUP BY
Task: Write a query that gives an overview of how many films have replacements costs in the following cost ranges
low: 9.99 - 19.99
medium: 20.00 - 24.99
high: 25.00 - 29.99

Question: How many films have a replacement cost in the "low" group?*/

SELECT 
    COUNT(CASE WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 1 ELSE 0 END),
    CASE
        WHEN replacement_cost BETWEEN 9.99 AND 19.99 THEN 'low'
        WHEN replacement_cost BETWEEN 20.00 AND 24.99 THEN 'Medium'
        WHEN replacement_cost BETWEEN 25.00 AND 29.99 THEN 'High'
        ELSE null
    END AS cost_range;
FROM film
GROUP BY 2;

------------------------------------------------------------------------------------------------------------

/* Question :3
 * Topic : JOIN
Task: Create a list of the film titles including their title, length,
and category name ordered descendingly by length.
Filter the results to only the movies in the category 'Drama' or 'Sports'.

Question: In which category is the longest film and how long is it?
 * */

SELECT 
    f.title,
    f.length,
    c.name   
FROM film f 
        INNER JOIN film_category fc ON f.film_id = fc.film_id
        INNER JOIN category c ON fc.category_id = c.category_id 
        AND c.name IN ('Drama', 'Sports')
ORDER BY 
    f.length DESC
LIMIT 
    1;

--------------------------------------------------------------------------------------------------------------    
/*
Topic: JOIN & GROUP BY

Task: Create an overview of the actors' first and last names and in how many movies they appear in.

Question 4: Which actor is part of most movies??
 */

SELECT 
    first_name,
    last_name,
    count(fa.film_id) AS movie_count
FROM 
    actor a 
    INNER JOIN film_actor fa ON a.actor_id = fa.actor_id
    INNER JOIN film f ON fa.film_id  = f.film_id 
GROUP BY
    a.first_name,
    a.last_name 
ORDER BY
    movie_count DESC
LIMIT 1;


-------------------------------------------------------------------------------------------------

/*
 Question 6:

Level: Moderate

Topic: LEFT JOIN & FILTERING

Task: Create an overview of the addresses that are not associated to any customer.

Question: How many addresses are that?
 */

SELECT
    count(*) AS "numbre of addresses that are not associated to any customer" 
FROM 
    customer c
    RIGHT JOIN address a ON c.address_id = a.address_id 
WHERE 
    c.address_id IS NULL; 


/*
 Level: Moderate

Topic: JOIN & GROUP BY

Task: Create the overview of the sales  to determine the from which city 
(we are interested in the city in which the customer lives, not where the store is) most sales occur.

Question: What city is that and how much is the amount?
 */

----------------------------------------------------------------------------------------------------
SELECT 
    ci.city,
    count(p.payment_id) AS number_of_sales,
    SUM(amount) AS total_sales
FROM 
    customer c 
    INNER JOIN payment p ON c.customer_id = p.customer_id 
    INNER JOIN address a ON a.address_id = c.address_id 
    INNER JOIN city ci ON ci.city_id = a.city_id    
GROUP BY 
    ci.city
ORDER BY 
    total_sales DESC
LIMIT 1;



/*Question 8:

Level: Moderate to difficult

Topic: JOIN & GROUP BY

Task: Create an overview of the revenue (sum of amount) grouped by a column in the format "country, city".

Question: Which country, city has the least sales?

Answer: United States, Tallahassee with a total amount of 50.85.*/

SELECT
    CONCAT(co.country ,',', ci.city) AS country_city,
    SUM(p.amount) AS total_sales
FROM 
    customer c 
    INNER JOIN payment p ON c.customer_id = p.customer_id 
    INNER JOIN address a ON a.address_id = c.address_id 
    INNER JOIN city ci ON ci.city_id = a.city_id 
    INNER JOIN country co ON co.country_id =ci.country_id 
GROUP BY 
    country_city
ORDER BY 
    total_sales ASC
LIMIT 1;




/*Question 9:

Level: Difficult

Topic: Uncorrelated subquery

Task: Create a list with the average of the sales amount each staff_id has per customer.

Question: Which staff_id makes on average more revenue per customer?

Answer: staff_id 2 with an average revenue of 56.64 per customer.*/


SELECT 

