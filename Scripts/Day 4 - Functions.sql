
set search_path to greencycles


SELECT
    lower(first_name) as first_name_lower,
    lower(last_name) as last_name_lower
FROM    
    customer
WHERE 
    length(first_name) > 10 or length(last_name) > 10
    
    

    --Extract the last 5 characters of the Email address
    
SELECT 
    RIGHT(email, 5),
    email
FROM 
    customer
    
    

    --Extract just "." from the Email address
SELECT 
    LEFT(RIGHT(email, 4),1),
    email
FROM 
    customer
    

    --Using Concatenation ||
SELECT 
    lower(first_name) 
    || lower(last_name)
    || '@gmail.com' AS email
FROM 
    Customer
    
    

SELECT 
    left(first_name, 1) 
    || '***' 
    || RIGHT(email, 19) AS anonymolized_email
FROM 
    customer c 
    
    
    --Using Position('start' in string)
SELECT 
    last_name 
    || ', ' 
    || left(email,POSITION('.' IN email)-1)
FROM
    customer
    
    
    --Uisng Substring
    --SUBSTRING(string from start [for length])
SELECT
    SUBSTRING(email FROM POSITION('.' IN  email)+1 FOR length(last_name))
FROM 
    customer

SELECT * FROM customer c 

--creating anonymilized form of Email (M***.S***@sakilaacustomer.org)
SELECT
    left(first_name, 1)
    || '***' 
    || SUBSTRING(email FROM POSITION('.' IN email) FOR 2)  
    || '***' 
    || Right(email,19 ) AS anonymized_email 
FROM
    customer 
    
    
--creating anonymilized form of Email (***Y.S***@sakilaacustomer.org) but only from the email column

SELECT 
    '***'
    || SUBSTRING(email FROM POSITION ('.' IN email)-1 FOR 3)
    || '***' 
    || SUBSTRING(email FROM POSITION('@' IN email))
    AS anonymized_email
FROM 
    customer

    
    --Using the Extract SYNTAX  EXTRACT(field from date/time/interval)
    
SELECT
    EXTRACT(DOW from rental_date) AS DOW,  -- 0 IS sunday
    EXTRACT(month from rental_date) AS month,
    COUNT(rental_date) AS number_of_sales
FROM 
    rental
GROUP BY 
    1, 2
ORDER BY 
   3 DESC

    
--whats the total amount spent by a customer in a week    
SELECT
    customer_id, 
    sum(amount) AS total_amount_spent,
    EXTRACT (week FROM payment_date) AS week
FROM 
    payment
GROUP BY
    1,3
ORDER BY 
    2 DESC
    
    
--Using the TO_CHAR syntax  TO_CHAR(date/time/interval, format)
    
SELECT 
    sum(amount) AS total_amount,
    TO_CHAR(payment_date, 'Dy, DD/MM/YYYY') AS DAY,
    TO_CHAR(payment_date, 'Mon,YYYY') AS DAY,
    TO_CHAR(payment_date, 'Dy, HH:MI') AS day
FROM 
    payment
GROUP  BY
    payment_date 
ORDER BY 
    1 DESC
    
    
--USING Time Stamp AND intervals

--create a list of all the rental durations of customer with customer_id 35
SELECT 
    customer_id,
    /*EXTRACT (days FROM return_date - rental_date) 
    || ' days ' 
    || EXTRACT (hours FROM return_date - rental_date)  
    || ' hours ' 
    || EXTRACT (minutes FROM return_date - rental_date)
    || ' minutes ' 
    AS rental_duration   --Note that aggregation does NOT WORK WITH concatenation */
    return_date-rental_date  AS rental_duration
FROM 
    rental 
WHERE 
    customer_id = '35'
    
    
--find out which customer has the longest average rental duration
SELECT
    customer_id,
    AVG(return_date - rental_date) AS average_rental_duration
FROM 
    rental 
GROUP BY
    customer_id
ORDER BY
    2 DESC

