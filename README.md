# bookstore
В данном проекте проектируется БД для книжного веб-магазина, пользовательский интерфейс которого представлен ниже.<br>

![](/pics/shop_ui.png)

![](/pics/authors_ui.png)

![](/pics/books_ui.png)

![](/pics/catalog_ui.png)

Основной акцент в данном проекте сделан на разработку интерфейса на стороне сервера.<br>
Интерфейс представляет собой набор процедур, функций и др., написанных на процедурном<br>
расширении PostgreSQL - PL/pgSQL.

В качестве инструмента контроля версий БД используется [flyway](https://flywaydb.org/). Ниже<br>
представлены ссылки на миграции БД и скрипты, а также краткое описание вносимых изменений.

[V1__create_tables](/migrations/V1__create_tables.pgsql):<br>
*Описание миграции*: созданы основные таблицы схемы.<br>

![](/pics/V1_db_schema.drawio.png)

[V2__create_staging_table](/migrations/V2__create_staging_table.pgsql):<br>
*Описание миграции*: создана таблица staging для импорта данных из .csv источника.<br>

[download_data script](scripts/download_data.pgsql):<br>
*Описание:* производит загрузку данных из файла [data_source.csv](/data_source.csv).

[V3__add_staging_columns](/migrations/V3__add_staging_columns.pgsql):<br>
*Описание миграции*: добавляет в таблицу staging вычисляемые хранимые столбцы *full_title* и *authors_arr*.<br>

![](/pics/V2-V3_db_schema.drawio.png)

[from_stg_to_db script](scripts/from_stg_to_db.pgsql), [generate_operations_script](scripts/generate_operations.pgsql):<br>
*Описание:* скрипт *from_stg_to_db* обрабатывает данные и загружает их в таблцицы authors, books, authorship, <br>
скрипт *generate_operations* записывает в таблицу operations случайным образом сгенерированный набор операций <br> 
покупки и продажи книг.

[V4__create_views](/migrations/V3__add_staging_columns.pgsql):<br>
*Описание миграции*: создает представления *authors_v, catalog_v, books_v*.<br>

![](/pics/V4_db_schema.drawio.png)

[V5__create_author_name_func](/migrations/V5__create_author_name_func.pgsql):<br>
*Описание миграции*: создаёт функцию *author_name* для формирования имени <br>
автора. Функция принимает три параметра (фамилия, имя, отчество) и возвращает <br>
строку с фамилией и инициалами.

[V6__create_book_name_func](/migrations/V6__create_book_name_func.pgsql):<br>
*Описание миграции*: cоздаёт функцию book_name для формирования названия <br
книги.Функция принимает два параметра (идентификатор книги и заголовок) <br
и возвращает строку, составленную из заголовка и списка авторов в порядке seq_num. <br
Имя каждого автора формируется функций author_name.

