CREATE FUNCTION book_name(book_id int, title text) RETURNS text
AS $$
	SELECT title || '. ' || (
		   SELECT string_agg(author_name(first_name, middle_name, last_name), ', ')
			 FROM authorship a
			 JOIN authors USING(author_id)
			WHERE a.book_id = book_name.book_id
		   );
$$ IMMUTABLE LANGUAGE SQL;

DROP VIEW catalog_v;

CREATE VIEW catalog_v AS (
SELECT book_id,
	   book_name(book_id, title) AS display_name
  FROM books
);
