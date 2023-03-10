CREATE FUNCTION onhand_qty(book books) RETURNS bigint AS $$
	SELECT SUM(qty_change)
	  FROM operations o
     WHERE o.book_id = book.book_id;
$$ LANGUAGE SQL;
