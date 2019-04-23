
-- mysql -uroot -p123456 -P3360
-- **************************************************************** 
-- *** Урок 3 - Операторы, фильтрация, сортировка и ограничение ***
-- *********************  ч.1 - Операторы  ************************
-- ****************************************************************
-- 01. Арифметические операторы
-- 02. Кл.слово AS в SELECT
-- 03. Логические операторы
-- 04. Логические И и ИЛИ
-- 05. STORED - столбцы

-- * 01. Арифметические операторы
-- Можно использ. все обычные арифметические операции
 SELECT 3 + 5;
 SELECT 9 % 4;
 -- и т.д.

-- * 02. Кл.слово AS в SELECT
 SELECT 3 + 5 AS Sum;

 SELECT 3 + NULL; -- = NULL

SELECT '3' + '8'; -- = 8

-- если строка не может быть приведена к числу интерпритируется как 0
SELECT '3' + 'abc'; -- = 3

-- произведение, деление и т.д. все как обычно


-- * 03. Логические операторы
-- Операторы сравнения все как обычно
-- Отрицание:
SELECT 2 != 3;
-- тоже самое
SELECT 2 <> 3;
-- Из необычного :
-- ' <=> ' позволяет безопасно сравнивать с NULL, так если при 
-- обычном сравнении чтобы мы не сравнивали с NULL мы всегда получим NULL,
-- но в случае <=> :
2 <=> NULL --// 0
NULL <=> NULL --// 1

-- NULL также проверяется оператороми:
-- IS NULL или IS NOT NULL --// Это более классический способ

-- Проверка NULL
SELECT * FROM products WHERE name is NULL;
-- или
SELECT * FROM products WHERE name is NOT NULL; 


-- * 04. Логические И и ИЛИ
-- AND и OR все как обычно
-- *

-- * 05. STORED - столбцы
-- Выражения можно сохранять в таблицах, 
-- при определение таблицы допускается использование
-- столбцов с вычисляемыми значениями
CREATE TABLE tbl200 (
	x INT,
	y INT,
	summ INT AS (x + y) -- <--
); 
-- Но в этом случае занчение столбца summ будет вычисляться каждый раз
-- при вызове SELECT или тому подобному, так как значение этого столбца
-- не сохраняется на ж.диск.
-- Для того чтобы значение сохранялось на ЖД необходимо использ. 
-- кл.слово STORED
CREATE TABLE tbl200 (
	x INT,
	y INT,
	summ INT AS (x + y) STORED -- <--
); 
-- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- 


-- **************************************************************** 
-- *****************  ч.2 - Условная выборка  *********************
-- ****************************************************************
-- 01. Опреатор BETWEEN (блок-схемы)
-- 02. Опреатор LIKE
-- 03. Оператор RLIKE
-- 04. Регулярные выражения

-- * 01. Опреатор BETWEEN (блок-схемы)
SELECT * FROM catalogs WHERE id BETWEEN 3 AND 4;
-- запсиси не попадающие в интервал
SELECT * FROM catalogs WHERE id NOT BETWEEN 3 AND 4;
SELECT * FROM users WHERE birthday_at BETWEEN '1980-01-01' AND '1990-01-01';

-- * Опреатор IN
-- Иногда требуется извлечь записи не диапозону, а отвечающие списку
SELECT * FROM users WHERE id IN (1, 2, 5);
-- Если ни одна искомая запись не удовлет. списку в IN, то возвращается
-- что было найдено
SELECT * FROM users WHERE id IN (1, 2, 123);

-- Проьтвоположная конструкция NOT IN
SELECT * FROM users WHERE id NOT IN (1, 2, 5);


-- * 02. Опреатор LIKE
SELECT * FROM catalogs WHERE name LIKE 'Процессоры';
-- Главное преимущество перед оператором ' = ' это
-- возможность использования
-- ' % ' - Любое кол-во символов или их отсутствие
-- ' _ ' - Ровно 1 символов

SELECT * FROM catalogs WHERE name LIKE 'Проц%';
SELECT * FROM catalogs WHERE name LIKE '%ссоры';
SELECT * FROM catalogs WHERE name LIKE 'Пр%ры';

