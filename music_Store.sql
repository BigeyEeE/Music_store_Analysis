CREATE TABLE album (album_id INT,
	                title  VARCHAR(95),
	                artist_id INT
                    )

select * from album

CREATE TABLE 	album2 (
	                   album_id INT,
	                title  VARCHAR(55),
	                artist_id INT
)

select * from album2

CREATE TABLE track (
	                    track_id int,
		                name VARCHAR(190),
		                album_id INT,
		                media_type_id INT,
		                genre_id INT,
		                composer VARCHAR(190),
		                milliseconds INT,
		                bytes INT,
		                unit_price FLOAT )

SELECT * FROM artist


CREATE TABLE artist (
	                 artist_id INT,
	                 name VARCHAR(90)
)
drop table customer
CREATE TABLE customer (
	                   customer_id INT,
	                   first_name VARCHAR(15),
	                   last_name VARCHAR(15),
	                   company VARCHAR(50),
	                   address VARCHAR(50),
	                   city VARCHAR(25),
	                   state VARCHAR(10),
	                   country VARCHAR(15),
	                   postal_code VARCHAR(15),
	                   fax varchar(50),
	                   email VARCHAR(30),
	                   support_rep_id INT
)
select * from  customer

drop table employee
CREATE TABLE employee (
						    employee_id INT,
							last_name  VARCHAR(15),
							first_name VARCHAR(15),
							title VARCHAR(25),
							reports_to INT,
							levels VARCHAR(10),
						    birthdate DATE,
							hire_date DATE,
							address VARCHAR(30),
							city VARCHAR(15),
							state VARCHAR(10),
							country VARCHAR(10),
							postal_code VARCHAR(15),
							phone VARCHAR(20),
							fax VARCHAR(20),	
							email VARCHAR(30)
)
SELECT FROM employee


	

CREATE TABLE genre (
					genre_id INT,
					name VARCHAR (25)
)
SELECT * FROM INVOICE_LINE

CREATE TABLE invoice (
                       invoice_id INT,
						customer_id INT,
						invoice_date DATE,
						billing_address VARCHAR(50),
						billing_city VARCHAR(25),
						billing_state VARCHAR(15),
						billing_country VARCHAR(15),
						billing_postal_code VARCHAR(25),
						total FLOAT	
)

CREATE TABLE invoice_line (    invoice_line_id INT,
								invoice_id INT,
								track_id INT,
								unit_price FLOAT,
								quantity INT
	                                         )


CREATE TABLE media_type ( media_type_id INT,
						   name VARCHAR(50))
SELECT * FROM PLAYLIST_TRACK




CREATE TABLE playlist (playlist_id	INT,
					   name VARCHAR(50)
)

CREATE TABLE playlist_track (playlist_id INT,
						      track_id INT
)

select * from album
select * from album2
SELECT * FROM artist
select * from  customer
SELECT * FROM GENRE
SELECT * FROM EMPLOYEE
SELECT * FROM INVOICE
SELECT * FROM INVOICE_LINE
SELECT * FROM MEDIA_TYPE
SELECT * FROM PLAYLIST
SELECT * FROM PLAYLIST_TRACK
SELECT * FROM TRACK



-- MUSIC STORE ANALYSIS 
--  QUESTION 


------------------------------------------------------------------------------------------------------------------
------------------------------------------------------------------------------------------------------------------

-- Question Set 1 
--1. Who is the senior most employee based on job title? 

SELECT FIRST_NAME,
	   LAST_NAME,
	   TITLE
	  FROM EMPLOYEE
ORDER BY LEVELS DESC
LIMIT 1

--2. Which countries have the most Invoices? 
SELECT BILLING_COUNTRY,
	   COUNT(INVOICE_ID) AS TOTAL_INVOICES
       FROM INVOICE
GROUP BY 1
ORDER BY 2 DESC
LIMIT 3 

--3. What are top 3 values of total invoice? 
SELECT INVOICE_ID,
		CAST(SUM(TOTAL) AS NUMERIC (10,2))AS TOTAL_REVENUE
		FROM INVOICE
		GROUP BY 1
		ORDER BY 2 DESC
		LIMIT 3 

--4. Which city has the best customers? We would like to throw a promotional Music
--Festival in the city we made the most money. Write a query that returns one city that 
--has the highest sum of invoice totals. Return both the city name & sum of all invoice 
--totals 

SELECT BILLING_CITY AS CITY,
	   CAST(SUM(TOTAL)AS NUMERIC (10,2)) AS TOTAL_INVOICE
       FROM INVOICE 
	   GROUP BY CITY
	   ORDER BY 2 DESC 
	   LIMIT 1

--5. Who is the best customer? The customer who has spent the most money will be 
-- declared the best customer. Write a query that returns the person who has spent the 
-- most money 
SELECT C.CUSTOMER_ID,	
	   C.FIRST_NAME,
	   C.LAST_NAME,
	   CAST(SUM(I.TOTAL)AS NUMERIC (10,2)) AS TOTAL_SPENDING
	   FROM CUSTOMER C
	JOIN 
	INVOICE AS I ON 
	C.CUSTOMER_ID = I.CUSTOMER_ID
	GROUP BY 1,2,3
	ORDER BY 4 DESC
    LIMIT 5 


