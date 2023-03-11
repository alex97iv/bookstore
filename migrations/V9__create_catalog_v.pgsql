CREATE VIEW catalog_v AS (
SELECT book_id,
	   title AS display_name
  FROM books
);