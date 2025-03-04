
--UPDATE COMMAND

--Update all rental price that are 0.99 to 1.99 

SELECT * FROM customer
WHERE address_id = 5;

UPDATE payment 
SET amount = 1.99
WHERE amount = 0.99; 


ALTER TABLE customer 
ADD COLUMN initials VARCHAR(10);

UPDATE  customer 
SET initials = CONCAT(LEFT(first_name, 1),'.',LEFT(last_name, 1), '.');  -- you can use comma OR || FOR concatenation

---------------------------------------------------------------------------------------------------
--CREATE TABLE AS  & CREATE VIEW AS 

CREATE VIEW customer_spendings 
AS
SELECT 
  CONCAT(first_name||' '||last_name) AS name
  ,sum(p.amount)"Rules"
FROM customer c
JOIN payment p ON c.customer_id = p.customer_id 
GROUP BY 1;

DROP VIEW customer_spendings;



------------------------------------------------------------------------------------------------------

/* CHALLENGE
 Create a view called films_category that shows a list of the film titles including their title, length and category name ordered descendingly by the length.

Filter the results to only the movies in the category 'Action' and 'Comedy'.
 */

CREATE VIEW films_category
AS
SELECT 
    f.title
    ,f.length
    ,c."name"    
FROM
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id 
    INNER JOIN category c ON fc.category_id =c.category_id
WHERE
    c."name" IN ('Action', 'Comedy')
ORDER BY
    f.length DESC;
    

ALTER VIEW films_category 
RENAME TO v_films_category

ALTER VIEW v_films_category 
RENAME COLUMN title TO film_title

CREATE OR REPLACE VIEW v_films_category
AS
SELECT 
    f.title AS film_title  ---IN this CASE since we already renamed the COLUMN previously, we need TO use an ALIAS TO reference it 
    ,f.length
    ,c."name"
    ,f.rating 
FROM
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id 
    INNER JOIN category c ON fc.category_id =c.category_id
WHERE
    c."name" IN ('Action', 'Comedy')
ORDER BY
    f.length DESC;

----------------------------------------------------------------------------------------------------------------------
--MATERIALIZED VIEWS 

CREATE MATERIALIZED VIEW mv_films_category
AS
SELECT 
    f.title
    ,f.length
    ,c."name"    
FROM
    film f
    INNER JOIN film_category fc ON f.film_id = fc.film_id 
    INNER JOIN category c ON fc.category_id =c.category_id
WHERE
    c."name" IN ('Action', 'Comedy')
ORDER BY
    f.length DESC
    







