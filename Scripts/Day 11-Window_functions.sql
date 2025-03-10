
--WINDOW FUNCTIONS 
--OVER(PARTITION BY)

SELECT
    f.film_id
    ,title
    ,length
    ,c.name AS category
    ,round(avg(length) over(PARTITION BY c.name), 2)   
FROM 
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id   
    INNER JOIN category c ON c.category_id = fc.category_id   
ORDER BY f.film_id;


/*
write a query that returns the running total of how late the flights are (difference between actual_arrival and scheduled arrival) ordered by flight_id including the departure airport.
  
As a second query, calculate the same running total but partition also by the depature airport 
 * */
SELECT
    flight_id
    ,departure_airport 
    ,sum(actual_arrival - scheduled_arrival) OVER( PARTITION BY departure_airport ORDER BY flight_id)
FROM 
    flights;


---------------------------------------------------------------------------------------------------------------------------------------------------------


SET SEARCH_path TO greencycles



--RANK AND DENSE_RANK
/*
 write a query that returns the customers name, the country and how many payments they have. For that use the existing view customer_list

 */
SELECT
    *
FROM
(SELECT
    name
    ,country
    ,count(*)
    ,RANK() over(PARTITION BY country ORDER BY count(*) ) AS "Rank"
FROM customer_list cl
    LEFT JOIN payment p
    ON cl.id = p.customer_id 
GROUP BY 
    name
    ,country) 
WHERE 
    "Rank" = 1;


SELECT
    *
FROM
(SELECT
    name
    ,country
    ,count(*)
    ,DENSE_RANK() over(PARTITION BY country ORDER BY count(*) ) AS "Rank"
FROM customer_list cl
    LEFT JOIN payment p
    ON cl.id = p.customer_id 
GROUP BY 
    name
    ,country) 
WHERE "Rank" = 1;



SELECT
    *
FROM
(SELECT
    name
    ,country
    ,count(*)
    ,FIRST_VALUE (count(*)) over(PARTITION BY country ORDER BY count(*) ) AS "Rank"
FROM customer_list cl
    LEFT JOIN payment p
    ON cl.id = p.customer_id 
GROUP BY 
    name
    ,country) 
WHERE "Rank" = 25;


-----------------------------------------------------------------------------------------------------------------------------
--LEAD AND LAG

/* 
 Write a query that returns the revenue of the day and the revenue of the previous day 
 Afterwards, calculate also the percentage growth compared to the previous day
 */


SELECT
    date(payment_date) AS day
    ,sum(amount) AS total_sales_per_day
    ,lag(sum(amount)) OVER(ORDER BY date(payment_date)) AS previous_day_sales
    ,sum(amount) - lag(sum(amount)) OVER(ORDER BY date(payment_date)) AS difference
    ,(sum(amount) - lag(sum(amount)) OVER(ORDER BY date(payment_date))) /(lag(sum(amount)) OVER(ORDER BY sum(amount))) *100 AS "percentage_growth[%]"
FROM 
    payment
GROUP BY
    date(payment_date);



