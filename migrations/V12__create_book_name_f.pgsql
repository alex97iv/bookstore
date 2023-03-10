CREATE FUNCTION book_name(book_id int, title text) RETURNS text
AS $$
	SELECT title || '. ' || (
		   SELECT string_agg(author_name(first_name, middle_name, last_name), ', ' ORDER BY seq_num)
			 FROM authorship a
			 JOIN authors USING(author_id)
			WHERE a.book_id = book_name.book_id
		   );
$$ IMMUTABLE LANGUAGE SQL;
