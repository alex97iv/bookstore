DROP VIEW catalog_v;

CREATE VIEW catalog_v AS (
SELECT book_id,
	   book_name(book_id, title) AS display_name,
	   books.onhand_qty
  FROM books
);
