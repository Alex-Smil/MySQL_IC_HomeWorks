-- mysqldump -uroot -p123456 -P3360 shop_online > D:\GEEK_BRAINS_D\MySQL\MySQL_INTER\les_04\shop_online_DUMP_before_Les04.sql

-- mysql -uroot -p123456 -P3360

use shop_online;

select catalog_id FROM products;

--*****  у.4 Агрегация данных ч.1 ГРУППИРОВКА ДАННЫХ *****
--********************************************************

select DISTINCT catalog_id FROM products;
-- тоже самое
select catalog_id FROM products GROUP BY catalog_id;

select id, name, SUBSTRING(birthday_at, 1, 3)  AS decade FROM users;
-- практически тоже самое
select id, name, DATE_FORMAT(birthday_at, '%Y') FROM users;


select id, name, SUBSTRING(birthday_at, 1, 3) AS decade FROM users ORDER BY decade;

select id, name, SUBSTRING(birthday_at, 1, 3) AS decade FROM users GROUP BY decade;

SELECT COUNT(*), SUBSTRING(birthday_at, 1, 3) AS decade
FROM users
GROUP BY decade
ORDER BY decade DESC;

SELECT COUNT(*) AS total, SUBSTRING(birthday_at, 1, 3) AS decade
FROM users
GROUP BY decade
ORDER BY total;

SELECT COUNT(*) FROM users;

-- Посмотреть содержимое группы можно при помощи:
SELECT 
    GROUP_CONCAT(name),
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY 
    decade;

-- ***

SELECT 
    GROUP_CONCAT(name SEPARATOR '***'),
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY 
    decade;

-- ***

SELECT 
    GROUP_CONCAT(name ORDER BY name DESC SEPARATOR ' '),
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY 
    decade;

-- ***

SELECT 
    GROUP_CONCAT(name ORDER BY name DESC SEPARATOR ' '),
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY 
    decade
ORDER BY 
    decade DESC;

-- !!! GROUP CONCAT Имеет огрничение на 1000 элементов в строке !!!
-- чтобы снять это граничение надо поменять параметры сервера: group concat max len


--*****  у.4 Агрегация данных ч.2 АГРЕГАЦИОННЫЕ ФУНКЦИИ *****
--***********************************************************
-- 1. COUNT()
-- 2. MAX() MIN()
-- 3. AVG()
-- 4. SUM() значений столбца

SELECT COUNT(*) FROM catalogs; -- null тоже считаеться

SELECT catalog_id FROM products;

SELECT catalog_id FROM products GROUP BY catalog_id;

SELECT COUNT(catalog_id) FROM products GROUP BY catalog_id;

SELECT catalog_id, COUNT(catalog_id) AS total FROM products GROUP BY catalog_id;

SELECT catalog_id, COUNT(catalog_id) AS total FROM products GROUP BY catalog_id;

-- Реакция агригационных функций на NULL

CREATE TABLE tbl (
    id INT NOT NULL,
    value INT DEFAULT NULL
);

INSERT INTO tbl VALUES
    (1, 230),
    (2, NULL),
    (3, 405),
    (4, NULL);

SELECT COUNT(id), COUNT(value) FROM tbl; --COUNT(value) у меня null посчитался

SELECT id, catalog_id FROM products;

SELECT
    COUNT(id) AS total_ids,
    COUNT(catalog_id) AS total_catalogs_ids
FROM
    products;

--  ТОлько уникальные занчения
SELECT
    COUNT(DISTINCT id) AS total_ids,
    COUNT(DISTINCT catalog_id) AS total_catalogs_ids
FROM
    products;

-- MIN() MAX()

SELECT 
    MIN(price) AS min,
    MAX(price) AS max 
FROM
    products;


-- max в рамках одной группы
SELECT 
    catalog_id,
    MIN(price) AS min,
    MAX(price) AS max 
FROM
    products
GROUP BY
    catalog_id;

-- !!! АГРГЕЦИОННЫЕ ФУНКЦИИ МОЖНО ПРИМЕНЯТЬ ТОЛЬКО ПОСЛЕ SELECT !!!

SELECT * FROM PRODUCTS WHERE price = MAX(price); -- Это не сработает

-- MAX цена
select id, name, price FROM products ORDER BY price DESC LIMIT 1;

-- AVG() всей таблицы как одной группы
SELECT AVG(price) FROM products;

SELECT ROUND(AVG(price), 2) FROM products;

SELECT
    catalog_id,
    ROUND(AVG(price), 2)
FROM 
    products 
GROUP BY 
    catalog_id;

-- внутри агригационных функций допускается использование вычисляемых значений
-- Надбавка 20% к price (только для вывода)
SELECT
    catalog_id,
    ROUND(AVG(price) * 1.2, 2)
FROM 
    products 
GROUP BY 
    catalog_id;

