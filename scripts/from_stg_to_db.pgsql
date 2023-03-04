DO $$
DECLARE
	r record;	
	ath text;
	b_id int;
	ath_id int;
	ns text[];
BEGIN
	FOR r IN
		SELECT full_title, authors_arr
		  FROM staging
		 WHERE authors IS NOT NULL
	LOOP
		INSERT INTO books(title) VALUES (r.full_title) 
			   RETURNING book_id INTO b_id;
		-- insert data into authors, authorship tables for every author
		FOR i IN  array_lower(r.authors_arr,1)..array_upper(r.authors_arr,1)
		LOOP
			ns := string_to_array(r.authors_arr[i], ' ');
			INSERT INTO authors(first_name, middle_name, last_name)
			VALUES (coalesce(ns[array_lower(ns,1)]::text,''), 
				   coalesce(array_to_string(ns[array_lower(ns,1)+1:
							array_upper(ns,1)-1], ' '),''), 
				   coalesce(ns[array_upper(ns,1)]::text,''))
				   RETURNING author_id INTO ath_id;

			INSERT INTO authorship(author_id, book_id, seq_num)
			VALUES (ath_id, b_id, i);
		END LOOP;
	END LOOP;
END;
$$
