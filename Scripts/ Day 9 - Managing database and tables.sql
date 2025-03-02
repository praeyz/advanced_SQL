-- Querying an Array 

SELECT 
count(*) 
FROM film 
WHERE 'Behind the Scenes' = ANY(special_features)
---------------------------------------------------------------------------

CREATE TABLE
    onlinesales(
        transaction_id SERIAL PRIMARY KEY,
        customer_id INT REFERENCES customer(customer_id),
        film_id INT REFERENCES film(film_id),
        amount DECIMAL(5,2) NOT NULL CHECK(amount >= 0.00 AND amount<= 999.99),
        promotion_code VARCHAR(10) DEFAULT 'None' 
    );

CREATE TABLE 
    director(
        director_id SERIAL PRIMARY KEY, 
        director_account_name VARCHAR(20) UNIQUE,
        first_name VARCHAR(50),
        last_name VARCHAR(50) DEFAULT 'NOT SPECIFIED',
        date_of_birth DATE,
        address_id INT REFERENCES address(address_id)
    );

INSERT INTO
    onlinesales 
        VALUES(2,225,231,12.99,'JULYPROMO'),(3,119,53,15.99,'SUMMERDEAL');
---------------------------------------------------------------------------------
    
ALTER TABLE
    director 
        ALTER COLUMN director_account_name TYPE VARCHAR(30)
        ALTER COLUMN last_name DROP DEFAULT
        ALTER COLUMN last_name SET NOT NULL
        ADD COLUMN email VARCHAR(40)
        RENAME COLUMN director_account_name TO account_name;
        
ALTER TABLE
    director
        RENAME TO directors;
    
-----------------------------------------------------------------------------------
    
    --THE CHECK CONSTRAINT 

--its a good practice to always name your check constraint 

CREATE TABLE
    songs(
    song_id SERIAL PRIMARY KEY,
    song_name VARCHAR(30) NOT NULL,
    genre VARCHAR(30) DEFAULT 'NOT DEFINED',
    price DECIMAL(4,2) CONSTRAINT price_check CHECK(price >= 1.99),
    release_date DATE CONSTRAINT date_check CHECK(release_date BETWEEN '01-01-1950' AND CURRENT_DATE)
    );

--Inserting into specific columns in the songs table 
INSERT INTO songs(song_name, price, release_date)
VALUES('MYSQL SONG', 3.99, '2022-09-01');

ALTER TABLE songs
DROP CONSTRAINT price_check;

--Removing rows that violates the check constraint 
DELETE FROM songs 
WHERE song_id = 2;

--Adding the check contraints back 
ALTER TABLE songs 
ADD CONSTRAINT price_check CHECK(price >= 1.99);




