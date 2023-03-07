CREATE VIEW authors_v AS (
SELECT author_id, 
	   concat_ws(' ',first_name, middle_name, last_name) AS display_name
  FROM authors
);

CREATE VIEW catalog_v AS (
SELECT book_id,
	   title AS display_name
  FROM books
);

CREATE VIEW operations_v AS (
SELECT book_id,
	   CASE 
		    WHEN qty_change > 0 THEN 'Поступление' 
	   		ELSE 'Покупка' 
	   END AS op_type,
	   abs(qty_change) AS qty_change,
	   to_char(date_created, 'DD.MM.YYYY') AS date_created
  FROM operations
);
