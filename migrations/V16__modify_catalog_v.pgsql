DROP VIEW catalog_v;

CREATE VIEW catalog_v AS (
SELECT book_id,
	   book_name(book_id, title) AS display_name,
	   books.onhand_qty,
	   title,
	   concat_ws(', ', first_name, middle_name, last_name) AS full_authors_name,
  FROM books
  JOIN authorship USING(book_id)
  JOIN authors USING(author_id)
);
