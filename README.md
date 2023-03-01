# bookstore
В данном проекте проектируется БД книжного веб-магазина, интерфейс которого представлен ниже.<br>
Основной акцент сделан на разработку интерфейса взаимодействия БД с веб-сайтом. <br>
Интерфейс представляет собой набор процедур, функций и др., написанных на <br>
процедурном расширении PostgreSQL - PL/pgSQL.

В качестве инструмента контроля версий БД используется [flyway](https://flywaydb.org/).<br>
Ниже представлены ссылки на миграции БД и скрипты, а также краткое описание вносимых изменений.

[V1__create_tables](/V1__create_tables.pgsql):<br>
*Описание миграции*: созданы основные таблицы схемы.<br>

![](/V1_db_schema.drawio.png)

[V2__create_staging_table](/V2__create_staging_table.pgsql):<br>
*Описание миграции*: создана таблица staging для импорта данных из .csv источника.<br>

[download_data script](scripts/download_data.pgsql):<br>
*Описание:* производит загрузку данных из файла [data_source.csv](/data_source.csv).

[V3__add_staging_columns](/V3__add_staging_columns.pgsql):<br>
*Описание миграции*: добавляет в таблицу staging вычисляемые хранимые столбцы *full_title* и *authors_arr*.<br>

![](/V2-V3_db_schema.drawio.png)