SELECT * FROM catalogs WHERE name LIKE 'Видео_____'; -- _ - 5шт.
-- Экранирование спец символов \%, \_ все как обычно через \


-- * 03. Оператор RLIKE или его синоним REGEXP
-- поиск в соответствии с рег.выр.
-- RLIKE выполняется медленее чем LIKE 
SELECT * FROM catalogs WHERE name RLIKE '[а-яА-ЯёЁ]';
SELECT * FROM catalogs WHERE name RLIKE 'Проц.';
SELECT * FROM catalogs WHERE name RLIKE '^Проц.';
SELECT * FROM catalogs WHERE name RLIKE 'ры$';

-- Специальные классы
SELECT * FROM users WHERE id RLIKE '[[:digits:]]';

-- Квантификаторы как обычно
-- ^, $, . , +, ?, {n} и т.д

-- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- 



-- **************************************************************** 
-- **************  ч.3 - Сортировка и ограничения  ****************
-- ****************************************************************
-- 01. Сортировка
-- 02. Ограничение выборки
-- 03. Извлечение уникальных значений
-- 04. Сортировка и ограничения в DELETE и UPDATE

-- * 01. Сортировка
-- БД не гарантирует, что строки будут выводится в порядке их добавления
SELECT * FROM catalogs ORDER BY id;
SELECT * FROM catalogs ORDER BY id DESC;

SELECT id, name, catalog_id, price FROM products ORDER BY catalog_id, price;

-- В данном случае DESC относится только к полю price !
SELECT id, name, catalog_id, price FROM products ORDER BY catalog_id, price DESC;
-- Чтобы отсротировать оба столбца в обратном порядке необходимо
SELECT id, name, catalog_id, price FROM products ORDER BY catalog_id DESC, price DESC;


-- * 02. Ограничение выборки
-- Позволяет экономить время и ресурсы сервера, LIMIT
SELECT * FROM users LIMIT 3;
-- для извлечения следующей порции данных использ. LIMIT 1st, 2nd:
-- 1st - позиция с которой необходимо начать вывод 
-- 2тв - кол-во строк на вывод
SELECT * FROM users LIMIT 3, 3;
-- сущ. альтернативный синтаксис ... LIMIT 3 OFFSET 6;
-- LIMIT 3 - кол-во строк на вывод
-- OFFSET 6 - позиция с которой необходимо начать вывод  
SELECT * FROM users LIMIT 3 OFFSET 6;

-- в обратном порядке
SELECT * FROM users ORDER BY id DESC LIMIT 3;


-- * 03. Извлечение уникальных значений
SELECT catalog_id FROM products ORDER BY catalog_id;
-- Чтобы удалить дубли необходимо использ. DISTINCT
SELECT DISTINCT catalog_id FROM products ORDER BY catalog_id;
-- противоположность DISTINCT это ALL он стоит по умолч.


-- * 04. Сортировка и ограничения в DELETE и UPDATE
-- Все выше рассмотренные команды можно применять в отношении 
-- команд DELETE и UPDATE
SELECT id, catalog_id, price, name FROM products WHERE catalog_id = 2 AND price > 5000;
-- теперь этот SELECT можно применить к UPDATE или DELETE
-- меняем SELECT на UPDATE
UPDATE products SET price = price * 1.5 WHERE catalog_id = 2 AND price > 5000;
-- или DELETE
SELECT id, catalog_id, price, name FROM products ORDER BY price DESC LIMIT 2;
DELETE FROM products ORDER BY price DESC LIMIT 2;

-- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- 




-- **************************************************************** 
-- ************  ч.4 - Преопределенные функции ч.1  ***************
-- ****************************************************************
-- 01. Преопределенные функции
-- 02. Календарные функции
-- 03. Выборка случайного значения
-- 04. Справочные функции

-- * 01. Преопределенные функции
SELECT DATE('2018-01-01-');

SELECT NOW();

-- Оставляет только дату
SELECT DATE('2019-01-01 12:22:33');

-- Для форматирования календарных функций использ. DATE_FORMAT(date, '%Y' - и .т.д. см. доки)
SELECT DATE_FORMAT('2019-01-01 01:59:59', 'На дворе %Y год');
SELECT DATE_FORMAT(NOW(), 'На дворе %Y год');