---------------------------------------------------------------------------------------------------------------------------------------------
-- Question Set 2 – Moderate 
---------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Write query to return the email, first name, last name, & Genre of all Rock Music
-- listeners. Return your list ordered alphabetically by email starting with 'A'.

SELECT 
    C.EMAIL,
    C.FIRST_NAME,
    C.LAST_NAME,
    G.NAME AS GENRE
FROM 
    CUSTOMER AS C
    JOIN INVOICE AS I ON C.CUSTOMER_ID = I.CUSTOMER_ID
    JOIN INVOICE_LINE AS IL ON I.INVOICE_ID = IL.INVOICE_ID
    JOIN TRACK AS T ON IL.TRACK_ID = T.TRACK_ID
    JOIN GENRE AS G ON T.GENRE_ID = G.GENRE_ID
WHERE 
    G.NAME = 'Rock' AND C.FIRST_NAME LIKE 'A%'
	ORDER BY C.EMAIL;


-- 2. Let's invite the artists who have written the most rock music in our dataset. Write a 
-- query that returns the Artist name and total track count of the top 10 rock bands 

SELECT * FROM ARTIST
SELECT * FROM TRACK
SELECT * FROM GENRE

SELECT	A.NAME AS ARTIST_NAME,
		G.NAME,
		COUNT(T.TRACK_ID) AS TOTAL_TRACK
		FROM ARTIST AS A 
		JOIN ALBUM AS AB
		ON 
		A.ARTIST_ID=AB.ARTIST_ID
		JOIN TRACK AS T
		ON
		AB.ALBUM_ID=T.ALBUM_ID
		JOIN GENRE AS G 
		ON T.GENRE_ID=G.GENRE_ID
		WHERE G.NAME = 'Rock'
		GROUP BY 1,2
		ORDER BY 3 DESC
		LIMIT 10;
		
		
-- 3. Return all the track names that have a song length longer than the average song length. 
-- Return the Name and Milliseconds for each track. Order by the song length with the 
-- longest songs listed first 
--   AVG_SONG_LENGHT-393599

SELECT	NAME,
		MILLISECONDS AS SONG_LENGHT
FROM TRACK
		WHERE MILLISECONDS > 393599
ORDER BY 2 DESC

-- ALTERNATE WAY BY SUBQUERY
	
SELECT
    NAME,
    MILLISECONDS AS SONG_LENGTH
FROM
    (
        SELECT
            NAME,
            MILLISECONDS,
            AVG(MILLISECONDS) OVER() AS AVG_SONG_LENGTH
        FROM
            TRACK
    ) AS subquery
WHERE
    MILLISECONDS > AVG_SONG_LENGTH
	ORDER BY MILLISECONDS DESC;

---------------------------------------------------------------------------------------------------------------------------------------------
-- Question Set 3 – Advance 
---------------------------------------------------------------------------------------------------------------------------------------------
-- 1. Find how much amount spent by each customer on artists? Write a query to return 
-- customer name, artist name and total spent.

select * from customer
select * from artist
select * from invoice_line

	-- solution by join 
	
select 	concat(c.first_name,' ',c.last_name) as customer_name,
		a.name as artist,
		cast(sum(il.unit_price * il.quantity) as numeric(10,2)) as total_spent
	from customer c
	join 
	invoice as i on
	c.customer_id = i.customer_id
	join
	invoice_line as il on
	i.invoice_id = il.invoice_id 
	join 
	track as t on 
	il.track_id = t.track_id
	join 
	album as ab on 
	t.album_id = ab.album_id
	join artist as a on 
	ab.artist_id = a.artist_id	
	where a.name = 'Queen'      -- most spend on artists
	group by 1,2
    ORDER BY 
   total_spent desc;

-- solution through cte 

WITH best_selling_artist AS (
	SELECT artist.artist_id AS artist_id, artist.name AS artist_name, SUM(invoice_line.unit_price*invoice_line.quantity) AS total_sales
	FROM invoice_line
	JOIN track ON track.track_id = invoice_line.track_id
	JOIN album ON album.album_id = track.album_id
	JOIN artist ON artist.artist_id = album.artist_id
	GROUP BY 1,2
	ORDER BY 3 DESC
	LIMIT 1
)
SELECT c.customer_id, c.first_name, c.last_name, bsa.artist_name, SUM(il.unit_price*il.quantity) AS amount_spent
FROM invoice i
JOIN customer c ON c.customer_id = i.customer_id
JOIN invoice_line il ON il.invoice_id = i.invoice_id
JOIN track t ON t.track_id = il.track_id
JOIN album alb ON alb.album_id = t.album_id
JOIN best_selling_artist bsa ON bsa.artist_id = alb.artist_id
GROUP BY 1,2,3,4
ORDER BY 5 DESC;
