SET SEARCH_PATH TO greencycles

SELECT 
    round(avg(amount),2),
    sum(amount),
    payment_id 
FROM 
    payment p
GROUP BY 
    payment_id 

    
    
    
SELECT 
    min(replacement_cost) AS minimum_repalcement_cost,
    max(replacement_cost) AS maximum_replacement_cost,
    round(AVG(replacement_cost),2) AS average_raplacement_cost,
    sum(replacement_cost) AS total_replacememt_cost
FROM film




SELECT 
    staff_id,
    sum(amount) AS total_amount_sold,
    count(payment_id) AS number_of_items_sold
FROM
    payment p
WHERE
    amount != 0
GROUP BY
    staff_id 
ORDER BY
    sum(amount) DESC 
LIMIT 
    2 


    
SELECT 
    staff_id,
    sum(amount) AS total_sold,
    count(amount),
    date(payment_date) AS payment_date
FROM 
    payment
WHERE 
    amount != 0
GROUP BY 
    staff_id, date(payment_date)
ORDER BY 
    total_sold DESC, date(payment_date) DESC
    