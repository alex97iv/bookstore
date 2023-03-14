/*
Для сокращения длинных заголовков книг добавлена функция short_title(text)
*/
DROP VIEW IF EXISTS catalog_v;

DROP FUNCTION IF EXISTS book_name(book_id int, title text);

CREATE FUNCTION book_name(book_id int, title text) RETURNS text
AS $$
	SELECT short_title(title) || (
		   SELECT string_agg(author_name(first_name, middle_name, last_name), ', ' ORDER BY seq_num)
			 FROM authorship a
			 JOIN authors USING(author_id)
			WHERE a.book_id = book_name.book_id
		   );
$$ IMMUTABLE LANGUAGE SQL;

CREATE VIEW catalog_v AS (
SELECT book_id,
	   book_name(book_id, title) AS display_name,
	   books.onhand_qty,
	   title,
	   concat_ws(', ', first_name, middle_name, last_name) AS full_authors_name
  FROM books
  JOIN authorship USING(book_id)
  JOIN authors USING(author_id)
);
