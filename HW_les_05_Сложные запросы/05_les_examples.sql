-- mysqldump -uroot -p123456 -P3360 shop_online > D:\GEEK_BRAINS_D\MySQL\MySQL_INTER\les_04\shop_online_DUMP_before_Les05.sql
mysqldump -uroot -p123456 -P3360 shop_online > D:\GEEK_BRAINS_D\MySQL\MySQL_INTER\les_05\shop_online_DUMP_Les05.sql

-- mysql -uroot -p123456 -P3360

use shop_online;

select catalog_id FROM products;

--*****  урок 5 - Сложные запросы *****
--********************************************************
-- 1. Типы многотабличныйх запросов и UNION 
-- 2. Вложенные запросы
-- 3. JOIN - объединение таблиц
-- 4. Внешние ключи и ссылочная целостность

-- *** часть 1 - Типы многотабличныйх запросов и UNION  ***
-- *** les_01 p_1 объединение UNION ***
CREATE TABLE rubrics (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела'
)   COMMENT = 'Разделы интернет-магазина';

INSERT INTO rubrics VALUES
	(NULL, 'Видлеокарты'),
	(NULL, 'Память');

SELECT * FROM catalogs;
SELECT * FROM rubrics;

 -- Исключает дубли
SELECT name FROM catalogs
UNION
SELECT name FROM rubrics;

-- Вместе с дублями
SELECT name FROM catalogs
UNION ALL
SELECT name FROM rubrics;

-- ALL и DISTINCT как правило взаимозаменяемы
SELECT name FROM catalogs
UNION ALL
SELECT name FROM rubrics
ORDER BY name;

-- сначала объединение, потом LIMIT
SELECT name FROM catalogs
UNION ALL
SELECT name FROM rubrics
ORDER BY name DESC
LIMIT 2;

-- LIMIT в рамках отдельно составленных запросов
(SELECT name FROM catalogs
ORDER BY name DESC
LIMIT 2)
UNION ALL
(SELECT name FROM rubrics
ORDER BY name DESC
LIMIT 2);

-- если структуры таблиц не совпадают объединить их при помощи UNION не получится, в этом случае надо
-- подгонять в selecte кол-во столбцов, оно должно совпадать у обоих таблиц.


QUERY ....
UNION
QUERY ....
UNION
QUERY ....
И т.д. так тоже можно.

-- UNION - довольно медленный, не стоит им злоупотреблять.


-- *** часть 2 - Вложенные запросы ***
-- Ключевые слова IN, ANY, SOME, ALL
-- Проверка на существование
-- Коррелированные запросы
-- Подзапросы в конструкции FROM
-- список всех товаров в разделе процессоры
SELECT * FROM catalogs;
SELECT id, name, catalog_id FROM products;

SELECT id, name, catalog_id FROM products WHERE catalog_id = 1;
-- или
SELECT
	id, name, catalog_id
FROM
	products
WHERE
	catalog_id = (SELECT id FROM catalogs WHERE name = 'Процессоры');
-- ***

-- Товар с самой высокой ценой
SELECT MAX(price) FROM products;

-- или тоже самое при помощи вложеннего запроса:
SELECT
	id, name, price, catalog_id
FROM
	products
WHERE
	price = (SELECT	MAX(price) FROM	products);

-- Товары чья цена ниже среднего
SELECT
	id, name, catalog_id
FROM
	products
WHERE
	price < (SELECT AVG(price) FROM products);

-- Извлечение для каждого товара название каталога
SELECT
	id, name, catalog_id
FROM
	products;

-- Для замены ключа catalog_id разделом, которому приндлежит этот ключ (т.е. вместо цыфры удочитаемое name представление)
SELECT
	id, name,
	(SELECT name FROM catalogs WHERE id = catalog_id) AS catalog
FROM
	products;

-- В случае кофликта имен используем квалификационные имена типо `products.catalog_id`
-- То же самое что и выше но с использ. квал. имен:
SELECT
	products.id, products.name,
	(SELECT name FROM catalogs WHERE catalogs.id = products.catalog_id) AS catalog
FROM
	products;


-- Если подзапрос использует запрос из внешнего запроса, то такой запрос называется КАРИЛИРОВАННЫМ,
-- СУБД вынужденна вычислять их для каждой строки внешнего запроса (это ресурсо-затратно для больших таблиц)
-- ***

