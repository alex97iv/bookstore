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