-- Можно отформатировать дату рождения пользователей при выводе
SELECT DATE_FORMAT(birthday_at, '%d-%m-%Y') AS birthday_at FROM users;


-- * 02. Календарные функции
-- * UNIXSTAMP формат кол-во сек с 1970-01-01, это INT число,
-- диапозон с 1970-01-01 по 2038-12-31
-- из обычной даты в UNIXSTAMP формат
SELECT UNIX_TIMESTAMP('2019-01-01');
-- обратно 
SELECT FROM_UNIXTIME('1546290000');

-- Вычислим текущий возраст пользователей
SELECT 
	name,
	(TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25 AS age
FROM 
	users; 
-- округлим ROUND()
SELECT 
	name,
	ROUND((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25, 0) AS age
FROM 
	users;

-- Болле точного результата можно добиться при помощи TIMESTAMPDIFF()
SELECT 
	name,
	TIMESTAMPDIFF(YEAR, birthday_at, NOW()) AS age
FROM 
	users;


-- * 03. Выборка случайного значения
-- Везде где используется имя столбца можно задейстововать функцию
SELECT * FROM users ORDER BY RAND();
-- одна случайная запись 
SELECT * FROM users ORDER BY RAND() LIMIT 1;


-- 04. Справочные(информационные) функции
SELECT VERSION(); -- версия сервера

-- Узнать значение столбца снабженного атрибутом AUTO_INCREMENT
-- это можно использовать для вставки внещ.ключа
SELECT LAST_INSERT_ID();

SELECT DATABASE(); --// Текущая БД
-- если БД не выбрана возращается NULL

-- Текущий пользователь
SELECT USER();



-- **************************************************************** 
-- ************  ч.5 - Преопределенные функции ч.2  ***************
-- ****************************************************************
-- 01. Математические функции
-- 02. Строковые функции
-- 03. Логические функции
-- 04. Вспомогательные функции

-- * 01. Математические функции
-- SQRT(), POW(), SIN() и т.д
-- ROUND() - округляет Математические
-- CEILING() - всегда в большую сторону
-- FLOOR() - всегда в меньшую сторону


-- * 02. Строковые функции

-- Извлечение подстроки
-- SUBSTRING(str, from, to)
-- нумирация в строках всегда начинается с 1
SELECT id, SUBSTRING(name, 2, 4) AS name FROM users;

-- Объединение строк
SELECT id, CONCAT(name, ' ', TIMESTAMPDIFF(YEAR, birthday_at, NOW())) AS name FROM users; 


-- Проверка условий
SELECT IF(TRUE, 'истина', 'ложь'), IF(FALSE, 'истина', 'ложь');
-- Опрделим достиг ли пользователь 18 лет
SELECT
	name,
	IF(
		TIMESTAMPDIFF(YEAR, birthday_at, NOW()) >= 18,
		'совершеннолетний',
		'не совершеннолетний'
	) AS status
FROM
	users;


-- * Если требуется проверить больше значений, то можно использ.
-- выражение CASE

DROP TABLE IF EXISTS rainbow;
CREATE TABLE rainbow (
	id SERIAL PRIMARY KEY,
	color VARCHAR(255)
);

INSERT INTO rainbow (color) VALUES
	('red'),
	('orange'),
	('yellow'),
	('green'),
	('blue'),
	('indigo'),
	('violet');

-- Чтобы заменить англ. назв. русскими необходимо
SELECT 
	CASE
		WHEN color = 'red' THEN 'красный'
		WHEN color = 'orange' THEN 'оранжевый'
		WHEN color = 'yellow' THEN 'желтый'
		WHEN color = 'green' THEN 'зеленый'
		WHEN color = 'blue' THEN 'голубой'
		WHEN color = 'indigo' THEN 'синий'
		ELSE 'фиолетовый'
	END AS rus_colors
FROM
	rainbow;

-- *
-- Принимет IP и переводит его в целое число
SELECT INET_ATON('62.145.69.10');
-- в обратную сторону
SELECT INET_NTOA('1049707786');

-- Возвращает универсальный идентификатор UUID()
-- глобально уникальный во времени и прострастве
SELECT UUID();


-- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- ***** -- 
