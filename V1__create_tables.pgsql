CREATE TABLE IF NOT EXISTS books (
	book_id int  PRIMARY KEY 
				 GENERATED ALWAYS AS IDENTITY,
	title 	text NOT NULL
);

CREATE TABLE IF NOT EXISTS authors (
	author_id   int  PRIMARY KEY 
					 GENERATED ALWAYS AS IDENTITY,
	last_name   text NOT NULL,
	first_name  text NOT NULL,
	middle_name text
);

CREATE TABLE IF NOT EXISTS authorship (
	book_id   int REFERENCES books(book_id),
	author_id int REFERENCES authors(author_id),
	seq_num   int NOT NULL,
	CONSTRAINT pk_authorship PRIMARY KEY (book_id, author_id)
);
	
CREATE TABLE IF NOT EXISTS operations (
	operation_id int 	PRIMARY KEY
						GENERATED ALWAYS AS IDENTITY,
	book_id 	 int 	REFERENCES books(book_id),
	qty_change	 int	NOT NULL,
	date_created date	NOT NULL
						DEFAULT current_date
);
