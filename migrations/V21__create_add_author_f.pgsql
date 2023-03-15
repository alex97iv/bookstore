/*
Добавляет автора в таблицу auhtors и
возваращает author_id
*/
CREATE FUNCTION add_author(last_name text, first_name text, middle_name text)
RETURNS bigint AS $$
DECLARE
	author_id bigint;
BEGIN
	INSERT INTO authors(last_name, first_name, middle_name) 
	VALUES (last_name, first_name, middle_name) RETURNING authors.author_id INTO author_id;
	RETURN author_id;
END;
$$ VOLATILE LANGUAGE plpgsql;
