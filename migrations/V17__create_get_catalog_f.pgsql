CREATE FUNCTION get_catalog(author text, title text, available boolean)
RETURNS TABLE (book_id int, display_name text, onhand_qty int)
AS $$
	SELECT book_id, display_name, onhand_qty
	  FROM catalog_v
	 WHER
$$ LANGUAGE sql;
