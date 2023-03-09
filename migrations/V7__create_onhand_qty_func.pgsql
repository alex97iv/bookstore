CREATE FUNCTION onhand_qty(book books) RETURNS bigint AS $$
	SELECT SUM(qty_change)
	  FROM operations o
     WHERE o.book_id = book.book_id;
$$ LANGUAGE SQL;

DROP VIEW catalog_v;

CREATE VIEW catalog_v AS (
SELECT book_id,
	   title AS display_name,
	   books.onhand_qty
  FROM books
);
