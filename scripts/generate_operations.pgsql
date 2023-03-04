-- let's assume that equal number of all books was ordered
INSERT INTO operations(book_id, qty_change)
SELECT book_id, 1000
  FROM books;

-- some random books were bought by customers
DO $$
DECLARE
	cur CURSOR FOR (SELECT * FROM books ORDER BY book_id ASC);
	min_id int;
	max_id int;
	qty_ch int;
	id_range int;
BEGIN
	OPEN cur; -- cursor will be automaically closed at the end of transactions...
	FETCH FIRST FROM cur INTO min_id;
	FETCH LAST FROM  cur INTO max_id;
	id_range = max_id - min_id + 1;
	
	-- generate random qty_change for random books and insert it
	WITH rand_vals AS (
	SELECT floor(random() * id_range + min_id) AS rand_book_id,
		   floor(random() * 200 - 100) AS rand_qty
	  FROM generate_series(1, id_range)
	)
	
	INSERT INTO operations(book_id, qty_change)
	SELECT *
	  FROM rand_vals
	 WHERE rand_qty != 0;
END;
$$
