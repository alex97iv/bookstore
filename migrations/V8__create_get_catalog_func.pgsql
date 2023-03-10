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

CREATE FUNCTION get_catalog(author text, title text, available boolean)
RETURNS TABLE (book_id int, display_name text, onhand_qty int)
AS $$
	SELECT book_id, display_name, onhand_qty
	  FROM catalog_v
	 WHER
$$ LANGUAGE sql;
