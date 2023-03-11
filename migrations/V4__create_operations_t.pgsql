CREATE TABLE IF NOT EXISTS operations (
	operation_id int 	PRIMARY KEY
						GENERATED ALWAYS AS IDENTITY,
	book_id 	 int 	REFERENCES books(book_id),
	qty_change	 int	NOT NULL,
	date_created date	NOT NULL
						DEFAULT current_date
);
