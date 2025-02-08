
--practiced on using schemas and alias

SELECT DISTINCT 
ga.district
FROM greencycles.address ga


SELECT
gr.rental_date
FROM greencycles.rental gr
ORDER BY gr.rental_id DESC
LIMIT 10

SELECT 
count(gf.film_id) AS no_of_films
FROM greencycles.film gf

SELECT
count(DISTINCT gc.last_name) AS no_of_districts
FROM greencycles.customer gc

