
mysql -uroot -p123456 -P3360
use shop_online;

-- Archive - не поддерживает индексы, поэтому при определении
-- таблицы первичный ключ не указывается.
DROP TABLE IF EXISTS logs;
CREATE TABLE logs (
	created_at DATE NOT NULL,
	table_name VARCHAR(45) NOT NULL,
	str_id BIGINT(20) NOT NULL,
	name_value VARCHAR(45) NOT NULL
) ENGINE = ARCHIVE;

DROP TRIGGER IF EXISTS watchlog_users;
delimiter //
CREATE TRIGGER watchlog_users AFTER INSERT ON users
FOR EACH ROW
BEGIN
	INSERT INTO logs (created_at, table_name, str_id, name_value)
	VALUES (NOW(), 'users', NEW.id, NEW.name);
END //
delimiter ;


-- доделать еще тригеры на catalogs и products
-- users, catalogs и products

INSERT INTO users (name, birthday_at)
VALUES ('Кнехт', '1900-01-01');





-- 1. Создайте таблицу logs типа Archive. Пусть при каждом создании записи в таблицах users, catalogs и products 
-- в таблицу logs помещается время и дата создания записи, название таблицы, идентификатор первичного ключа и
-- содержимое поля name.

-- 2. (по желанию) Создайте SQL-запрос, который помещает в таблицу users миллион записей.