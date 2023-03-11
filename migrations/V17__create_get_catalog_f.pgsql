/*
Функция используется для поиска книг (вкладка 'Магазин')
*/

CREATE FUNCTION get_catalog(author text, title text, available boolean)
RETURNS TABLE (book_id int, display_name text, onhand_qty bigint)
AS $$
	SELECT book_id, display_name, onhand_qty
	  FROM catalog_v cv
	 WHERE cv.title ILIKE '%' || coalesce(title, '') || '%'
	   AND cv.full_authors_name ILIKE '%' || coalesce(author, '') || '%'
	   AND (cv.onhand_qty > 0 AND available OR available IS FALSE)
	 ORDER BY display_name;
$$ STABLE LANGUAGE sql;
