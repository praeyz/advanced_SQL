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
    

SET SEARCH_PATH TO greencycles


SELECT
    title,
    CASE
        WHEN rating = 'PG' OR rating = 'PG-13' OR length > 210 THEN 'Great rating or long(tier 1)'
        WHEN description ILIKE '%Drama%' AND length > 90 THEN 'Long drama(tier 2)'
        WHEN description ILIKE '%Drama%' AND length < 90 THEN 'short drama(tier 3)'
        WHEN rental_rate < 1 THEN 'Verycheap (tier 4)'
        ELSE 'no rating'
    END  AS tier_list
 FROM 
    film
WHERE
    CASE
        WHEN rating = 'PG' OR rating = 'PG-13' OR length > 210 THEN 'Great rating or long(tier 1)'
        WHEN description ILIKE '%Drama%' AND length > 90 THEN 'Long drama(tier 2)'
        WHEN description ILIKE '%Drama%' AND length < 90 THEN 'short drama(tier 3)'
        WHEN rental_rate < 1 THEN 'Verycheap (tier 4)'
        ELSE 'no rating'
    END
    != 'no rating'

    

/*CASE WHEN & SUM

Write a single SQL query to calculate the total income and total expenses from the transactions table.

Additionally, calculate the net income (total income - total expenses) as a separate column in the result.

Key information for the challenge:

Table name: transactions

Column names needed: amount, category

Use aliases for the total income, total expenses, and net income as TotalIncome, TotalExpenses, and NetIncome, respectively.*/


SELECT 
    SUM(CASE WHEN category = 'Income' Then amount else 0 end ) as TotalIncome,
    SUM(CASE WHEN category = 'Expense' Then amount else 0 end) as TotalExpenses,
    SUM(CASE WHEN category = 'Income' Then amount else - amount end) as NetIncome
FROM 
    transactions
    
    

--COALESCE  -Returns the first value of a list of value which is not null
    
/*Consider the following table called transactions:

Write a SQL query to retrieve all transactions, displaying the transaction ID, account ID, transaction type, amount, and description.

For any transactions that do not have a description, display 'Not Provided' in place of the NULL value. Ensure your query is ordered by the transaction ID. Make sure to not forget to use the alias description.

Important columns: transaction_id, account_id, transaction_type, amount, description*/

SELECT 
    transaction_id,
    account_id,
    transaction_type,
    amount,
    coalesce(description, 'Not Provided') as description
FROM 
    transactions
ORDER BY 
    transaction_id;



--COALSCE and CAST
    --cast changes the datatype  CAST(column_name AS new_data_type)

SELECT 
    rental_date,
    COALESCE(CAST(return_date AS VARCHAR),'Not returned') AS return_date 
FROM
    rental
ORDER BY 
    rental_date DESC 
    
--REPLACE 
    --The replace syntax replaces a value or string in a column REPLACE(column_name, 'what to replace', 'what to be replace with')
