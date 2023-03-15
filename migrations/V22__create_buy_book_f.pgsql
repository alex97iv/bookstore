/*
Уменьшает количество книг с введённым book_id 
на единицу - покупка книги
*/
CREATE FUNCTION buy_book(book_id bigint) RETURNS void
AS $$
	INSERT INTO operations(book_id, qty_change)
	VALUES (buy_book.book_id, -1);
$$ VOLATILE LANGUAGE sql;
