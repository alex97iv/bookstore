ALTER TABLE staging 
  ADD COLUMN full_title text GENERATED ALWAYS AS (title || coalesce('. ' || subtitle, '')) STORED;
  
ALTER TABLE staging
  ADD COLUMN authors_arr text ARRAY GENERATED ALWAYS AS (string_to_array(authors, ';'))	STORED;