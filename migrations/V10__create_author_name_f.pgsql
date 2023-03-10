CREATE FUNCTION author_name(first_name text, middle_name text, last_name text) 
RETURNS text AS $$
	SELECT left(first_name, 1) || '.' ||
		   coalesce(left(middle_name, 1) || '. ', ' ') ||  
		   last_name; 
$$ IMMUTABLE LANGUAGE SQL;