/*
Функция используется для поиска книг (вкладка 'Магазин')
Данная функция реализована с использованием динамического запроса
исключительно в учебных целях!
*/

ROLLBACK; BEGIN; 

DROP FUNCTION IF EXISTS get_catalog(author text, title text, available boolean);

CREATE FUNCTION get_catalog(author text, title text, available boolean)
RETURNS TABLE (book_id int, display_name text, onhand_qty bigint)
AS $$
DECLARE
	cond_1 text = '';
	cond_2 text = '';
	cond_3 text = '';

	cmd text := '
		SELECT book_id, display_name, onhand_qty
		  FROM catalog_v cv 
		 WHERE true';
BEGIN
	IF author != '' THEN
		cond_1 = E'AND cv.full_authors_name ILIKE \'%\' || coalesce(author, \'\') || \'%\'';
	END IF;

	IF title != '' THEN
		cond_2 = E'AND cv.title ILIKE \'%\' || coalesce(title, \'\') || \'%\'';
	END IF;

	IF available != '' THEN
		cond_3 = E'AND (cv.onhand_qty > 0 AND available OR available IS FALSE)';
	END IF;
	RETURN QUERY EXECUTE concat_ws(' ', cmd, cond_1, cond_2, cond_3, 'ORDER BY display_name');
END;
$$ STABLE LANGUAGE plpgsql;
