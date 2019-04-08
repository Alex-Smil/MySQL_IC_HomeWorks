-- **************************************************************************
-- **********************  HWs les 05 exs 01 - 03   *************************
-- **************************************************************************

-- *******************************  ex01  ***********************************
-- ex01 - Составьте список пользователей users, которые осуществили хотя бы один заказ (orders) в интернет-магазине.

-- сначала необходимо привести таблицы orders в порядок:

-- ALTER TABLE
-- 	orders 
-- CHANGE COLUMN
-- 	user_id user_id BIGINT(20) UNSIGNED NOT NULL;
-- *

-- ALTER TABLE orders
-- ADD CONSTRAINT fk_user_id
-- 	FOREIGN KEY (user_id)
-- 	REFERENCES users(id)
-- 	ON DELETE RESTRICT
-- 	ON UPDATE RESTRICT;
-- *

-- ALTER TABLE
-- 	orders 
-- CHANGE COLUMN
-- 	catalog_id catalog_id BIGINT(20) UNSIGNED NOT NULL;
-- *

-- ALTER TABLE orders
-- ADD CONSTRAINT fk_catalog_id
-- 	FOREIGN KEY (catalog_id)
-- 	REFERENCES catalogs(id)
-- 	ON DELETE RESTRICT
-- 	ON UPDATE RESTRICT;
-- *

-- 	UPDATE orders
-- 	SET created_at = NOW()
-- 	WHERE created_at is NULL;

-- UPDATE orders
-- 	SET updated_at = NOW()
-- 	WHERE created_at is NULL;
-- *

-- ALTER TABLE
-- 	orders_products 
-- CHANGE COLUMN
-- 	order_id order_id BIGINT(20) UNSIGNED NOT NULL;
-- -- *

-- ALTER TABLE
-- 	orders_products 
-- CHANGE COLUMN
-- 	product_id product_id BIGINT(20) UNSIGNED NOT NULL;
-- -- *

-- ALTER TABLE
-- 	orders_products
-- ADD CONSTRAINT fk_order_id
-- 	FOREIGN KEY(order_id)
-- 	REFERENCES orders(id)
-- 	ON DELETE RESTRICT 
-- 	ON UPDATE RESTRICT;
-- -- *

-- ALTER TABLE
-- 	orders_products
-- ADD CONSTRAINT fk_order_product_id
-- 	FOREIGN KEY(product_id)
-- 	REFERENCES products(id)
-- 	ON DELETE RESTRICT 
-- 	ON UPDATE RESTRICT;
-- *

-- Внешние ключи подготовленны
-- Заполним таблицы заказами и позициями из этих заказов
-- Но прежде добавим составной первичный ключ
-- ALTER TABLE orders_products DROP id;
-- ALTER TABLE orders_products 
-- 	DROP PRIMARY KEY,
-- 	ADD PRIMARY KEY(order_id, product_id);
-- *

-- Заполним табл. зазказы(orders) и
-- табл. позиции товаров(orders_products) из заказа.
-- INSERT INTO orders(user_id)
-- VALUES (156); -- check == true
-- *

-- INSERT INTO
-- 	orders(user_id)
-- VALUES
-- 	(1), -- Геннадий
-- 	(3), -- Александр
-- 	(8); -- Олег
-- *

-- INSERT INTO
-- 	orders_products(order_id, product_id)
-- VALUES
-- 	(1, 1),
-- 	(1, 1); -- check == true
-- *

-- товары заказанные Василием
-- INSERT INTO
-- 	orders_products(order_id, product_id)
-- VALUES
-- 	(1, 1),
-- 	(1, 2);
-- *

-- товары заказанные Александром
-- INSERT INTO
-- 	orders_products(order_id, product_id)
-- VALUES
-- 	(2, 1),
-- 	(2, 2);
-- *

-- товары заказанные Олегом
-- INSERT INTO
-- 	orders_products(order_id, product_id, total)
-- VALUES
-- 	(4, 1, 1),
-- 	(4, 4, 3),
-- 	(4, 5, 2);


--  *****   РЕШЕНИЕ ex 01 (2 варианта)    *****--

-- * Простое решение ex 01* --
SELECT 
	u.id AS user_id, u.name,
	o.id AS order_id
FROM 
	users AS u
RIGHT JOIN
	orders AS o 
ON
	u.id = o.user_id;

-- * Более развернутая выборка ex 01* --
SELECT 
	u.id AS user_id, u.name AS user_name,
	op.order_id AS order_id,
	op.product_id AS product_id,
	(SELECT name FROM products WHERE id = op.product_id) AS product_name,
	op.total
FROM 
	users AS u
RIGHT JOIN
	orders AS o 
ON
	u.id = o.user_id
RIGHT JOIN
	orders_products AS op
ON
	o.id = op.order_id
ORDER BY u.name, op.order_id;


-- *******************************  ex02  ***********************************
-- ex 02 - Выведите список товаров products и разделов catalogs,
 -- который соответствует товару.
SELECT 
	p.id, p.name, p.price,
	c.id AS cat_id,
	c.name AS catalog
FROM
	products AS p
JOIN
	catalogs AS c
ON 
	p.catalog_id = c.id; 


-- *******************************  ex02  ***********************************
-- ex 03 - (по желанию) Есть таблица рейсов flights (id, from, to) и таблица городов cities (label, name).
-- Поля from, to и label содержат английские названия городов, поле name — русское.
-- Выведите список рейсов (flights) с русскими названиями городов.

-- * Подговка структуры и данных *

-- CREATE TABLE IF NOT EXISTS flights(
-- 	id SERIAL PRIMARY KEY,
-- 	`from` VARCHAR(50) NOT NULL COMMENT 'en', 
-- 	`to` VARCHAR(50) NOT NULL COMMENT 'en'
-- );

-- CREATE TABLE  IF NOT EXISTS cities(
-- 	label VARCHAR(50) PRIMARY KEY COMMENT 'en', 
-- 	name VARCHAR(50) COMMENT 'ru'
-- );

-- ALTER TABLE flights
-- ADD CONSTRAINT fk_from_label
-- FOREIGN KEY(`from`)
-- REFERENCES cities(label);

-- ALTER TABLE flights
-- ADD CONSTRAINT fk_to_label
-- FOREIGN KEY(`to`)
-- REFERENCES cities(label);

-- INSERT INTO cities VALUES
-- 	('Moscow', 'Москва'),
-- 	('Saint Petersburg', 'Санкт-Петербург'),
-- 	('Omsk', 'Омск'),
-- 	('Tomsk', 'Томск'),
-- 	('Ufa', 'Уфа');

-- INSERT INTO flights VALUES
-- 	(NULL, 'Moscow', 'Saint Petersburg'),
-- 	(NULL, 'Saint Petersburg', 'Omsk'),
-- 	(NULL, 'Omsk', 'Tomsk'),
-- 	(NULL, 'Tomsk', 'Ufa'),
-- 	(NULL, 'Ufa', 'Moscow');

-- *****  Решение ex 03  ***** --
SELECT
	id AS flight_id,
	(SELECT name FROM cities WHERE label = `from`) AS `from`,
	(SELECT name FROM cities WHERE label = `to`) AS `to`
FROM
	flights
ORDER BY
	flight_id;
	
-- *****************************
