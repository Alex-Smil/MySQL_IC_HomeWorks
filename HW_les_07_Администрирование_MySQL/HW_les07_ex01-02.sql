mysql -uroot -p -P3360

-- ****************************************************************************************************************
-- 1. Создайте двух пользователей которые имеют доступ к базе данных shop.
-- Первому пользователю shop_read должны быть доступны только запросы на чтение данных,
-- второму пользователю shop — любые операции в пределах базы данных shop.

-- shop_read доступны только запросы на чтение данных
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop_online.* TO 'shop_reader'@'localhost';

-- test
INSERT INTO catalogs(name)
 -- denied for this user
VALUES('New catalog');
 -- success
SELECT * FROM catalogs;

-- shop - доступны любые операции в пределах базы данных shop
DROP USER IF EXISTS 'shop'@'localhost';
CREATE USER 'shop'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT ALL ON shop_online.* TO 'shop'@'localhost';
GRANT GRANT OPTION ON shop_online.* TO 'shop'@'localhost';

-- test
INSERT INTO catalogs(name)
 -- success
VALUES('New catalog');
 -- have new catalog
SELECT * FROM catalogs;


-- ****************************************************************************************************************
-- 2. (по желанию) Есть таблица (accounts), включающая в себя три столбца: id, name, password,
-- которые содержат первичный ключ, имя пользователя и его пароль. Создайте представление username таблицы accounts,
-- предоставляющее доступ к столбцам id и name. Создайте пользователя user_read,
-- который бы не имел доступа к таблице accounts, однако мог извлекать записи из представления username.

-- так как табл. accounts уже сущ.
-- создадим accounts2 для дз урока 6 
DROP TABLE IF EXISTS accounts2;
CREATE TABLE accounts2 (
	id SERIAL PRIMARY KEY,
	name VARCHAR(45),
	password VARCHAR(45)
);

INSERT INTO accounts2 VALUES
	(NULL, 'bob', '123'),
	(NULL, 'jack', '123'),
	(NULL, 'ron', '123');


CREATE OR REPLACE VIEW username(user_id, user_name) AS 
	SELECT id, name FROM accounts2;

 -- tests
SELECT * FROM accounts2;
SELECT * FROM username;
-- *

-- Создаем пользователя 'shop_reader'@'localhost' с доступом только к одному,
-- ограниченному по столбцам, представлению username;
DROP USER IF EXISTS 'shop_reader'@'localhost';
CREATE USER 'shop_reader'@'localhost' IDENTIFIED WITH sha256_password BY '123';
GRANT SELECT ON shop_online.username TO 'shop_reader'@'localhost';

-- test
-- логинимся под shop_reader
 -- access denied
SELECT * FROM catalogs;
 -- success
SELECT * FROM username;
