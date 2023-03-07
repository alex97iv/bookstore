DO $$
DECLARE
	r record;	
	ath text;
	b_id int;
	ath_id int;
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
			-- check if author is already in the authors table
			SELECT author_id INTO ath_id
			  FROM authors
			 WHERE concat_ws(' ', first_name, middle_name, last_name) = r.authors_arr[i];

			RAISE NOTICE '%', ath_id;

			IF ath_id IS NOT NULL THEN
				-- insert with found author_id
				INSERT INTO authorship(author_id, book_id, seq_num)
				VALUES (ath_id, b_id, i);
			ELSE
				-- get new author_id
				INSERT INTO authors(first_name, middle_name, last_name)
				VALUES (
					   substring(r.authors_arr[i], '^([A-z]*)'),
					   substring(r.authors_arr[i], '\s(.*)\s'),
					   substring(r.authors_arr[i], '([A-z]*)$')
				  	   )
				  	   RETURNING author_id INTO ath_id;

				INSERT INTO authorship(author_id, book_id, seq_num)
				VALUES (ath_id, b_id, i);
			END IF;
		END LOOP;
	END LOOP;
END;
$$
