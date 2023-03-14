/*
Функция выводит сокращенное название книги, если
исходное название было больше 45 символов
*/

CREATE FUNCTION short_title(title text) RETURNS text
AS $$
	SELECT CASE 
		   WHEN length(title) > 45
		   THEN left(title, 42) || '...'
		   ELSE title
		    END CASE
$$ IMMUTABLE LANGUAGE sql;
