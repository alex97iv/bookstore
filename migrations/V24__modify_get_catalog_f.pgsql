/*
Функция используется для поиска книг (вкладка 'Магазин')
Данная функция реализована с использованием динамического запроса
исключительно в учебных целях!
*/


CREATE FUNCTION get_catalog(author text, title text, available boolean)
RETURNS TABLE (book_id int, display_name text, onhand_qty bigint)
AS $$
DECLARE
	authors_part text = '';
	title_part text = '';
	on_hand_part text = '';
	cmd text := '
		SELECT book_id, display_name, onhand_qty
		  FROM catalog_v cv 
		 WHERE true';
BEGIN
	IF get_catalog.author != '' THEN
		authors_part = 	format('AND full_authors_name ILIKE %L', '%' || get_catalog.author || '%'
);
	END IF;

	IF title != '' THEN
		title_part = format('AND display_name ILIKE %L', '%' || get_catalog.title || '%');
	END IF;

	IF get_catalog.available IS true THEN 
           on_hand_part = 'AND cv.onhand_qty > 0'; 
	END IF;

	RETURN QUERY EXECUTE concat_ws(' ', cmd, authors_part, title_part, 
                                       on_hand_part, 'ORDER BY display_name');
END;
$$ STABLE LANGUAGE plpgsql;
