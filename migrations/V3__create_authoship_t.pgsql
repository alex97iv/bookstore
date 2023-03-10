CREATE TABLE IF NOT EXISTS authorship (
	book_id   int REFERENCES books(book_id),
	author_id int REFERENCES authors(author_id),
	seq_num   int NOT NULL,
	CONSTRAINT pk_authorship PRIMARY KEY (book_id, author_id)
);
