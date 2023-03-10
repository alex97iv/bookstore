CREATE TABLE IF NOT EXISTS authors (
	author_id   int  PRIMARY KEY 
					 GENERATED ALWAYS AS IDENTITY,
	last_name   text NOT NULL,
	first_name  text NOT NULL,
	middle_name text
);