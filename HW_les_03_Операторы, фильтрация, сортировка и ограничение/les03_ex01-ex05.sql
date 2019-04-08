-- mysql -uroot -p123456 -P3360

use shop_online;

SELECT * FROM products;

-- *** les 03 ex 01 ***
-- 1. Пусть в таблице users поля created_at и updated_at оказались незаполненными. Заполните их текущими датой и временем.
UPDATE products
    SET created_at = NULL where id = 3;

UPDATE products
    SET created_at = NULL where id = 1;

UPDATE products
    SET created_at = NOW() where created_at is NULL;

UPDATE products
    SET created_at = NOW() where id = 3;

-- *** les 03 ex 02 ***
-- 2.Таблица users была неудачно спроектирована. Записи created_at и updated_at были заданы типом VARCHAR и в них долгое время помещались значения
-- в формате "20.10.2017 8:10". Необходимо преобразовать поля к типу DATETIME, сохранив введеные ранее значения.
-- 
-- Предположим, что тип столбцов created_at и updated_at - VARCHAR(256), хотя в предыдущем уроке тип был указан верно - DATETIME,
-- c использованием DEFAULT CURRENT_TIMESTAMP и DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP.
-- Поэтому сначала приводим тип столбцов в соотвествии с требованием дз.
ALTER TABLE products 
    CHANGE COLUMN `created_at` `created_at` VARCHAR(256) NULL,
    CHANGE COLUMN `updated_at` `updated_at` VARCHAR(256) NULL;

describe products;
SELECT created_at from products;

ALTER TABLE products 
    CHANGE COLUMN `created_at` `created_at` DATETIME DEFAULT CURRENT_TIMESTAMP,
    CHANGE COLUMN `updated_at` `updated_at` DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP;

describe products;
SELECT created_at from products;


-- *** les 03 ex 03 ***
-- 3. В таблице складских запасов storehouses_products в поле value могут встречаться самые разные цифры: 0,
-- если товар закончился и выше нуля, если на складе имеются запасы. Необходимо отсортировать записи таким образом,
-- чтобы они выводились в порядке увеличения значения value. Нулевые запасы должны выводиться в конце, после всех записей.
create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Запас товарный позиции на складке',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

INSERT INTO
    storehouses_products (storehouse_id, product_id, value)
VALUES
    (1, 1, 15),
    (1, 3, 0),
    (1, 5, 10),
    (1, 7, 5),
    (1, 8, 0);

SELECT 
    value
FROM
    storehouses_products ORDER BY CASE WHEN value = 0 then 1 else 0 end, value;
    -- storehouses_products ORDER BY IF(value > 0, 0, 1), value; // Вариант от GB


-- *** les 03 ex 04 ***
-- 4. (по желанию) Из таблицы users необходимо извлечь пользователей, родившихся в августе и мае.
-- Месяцы заданы в виде списка английских названий ('may', 'august')
SELECT
    name, birthday_at, 
    CASE 
        WHEN DATE_FORMAT(birthday_at, '%m') = 05 THEN 'may'
        WHEN DATE_FORMAT(birthday_at, '%m') = 08 THEN 'august'
    END AS mounth
FROM
    users WHERE DATE_FORMAT(birthday_at, '%m') = 05 OR DATE_FORMAT(birthday_at, '%m') = 08;

SELECT
    name, birthday_at, DATE_FORMAT(birthday_at, '%m') as mounth_of_birth
FROM
    users;

-- SELECT name FROM users WHERE DATE_FORMAT(birthday_at, '%m') IN ('may', 'august'); -- // Вариант от GB - Н работаетю
SELECT name, birthday_at FROM users WHERE MONTHNAME(birthday_at) IN ('may', 'august'); -- // Вариант от GB - Н работаетю



-- *** les 03 ex 05 ***
-- 5. (по желанию) Из таблицы catalogs извлекаются записи при помощи запроса:
-- SELECT * FROM catalogs WHERE id IN (5, 1, 2); Отсортируйте записи в порядке, заданном в списке IN.
-- 
-- Так как категория с номер id 5 в моей таблице была ранее удалена,
-- вместо нее используется категория с номер id 3 
SELECT * FROM catalogs WHERE id IN (3, 1, 2);

SELECT 
    *
FROM
    catalogs WHERE id IN (3, 1, 2) 
ORDER BY CASE
    WHEN id = 3 THEN 0
    WHEN id = 1 THEN 1
    WHEN id = 2 THEN 2
END;

-- SELECT* FROM catalogs WHERE id IN (3, 1, 2) ORDER BY FIELD(id, 3, 1, 2); // Вариант от GB











