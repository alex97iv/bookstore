COPY staging 
FROM '/home/student/bookstore/data_source.csv'
WITH (FORMAT csv,
	 DELIMITER ',',
	 HEADER true)