-- Есть ли среди товаров категории мат.платы, товары которые дешевле любой товарной позиции из категории Процессоры.
-- 
SELECT
	id, name, price, catalog_id
FROM
	products
WHERE
	catalog_id = 2 AND
	price < ANY(SELECT price FROM products WHERE catalog_id = 1);


-- Для ANY существует синоним SOME, в этих словах фактически работает логика ИЛИ (OR, ||),
-- если срабатывает хотябы одно сравнение со множеством значений, выражение считается ИСТИННЫМ - TRUE

-- Иногда требуется логика AND, в этом случае использ. ключ. слово ALL

-- *** Найдем все товары из категории 'Мат.платы' которые дороже любого товара из категории 'Процессоры' ***
SELECT
	id, name, price, catalog_id
FROM
	products
WHERE
	catalog_id = 2 AND
	price > ALL(SELECT price FROM products WHERE catalog_id = 1);

-- так как результат вложенного запроса может быть пустым, для проверка данного факта используется
-- EXISTS, NOT EXISTS 
-- Извлечем те разделы каталога для которых имеется хотя бы одна товарная позиция.
SELECT * FROM catalogs
	WHERE EXISTS (SELECT * FROM products WHERE catalog_id = catalogs.id);
-- EXISTS возвращает TRUE если вложенный запрос возвращает хотя бы одну строку
-- EXISTS не использ. результат вложенного запроса, он проверяет только на кол-во возвращаемых строк вложенным запросом,
-- в связи с этим после SELECT, внутри вложенного запроса, можно указать любое допустимое имя, например 1,
-- такой запрос выполняется быстрее.
SELECT * FROM catalogs
	WHERE EXISTS (SELECT 1 FROM products WHERE catalog_id = catalogs.id);
-- ***

-- Допускается использ. отрицания NOT EXISTS
-- *** Извлечем каталоги для которыз нет ни одной товарной позиции ***
SELECT * FROM catalogs
	WHERE NOT EXISTS (SELECT 1 FROM products WHERE catalog_id = catalogs.id);


-- *** В MySQL реализованы строчные запросы которые возвращают более одного столбца ***
-- выражение перед IN назыв. конструктором строки
SELECT id, name, price, catalog_id FROM products
	WHERE (catalog_id, 4790.00) IN (SELECT id, price FROM catalogs);

-- *** Вложенный запрос можно помещать в предложение FROM ***
-- по сути Вложенный запрос можно помещать везде где допускаются ссылки на таблицы
SELECT id, name, price, catalog_id FROM products WHERE catalog_id = 1;

-- *** средняя цена товаров из категории с id = 1 ('Процессоры') *** 
SELECT AVG(price) FROM (SELECT * FROM products WHERE catalog_id = 1) AS prod;
-- !!! в ключевом слове FROM мы обязаны назначить, псевдоним при помощи AS, вложенному запросу !!!

-- Как правило вложенный запросы испоьзуют когда без низ не обойтись.
-- *** Необходимо вычислить минимальные цены в категориях и получить среднюю минимальную цену ***
-- 1. Получаем мин цену по категориям
SELECT catalog_id, MIN(price) FROM products GROUP BY catalog_id;

-- 2
SELECT
	AVG(price)
FROM
	(SELECT MIN(price) AS price
FROM
	products
GROUP BY
	catalog_id) AS prod;




-- *** часть 3 - JOIN-объединения таблиц ***
-- Декартово произведение таблиц
-- Типы соединений
-- Ключевое слово ON и USING
-- Многотабличное обновление
-- Многотабличное удаление

-- *** Декартово произведение таблиц
-- Каждая строка одной таблицы сопоставляется каждой строке другой таблицы, создавая тем самым все возможные комбинации строк обеих таблиц
CREATE TABLE tbl1 (
	value VARCHAR(255)
);

INSERT INTO tbl1 VALUES('fst1'), ('fst2'), ('fst3');

CREATE TABLE tbl2 (
	value VARCHAR(255)
);

INSERT INTO tbl2 VALUES('snd1'), ('snd2'), ('snd3');
-- DELETE FROM tbl1 WHERE value LIKE 'snd%';

-- Объединение таблиц 
SELECT * FROM tbl1, tbl2;
-- вместо запятой можно использовать JOIN
SELECT * FROM tbl1 JOIN tbl2;


-- *** Можно соединять разные таблицы
SELECT 
	p.name, p.price, c.name
