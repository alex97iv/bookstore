/*
Возвращает сокращенное название книги (если исходное 
было длиннее 45 символов), при этом сокращение происходит
в меньшую сторону до последнего слова
*/

DROP FUNCTION IF EXISTS short_title(text);

CREATE FUNCTION short_title(title text) RETURNS text
AS $$
	SELECT coalesce(substring(title from '^(.{0,45})$'),
					substring(title from '^(.{0,45})\s'),
					left(title, 42) || '...')
$$ IMMUTABLE LANGUAGE sql;
