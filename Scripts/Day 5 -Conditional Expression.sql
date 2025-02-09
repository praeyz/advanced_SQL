SET search_path TO DEMO
--we can use mathematical functions on columns

SELECT 
    film_id, 
    rental_rate AS old_rental_rate,
    rental_rate+1 AS new_rental_rate,  --this adds +1 TO ALL value IN the 
    CEILING(rental_rate* 2)-0.01 AS possible_rental_rate
FROM 
    film;


/*CREATE a list OF films INCLUDING thr relation OF rental rate / replacement COST WHERE
the rental rate IS less than 4% OF the replacement COST.CREATE a list OF the film_ids 
together with the percentage rounded TO 2 decimal places*/

SELECT
    film_id,
    round(((rental_rate/replacement_cost) * 100) ,2) AS percentage
    
FROM 
    film
WHERE 
     round(((rental_rate/replacement_cost) * 100) ,2) < 4
ORDER BY 
    2 ASC


    /*--THE CASE syntax (when/else/end)
    CASE
    WHEN condition1 THEN result1
    WHEN CONDITION2 THEN result2
    ELSE RESULT
    END*/
    

SELECT 
    count(*) AS flights,
    CASE
        WHEN actual_departure IS null THEN 'no depature time'
        WHEN actual_departure - scheduled_departure < '00:05:00' THEN 'On time'
        WHEN actual_departure - scheduled_departure > '01:0:00' THEN 'little bit late'
        ELSE 'verylate'
    END AS is_late
FROM 
    flights
GROUP BY
    2
ORDER BY 
    1 DESC;


SELECT
    count(*),
    CASE 
        WHEN amount < 20000 THEN 'Low price tikect'
        WHEN amount BETWEEN 20000 AND 150000 THEN 'Mid price ticket'
        WHEN amount >= 150000 THEN 'High price ticket'
        ELSE 'null'    
    END AS ticket_prices
FROM
    ticket_flights tf 
GROUP BY 
    2

  
    

SELECT 
    count(*),
    CASE 
        WHEN EXTRACT(months FROM scheduled_departure) IN (12,1,2) THEN 'Winter'
        WHEN EXTRACT(months FROM scheduled_departure) IN (6,7,8) THEN 'Summer'
        WHEN EXTRACT(months FROM scheduled_departure) IN (9,10,11) THEN 'Fall'
        ELSE 'other seaons'
    END AS seasons
FROM
    flights
GROUP BY
    2
    








