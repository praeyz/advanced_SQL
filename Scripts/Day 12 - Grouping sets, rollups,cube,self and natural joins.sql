--GROUPING SETS
--Grouping sets gives a combination of specific criteria
/*
 write a query that returns the sum of the amount for each customer(first name and last name) and each staff_id.
  Also add the overall revenue per customer 
 **/

SELECT 
    p.staff_id
    ,c.first_name
    ,c.last_name
    ,sum(amount)
FROM 
    customer c
    INNER JOIN payment p  
    ON p.customer_id = c.customer_id 
GROUP BY 
        GROUPING SETS(
        (first_name, last_name), -- This grouping calculates the total payment amount for each combination of first_name and last_name
        (first_name, last_name, staff_id) -- This grouping calculates the total payment amount for each combination of first_name, last_name, and staff_id
        );


        
/*
 write a query that calculates now the share of revenue each staff_id makes per customer
  * */
                
        
SELECT
    first_name
    ,last_name
    ,staff_id
    ,SUM(amount) AS total
    --,100*SUM(amount)/FIRST_VALUE(sum(amount)) OVER(PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC)
    ,FIRST_VALUE(sum(amount)) OVER(PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC) -- this gives us the highest sales made per customer
    ,ROUND( 100* SUM(amount) / FIRST_VALUE(sum(amount)) OVER(PARTITION BY first_name, last_name ORDER BY SUM(amount) DESC), 2) AS percentage_revenue --revenue IS the total amount sold per customer / highest sales
FROM 
    customer c
    LEFT JOIN payment p  ON p.customer_id = c.customer_id 
GROUP BY
    GROUPING SETS (
    (1,2,3)
    );
    
---------------------------------------------------------------------------------------------------------------------------------------------------------

--ROLLUP 
-- Roll up gives Hierarchical aggregations, giving totals at each level specified.
/*write a query that calculates a booking amount rollup for the hierachy of quarter, month, week in a month and day */
SET SEARCH_PATH TO DEMO 

SELECT 
    'Q' || TO_CHAR(book_date , 'Q') AS quater
    ,EXTRACT (MONTH FROM book_date) AS MONTH
    ,TO_CHAR(book_date, 'W') AS week_in_month
    ,DATE(book_date)
    ,SUM(total_amount)
FROM 
    bookings b 
GROUP BY
    ROLLUP 
        (
    'Q' || TO_CHAR(book_date , 'Q')
    ,EXTRACT (MONTH FROM book_date) 
    ,TO_CHAR(book_date, 'W') 
    ,DATE(book_date)
        )
ORDER BY 
    (1,2,3,4)
    
    
    
    
--CUBE
--Cube gives Multidimensional aggregations, providing all possible combinations of totals for specified columns
    
SELECT 
    'Q' || TO_CHAR(book_date , 'Q') AS quater
    ,EXTRACT (MONTH FROM book_date) AS MONTH
    ,TO_CHAR(book_date, 'W') AS week_in_month
    ,DATE(book_date)
    ,SUM(total_amount)
FROM 
    bookings b 
GROUP BY
    CUBE
        (
    'Q' || TO_CHAR(book_date , 'Q')
    ,EXTRACT (MONTH FROM book_date) 
    ,TO_CHAR(book_date, 'W') 
    ,DATE(book_date)
        )
ORDER BY 
    (1,2,3,4);

----------------------------------------------------------------------------------------------------------------------------

--SELF JOIN 

SET search_path TO greencycles

--Creating a table

CREATE TABLE employee (
    employee_id INT,
    name VARCHAR (50),
    manager_id INT
);

--inserting values into the table 
INSERT INTO employee 
VALUES
    (1, 'Liam Smith', NULL),
    (2, 'Oliver Brown', 1),
    (3, 'Elijah Jones', 1),
    (4, 'William Miller', 1),
    (5, 'James Davis', 2),
    (6, 'Olivia Hernandez', 2),
    (7, 'Emma Lopez', 2),
    (8, 'Sophia Andersen', 2),
    (9, 'Mia Lee', 3),
    (10, 'Ava Robinson', 3);

SELECT * FROM employee

--creating a selfjoin table to know which employee has a manager and which manager has a higher manager
SELECT 
    emp.employee_id
    ,emp.name AS employee
    ,mng.name AS manager
    ,mng.name AS manager_of_manager
FROM
    employee emp
    LEFT JOIN
        employee mng
        ON emp.manager_id = mng.employee_id
    LEFT JOIN employee mng2
        ON mng.manager_id = mng2.employee_id

    
/*
 
Find all the pairs of films with the same length
 **/


SELECT 
    f1.title
    ,f2.title 
    ,f1.length
FROM film f1
    LEFT JOIN film f2 
    ON f1.length = f2.length
    AND f2.title != f1.title  -- OR we can use '<>'
ORDER BY 
    3;




--CROSS JOIN
--All possible combination of two tables, its the combintion of rows and not values


--cross join joins two completely different tables
SELECT 
    staff_id 
    ,store.store_id
    ,last_name
FROM
    staff
CROSS JOIN
    store



--Natural Join
    --Joins two tables when there are matching columns 
    
SELECT
*
FROM 
    payment
    NATURAL LEFT JOIN
        customer











