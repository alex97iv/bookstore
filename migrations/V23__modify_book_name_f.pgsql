/*
Если у книги больше 2-х авторов, то выводятся только 2 первых
*/


DROP VIEW IF EXISTS catalog_v;


DROP FUNCTION IF EXISTS book_name(book_id int, title text);


-- plpgsql version
CREATE FUNCTION book_name(book_id int, title text) RETURNS text
AS $$
DECLARE
	title text := short_title(book_name.title) || '. ';	
	rec record;
BEGIN
	FOR rec IN (
		SELECT first_name, middle_name, last_name, seq_num
		  FROM authors 
		  JOIN authorship auth USING(author_id)
		 WHERE auth.book_id = book_name.book_id
	)
	LOOP
		EXIT WHEN (rec.seq_num > 2);
		title := title || author_name(rec.first_name, rec.middle_name, rec.last_name) || ', ';
	END LOOP;
	title := rtrim(title, ', ');
	IF rec.seq_num > 2 THEN
		title := title || ' and others ...';
	END IF;
	RETURN title;
END;
$$ STABLE LANGUAGE plpgsql;


-- sql version
-- CREATE FUNCTION book_name(book_id int, title text) RETURNS text
-- AS $$
-- SELECT short_title(book_name.title)
-- 	   || '. ' 
-- 	   || string_agg(author_name(first_name, middle_name, last_name), ', ')
-- 	      FILTER (WHERE ash.seq_num < 3) 
-- 	   || (
-- 		  CASE 
-- 	   	  WHEN max(ash.seq_num) > 2 THEN
-- 		       ' and others...'
-- 	   	  ELSE ''
-- 		   END)
--   FROM authors ath
--   JOIN authorship ash 
-- 	ON ath.author_id = ash.author_id
--  WHERE ash.book_id = book_name.book_id;
-- $$ STABLE LANGUAGE sql;


CREATE VIEW catalog_v AS (
SELECT book_id,
	   book_name(book_id, title) AS display_name,
	   books.onhand_qty,
	   title,
	   concat_ws(', ', first_name, middle_name, last_name) AS full_authors_name
  FROM books
  JOIN authorship USING(book_id)
  JOIN authors 	  USING(author_id)
);
