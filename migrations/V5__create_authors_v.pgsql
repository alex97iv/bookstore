CREATE VIEW authors_v AS (
SELECT author_id, 
	   concat_ws(' ',first_name, middle_name, last_name) AS display_name
  FROM authors
);