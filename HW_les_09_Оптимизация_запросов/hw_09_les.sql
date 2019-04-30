
mysql -uroot -p123456 -P3360
use shop_online;

-- ********************************************************************************************
-- ************************************  ex 01  ***********************************************
-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, 
-- catalogs и products в таблицу logs помещается время и дата создания записи, название таблицы,
-- идентификатор первичного ключа и содержимое поля name.

-- !!! Archive - не поддерживает индексы, поэтому при определении
-- таблицы первичный ключ не указывается. !!!

DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATETIME NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;


-- **********  TRIGGER ON users  **********
DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON catalogs  **********
DROP TRIGGER IF EXISTS watchlog_catalogs;
delimiter //
CREATE TRIGGER watchlog_catalogs AFTER INSERT ON catalogs
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'catalogs', NEW.id, NEW.name);
END //
delimiter ;


-- **********  TRIGGER ON products  **********
delimiter //
CREATE TRIGGER watchlog_products AFTER INSERT ON products
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'products', NEW.id, NEW.name);
END //
delimiter ;


-- **********  Tests for users  **********
SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Кнехт', '1900-01-01');

SELECT * FROM users;
SELECT * FROM logs;

INSERT INTO users (name, birthday_at)
VALUES ('Liu Kangh', '1900-01-01'),
		('Sub-Zero', '1103-01-01'),
		('Scorpion', '1103-01-01'),
		('Raiden', '0000-00-01');

SELECT * FROM users;
SELECT * FROM logs;


-- **********  Tests for catalogs  **********
SELECT * FROM catalogs;
SELECT * FROM logs;

INSERT INTO catalogs (name)
VALUES ('Оперативная память'),
		('Куллера'),
		('Аксессуары');

SELECT * FROM catalogs;
SELECT * FROM logs;


-- **********  Tests for products  **********
SELECT * FROM products;
SELECT * FROM logs;

INSERT INTO products (name, description, price, catalog_id)
VALUES ('PATRIOT PSD34G13332', 'Оперативная память', 3000.00, 13),
		('DARK ROCK PRO 4 (BK022)', 'Куллера', 500.00, 14),
		('Коврик', 'Коврик для мыши', 150.00, 15);

SELECT * FROM products;
SELECT * FROM logs;




-- ********************************************************************************************
-- ************************************  ex 02  ***********************************************
-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.

-- Никому не советую пробобовать добавить 1 млн. users, так как это займет очень много времени !!!

-- Для текущего задания создам тестовую таблицу test_users

DROP TABLE IF EXISTS test_users; 
CREATE TABLE test_users (
	id SERIAL PRIMARY KEY,
	name VARCHAR(255),
	birthday_at DATE,
	`created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
 	`updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);


DROP PROCEDURE IF EXISTS insert_into_users ;
delimiter //
CREATE PROCEDURE insert_into_users ()
BEGIN
	DECLARE i INT DEFAULT 100;
	DECLARE j INT DEFAULT 0;
	WHILE i > 0 DO
		INSERT INTO test_users(name, birthday_at) VALUES (CONCAT('user_', j), NOW());
		SET j = j + 1;
		SET i = i - 1;
	END WHILE;
END //
delimiter ;


-- test
SELECT * FROM test_users;

CALL insert_into_users();

SELECT * FROM test_users LIMIT 3;
