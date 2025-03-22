--/*--USER MANAGEMENT*/

--Creating a user with a password
CREATE USER mia 
WITH PASSWORD 'mia123'

--Creating a role 
CREATE ROLE analyst_emp 

--Granting the role of an analst employee to the user mia
GRANT analyst_emp TO mia


--Granting the priviledge to select all tables to the role 
GRANT SELECT 
ON ALL TABLES IN SCHEMA greencycles
TO analyst_emp;

--Granting spepcific priviledge to the role 
GRANT INSERT, UPDATE
ON TABLE employee TO analyst_emp;

--Now the role can also create a database
ALTER ROLE analyst_emp
WITH CREATEDB;

--we are granting all priviledge including delete to the role 
GRANT ALL
ON ALL TABLES IN SCHEMA greencycles
TO analyst_emp;
----------------------------------------------------------------------------------

--INDEX
    --Increases performance of our query
    --types of 

--Example of a query that tkes time 

SELECT 
    (
    SELECT 
        AVG(amount)
    FROM 
        payment p2
    WHERE 
        p2.rental_id=p1.rental_id)
    FROM 
        payment p1;
    
    
--Lets create an INDEX on the payment table 
CREATE INDEX 
    index_rental_id_payment
    ON payment(rental_id) 

--Drop the index to see how fast the query runs 
DROP INDEX index_rental_id_payment


--Another example using the demo database 
SET search_path TO demo;

SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
                  FROM flights f1
                   WHERE f1.departure_airport=f2.departure_airport
                   )
                   
--Where should our index be created 
    --Indexes should be created on departure and flight_no as a best practice is to select columns that are used as filters
CREATE INDEX 
    indexx_departure_airport_&_flight_no
    ON flights(departure_airport, flight_no)
DROP INDEX indexx_flight
    
--EXECUTION PLAN 
    --To see the execution plan before the query is ran,
    -- use the EXPLAIN  and to see exactly what was done in a query, use EXPLAIN ANALYZE
EXPLAIN ANALYZE
SELECT * FROM flights f2
WHERE flight_no < (SELECT MAX(flight_no)
                  FROM flights f1
                   WHERE f1.departure_airport=f2.departure_airport
                   )
    
    
    
    
    
    
    
    
    
    
    
    



