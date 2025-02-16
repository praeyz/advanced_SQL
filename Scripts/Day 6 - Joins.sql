--INNER JOINS -  ONLY ROWS that appers IN the BOTH TABLES 

/*

SELECT * FROM TableA
INNER JOIN TableB
ON TableA.employee = TableB.employee

1.we always need a common colum/reference
2.only rows where reference column value is in both tables
3.The order does not matter
4.Repeated values would also be repeated

*/


SELECT 
    count(*) AS "count",
    s.fare_conditions  AS "fair conditions"
FROM boarding_passes bp 
    INNER JOIN flights f ON bp.flight_id = f.flight_id 
    INNER JOIN seats s ON bp.seat_no = s.seat_no AND f.aircraft_code =s.aircraft_code 
GROUP BY 
    s.fare_conditions
ORDER BY 
    1 DESC;

    
/*LEFT OUTER JOIN -- Includes everthing IN the LEFT TABLE AND ONLY the matching ROWS IN the RIGHT COLUMN 
 * to know the rows which doesnt appear in the right table use where table.matching column is null*/
    
/*Question : what line(A,B ..) has been booked the most? make sure all seats are included even if they have not been 
chosen before ? Are there seats that has not been booked before*/
    
SELECT 
    RIGHT(s.seat_no,1) AS "seat rows",
    count(*) 
FROM seats s 
    LEFT OUTER JOIN boarding_passes bp
    ON s.seat_no = bp.seat_no 
GROUP BY 
    RIGHT(s.seat_no,1)
ORDER BY 
    count(*) DESC;


SET SEARCH_PATH TO greencycles

SELECT
    *,
    c.first_name,
    c.last_name,
    a.phone,
    a.district 
FROM 
    customer c
    RIGHT JOIN address a 
    ON c.address_id = a.address_id
WHERE 
    c.customer_id IS NULL;

    
    
--JOINING ON MULTIPLE CONDITIONS     
SET SEARCH_PATH TO Demo
    
SELECT
    seat_no,
    ROUND(AVG(amount),2) AS "average price"
FROM 
    boarding_passes bp
    LEFT JOIN ticket_flights tf
    ON bp.ticket_no = tf.ticket_no 
    AND bp.flight_id =tf.flight_id   ---/*Thesame ticket_no can appear IN different seats, hence multiple JOIN conditions*/
GROUP BY 
    1
ORDER BY 
    2 DESC;
    
    
    
    
--JOINING MULTIPLE TABLES 
    
SELECT 
    tf.ticket_no,
    tf.flight_id,
    passenger_name,
    scheduled_departure 
FROM tickets t 
    INNER JOIN ticket_flights tf ON t.ticket_no = tf.ticket_no 
    INNER JOIN flights f ON tf.flight_id = f.flight_id;



SET SEARCH_PATH TO greencycles

SELECT 
    first_name,
    last_name,
    email,
    country
FROM 
    customer cu
    INNER JOIN address a ON cu.address_id = a.address_id 
    INNER JOIN city c  ON c.city_id = a.city_id 
    INNER JOIN country co ON co.country_id  = c.country_id
    --AND country = 'Brazil'   --These outputs faster than the WHERE clause
WHERE 
    country = 'Brazil'
ORDER BY 
    1,2;
    