FROM
	catalogs AS c
JOIN
	products AS p;
-- ***

SELECT 
	p.name, p.price, c.name
FROM
	catalogs AS c
JOIN
	products AS p
WHERE
	c.id = p.catalog_id;

-- Вместо WHERE можно использовать ON, разница в том, что ON условие работает в момент содинения,
-- т.е. промежуточная таблица сразу получается не большой,
-- а WHERE действует уже после соединения таблиц, т.е. сначала получается промежуточная таблица с Декартовым кол-вом строк,
-- а уже после срабатывает условие.
SELECT 
	p.name, p.price, c.name
FROM
	catalogs AS c
JOIN
	products AS p
ON
	c.id = p.catalog_id;


-- Самообъединение таблиц
SELECT
	*
FROM
	catalogs AS fst
JOIN
	catalogs AS snd;

-- Избавимся от дублей
SELECT
	*
FROM
	catalogs AS fst
JOIN
	catalogs AS snd
ON
	fst.id = snd.id;

-- Так как названия столбцов в таблицах совпадают в этом 
-- случае мы можем использовать ключ. слово USING(имя_столбца);
SELECT
	*
FROM
	catalogs AS fst
JOIN
	catalogs AS snd
USING(id);

-- или

SELECT
	fst.*, snd.*
FROM
	catalogs AS fst
JOIN
	catalogs AS snd
USING(id);

-- LEFT JOIN, RIGHT JOIN
SELECT
	p.name,
	p.price,
	c.name
FROM
	catalogs AS c
LEFT JOIN
	products AS p
ON 
	c.id = p.catalog_id;



-- *** Необходимо снизить на 10% стоимость товаров из
-- категории Видео карт ***
UPDATE
	catalogs
JOIN
	products
ON
	catalogs.id = products.catalog_id
SET
	price = price * 0.9
WHERE
	catalogs.name = 'Мат.платы';

-- Схожим образом действует и много табличное удаление
-- DELETE
-- 	products, catalogs
-- FROM
-- 	catalogs
-- JOIN
-- 	products
-- ON
-- 	catalogs.id = products.catalog_id
-- WHERE
-- 	catalogs.name = 'Мат.платы';
-- ***

-- DELETE
-- 	products
-- FROM
-- 	catalogs
-- JOIN
-- 	products
-- ON
-- 	catalogs.id = products.catalog_id
-- WHERE
-- 	catalogs.name = 'Процессоры';




-- *** часть 4 - JOIN-объединения таблиц ***
-- * Ограничение внешнего ключа
-- * Нарушение ссылочной целостности
-- * Ключевое слово FOREIGN KEY

-- ** Ограничение внешнего ключа

SHOW CREATE TABLE products\G

-- CASCADE
-- SET NULL
-- NO ACTION
-- RESTRICT
-- SET DEFAULT

-- * При создании таблицы
CREATE TABLE IF NOT EXISTS cities (
	id SERIAL PRIMARY KEY,
	name VARCHAR(50) NOT NULL COMMENT = 'Название города'<
	population INT(11) DEFAULT 0,
	country_id INT(11),
	CONSTRAINT fk_country_id
		FOREIGN KEY(country_id)
		REFERENCES countries(id)  
);

-- Обычно в практике внешнии ключи назначают позже, отдельно от создания таблицы

-- * Если таблица уже создана
ALTER TABLE products
ADD FOREIGN KEY (catalog_id)
REFERENCES catalogs(id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
-- вышеуказанный скрипт не сработает так как
-- !!! Типы столбцов FOREIGN KEY и PRIMARY KEY
-- Обязательно должны совпадать !!! 
ALTER TABLE products
CHANGE catalog_id catalog_id BIGINT UNSIGNED DEFAULT NULL;
-- теперь ALTER TABLE products сработает

-- сущ. и другой способ* добавить CONSTRAINT, явно
-- удалим старый ключ
ALTER TABLE products
DROP FOREIGN KEY products_ibfk_1;
-- *

-- *Другой способ
ALTER TABLE products
ADD CONSTRAINT fk_catalog_id
FOREIGN KEY (catalog_id)
REFERENCES catalogs(id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

-- В этом случае для удаления CONSTRAINT мы используем
-- имя назначенное нами ранее - fk_catalog_id
-- *


-- https://dev.mysql.com/doc/refman/5.5/en/create-table-foreign-keys.html


