CREATE FUNCTION author_name(first_name text, middle_name text, last_name text) 
RETURNS text AS $$
	SELECT left(first_name, 1) || '.' ||
		   coalesce(left(middle_name, 1) || '. ', ' ') ||  
		   last_name; 
$$ IMMUTABLE LANGUAGE SQL;

DROP VIEW authors_v;

CREATE VIEW authors_v AS (
SELECT author_id, 
	   author_name(first_name, middle_name, last_name) AS display_name
  FROM authors
);
