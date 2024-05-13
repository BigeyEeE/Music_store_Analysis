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

