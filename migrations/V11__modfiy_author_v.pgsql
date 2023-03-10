DROP VIEW authors_v;

CREATE VIEW authors_v AS (
SELECT author_id, 
	   author_name(first_name, middle_name, last_name) AS display_name
  FROM authors
);