-- 4. SUM() значений столбца
-- Сумма всех значений столбцов
SELECT SUM(price) FROM products; -- NULL здесь не учитываеться


-- Сумма для групп
SELECT
    catalog_id,
    SUM(price)
FROM 
    products 
GROUP BY 
    catalog_id;


--*************  у.4 Агрегация данных ***********************
--************ ч.3 СПЕЦИАЛЬНЫЕ ВОЗМОЖНОСТИ GROUP BY *********
--***** ключевые слова влияющие на работу GROUP BY **********
--***********************************************************
-- 1. условие HAVING
-- 2. получение уникального значения
-- 3. ANY_VALUE()
-- 4. Конструкция WITH ROLLUP

-- Агрегационные функции предназначены для получения результатов 
-- каждой из групп

SELECT
    GROUP_CONCAT(name),
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY
    decade;

-- ***

SELECT
    COUNT(*) AS total,
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY
    decade;

-- ***

SELECT
    COUNT(*) AS total,
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY
    decade
ORDER BY 
    total;

-- Агрегационные значения нельзя использовать в конструкции WHERE
-- выход из ситуации HAVING <stat>;
SELECT
    COUNT(*) AS total,
    SUBSTRING(birthday_at, 1, 3) AS decade
FROM
    users
GROUP BY
    decade
HAVING
    total >= 2;

-- HAVING можно использ. вне GROUP BY, здесь каждая строка как отдельная группа
SELECT
    *
FROM
    users
HAVING
    birthday_at >= '1990-01-01';

-- ***

TRUNCATE products;

INSERT INTO
    products (name, description, price, catalog_id)
VALUES
    ('Intel Core i3-8100','Процессор для настольных ПК',7890.00,1),
    ('AMD FX-8320E','Процессор для настольных ПК',4780.00,1),
    ('AMD FX-8320','Процессор для настольных ПК',7120.00,1),
    ('Gigabyte H310M S2H, H310, Socket 1151-V2','Материнская плата Gigabyte H310M S2H, H310, Socket 1151-V2',4790.00,2),
    ('MSI B250M GAMING PRO','Материнская плата MSI B250M GAMING PRO',4554.00,2),
    ('One More prod','Good prod',10000.00,2);
-- 2 раза

SELECT id, name, catalog_id FROM products;

-- Видим много дублей, сущ. разные спопсобы избавиться от таких дублей
-- 1 из вар. через промежуточную таблицу
SELECT 
    name, description, price, catalog_id
FROM
    products
GROUP BY
    name, description, price, catalog_id; 

-- ***

CREATE TABLE products_new (
    id SERIAL PRIMARY KEY,
    name varchar(255) COMMENT 'Название',
    description text COMMENT 'Описание',
    price decimal(11,2) COMMENT 'Цена',
    catalog_id int unsigned,
    created_at datetime DEFAULT CURRENT_TIMESTAMP,
    updated_at datetime DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_catalog_id(catalog_id)
) COMMENT = 'Товарные позиции';

-- вставляем только уникальные занчения
INSERT INTO
    products_new
SELECT 
    NULL, name, description, price, catalog_id, NOW(), NOW()
FROM
    products 
GROUP BY
    name, description, price, catalog_id;
    
-- ***

DROP TABLE products;

ALTER TABLE products_new RENAME products; 

-- Для группировки можно использовать только вычисляемые значения

SELECT name, birthday_at FROM users;

INSERT INTO 
    users (name, birthday_at)
VALUES
    ('Светлана', '1988-02-04'),
    ('Олег', '1998-03-20'),
    ('Юлия', '2006-07-12');


-- Извлечем года на которые приходятся дни рождения
SELECT 
    YEAR(birthday_at)
FROM
    users
ORDER BY
    birthday_at;

-- // ----- // без дубликатов
SELECT 
    YEAR(birthday_at) AS birthday_year
FROM
    users
GROUP BY
    birthday_year
ORDER BY
    birthday_year;

-- ***

SELECT 
    name, -- По уроку из-за добавления name, все должно сломаться, но у меня работает.
    YEAR(birthday_at) AS birthday_year
FROM
    users
GROUP BY
    birthday_year
ORDER BY
    birthday_year;

-- ANY_VALUE() - возвращает случайное значение из группы
SELECT 
    ANY_VALUE(name),
    YEAR(birthday_at) AS birthday_year
FROM
    users
GROUP BY
    birthday_year
ORDER BY
    birthday_year;

-- WITH ROLLUP

SELECT
    SUBSTRING(birthday_at, 1, 3) AS decade,
    COUNT(*)
FROM
    users
GROUP BY
    decade;

-- Добавляем в конец строку с результирующей суммой всех значений 
-- попавших в выборку при помощи WITH ROLLUP

SELECT
    SUBSTRING(birthday_at, 1, 3) AS decade,
    COUNT(*)
FROM
    users
GROUP BY
    decade
WITH ROLLUP;