CREATE TABLE IF NOT EXISTS books (
	book_id int  PRIMARY KEY 
				 GENERATED ALWAYS AS IDENTITY,
	title 	text NOT NULL
);