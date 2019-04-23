
mysql -uroot -p123456 -P3360
use shop_online;

-- ********************************************************************
-- **********************  Examples les 08  ***************************
-- **********  Хранимые процедуры и функции, триггеры  ****************
-- ********************************************************************
-- ******   01. Хранимые процедуры *****

-- 01. Создание процедур и функций
-- 02. Вызов на выполнение
-- 03. Получение списка
-- 04. Просмотр содержимого
-- 05. Удаление
-- 06. Переназначение признака конца запроса


-- * 01. Создание процедур и функций
delimiter //
CREATE PROCEDURE my_version()
BEGIN
	SELECT VERSION();
END //
delimiter ;

CALL my_version();

-- Список всех хранимых процедур
SHOW PROCEDURE STATUS\G
-- Описание кокретной процедуры
SHOW PROCEDURE STATUS LIKE 'my_version%'\G


-- Список всех хранимых функций
SHOW FUNCTION STATUS\G

-- такой просмотр не очень удобный поэтому на правах roota
-- мы можем обратиться к базе mysql точнее к табл. mysql.proc
SELECT name, type FROM mysql.proc LIMIT 10;


-- Посмотреть содержимое функции после ее создания
SHOW CREATE PROCEDURE my_version\G

-- Удаление
DROP PROCEDURE name_proc;
DROP FUNCTION name_proc;
-- или 
DROP PROCEDURE IF EXISTS name_proc;
DROP FUNCTION IF EXISTS name_proc;

-- ++++++++++++++++++++++++++++++++++++

-- так как функция возвращает всегда одно и тоже значение
-- ее можно закешировать, т.е. она DETERMINISTIC
CREATE FUNCTION IF EXISTS get_version;
delimiter //
CREATE FUNCTION get_version()
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	RETURN VERSION();
END //
delimiter ;

-- NOT DETERMINISTIC - возвращается всегда разное значение

-- * 06. Переназначение признака конца запроса
-- это про delimiter


-- ****************************************************
-- *****   02. Параметры, переменные, ветвление   *****
-- 01. Параметры
-- 02. Переменные
-- 03. Команда SET
-- 04. Команда SELECT ... INTO ... FROM ... - для работы внутри хранимых процедур
-- 05. Операторы IF и CASE


-- * 01. Параметры
delimiter //
CREATE PROCEDURE set_x (IN value INT)
BEGIN
	SET @x = value;
END //
delimiter ;

CALL set_x(123456);

SELECT @x;

-- Процедура возвращающая значение
DROP PROCEDURE IF EXISTS set_x;
delimiter //
CREATE PROCEDURE set_x(OUT value INT)
BEGIN
	SET @x = value;
	SET value = 1000;
END //
delimiter ;

SET @y = 55555;
SELECT @y;

CALL set_x(@y);

SELECT @x, @y;


-- IN OUT params
DROP PROCEDURE IF EXISTS set_x;
delimiter //
CREATE PROCEDURE set_x(INOUT value INT)
BEGIN
	SET @x = value;
	SET value = 1000;
END //
delimiter ;

SET @y = 55555;
SELECT @y;

CALL set_x(@y);

SELECT @x, @y;



-- * 02. Переменные
-- Чтобы объявить локальную переменную использ. кл.сл. DECLARE
DROP PROCEDURE IF EXISTS decalre_var;
delimiter //
CREATE PROCEDURE decalre_var()
BEGIN
	DECLARE id, num INT(11) DEFAULT 0; -- можно сразу объявить переменные одного типа вместе в одной строке
	DECLARE name, hello, temp TINYTEXT;
	SET value = 1000;
END //
delimiter ;

-- !!! Области видимости переменных все как обычно !!!

-- * 03. Команда SET
-- Сущ. 2 споспоба инициализации переменных
-- SET и
-- SELECT ... INTO ... FROM ...

-- SET Инициализация
SET @var = 100;
SET @var = @var + 1;

-- SELECT ... INTO ... FROM ... инициализации
-- позволяет сохранять переменные без их немедленного вывода
-- и без использ. внеш. переменных
SELECT
	id, data
INTO
	@x, @y
FROM
	test

-- func принимет кол-во сек и формат их в кол-во дней часов ...
DROP FUNCTION IF EXISTS second_format;
delimiter //
CREATE FUNCTION second_format(seconds INT)
RETURNS VARCHAR(255) DETERMINISTIC
BEGIN
	DECLARE days, hours, minutes INT;

	SET days = FLOOR(seconds / 86400);
	SET seconds = seconds - days * 86400;
	SET hours = FLOOR(seconds / 3600);
	SET seconds = seconds - hours * 3600;
	SET minutes = FLOOR(seconds / 60);
	SET seconds = seconds - minutes * 60;

	RETURN CONCAT(days, " days ",
				  hours, " hours ",
				  minutes, " minutes ",
				  seconds, " seconds ");
END //
delimiter ;


SELECT second_format(123456);


-- Особенности использ. SELECT внутри процедур и функций
-- функция возвращающая кол-во строк в табл. каталог
DROP FUNCTION IF EXISTS numcatalogs;
delimiter //
CREATE PROCEDURE numcatalogs(OUT total INT)
BEGIN
	SELECT COUNT(*) INTO total FROM catalogs;
END //
delimiter ;

CALL numcatalogs(@a);

SELECT @a;


-- * 05. Операторы IF и CASE
DROP PROCEDURE IF EXISTS format_now;
delimiter //
CREATE PROCEDURE format_now(format CHAR(4))
BEGIN
	IF(format = 'date') THEN
		SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
	ELSEIF(format = 'time') THEN
		SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
	ELSE
		SELECT UNIX_TIMESTAMP(NOW()) AS format_now;
	END IF;
END //
delimiter ;


CALL format_now('date');
CALL format_now('time');
CALL format_now('secs');


-- Множетсвенный выбор CASE - как SWITCH
-- тоже самое что и в блоках с IF
DROP PROCEDURE IF EXISTS format_now;
delimiter //
CREATE PROCEDURE format_now(format CHAR(4))
BEGIN
	CASE format
		WHEN 'date' THEN
			SELECT DATE_FORMAT(NOW(), "%d.%m.%Y") AS format_now;
		WHEN 'time' THEN
			SELECT DATE_FORMAT(NOW(), "%H:%i:%s") AS format_now;
		WHEN 'secs' THEN
			SELECT UNIX_TIMESTAMP(NOW()) AS format_now;
		ELSE
			SELECT 'Ошибка в параметре format';
	END CASE;
END //
delimiter ;


CALL format_now('date');
CALL format_now('time');
CALL format_now('secs');
CALL format_now('four');




-- ****************************************************
-- ************   03. Циклы и курсоры   ***************
-- 01. Циклы
-- 02. Досрочный выход из циклов
-- 03. Обработчики ошибок
-- 04. Курсоры

-- * 01. Циклы
WHILE
REPEAT
LOOP

-- WHILE
DROP PROCEDURE IF EXISTS NOW3;
delimiter //
CREATE PROCEDURE NOW3()
BEGIN
	DECLARE i INT DEFAULT 3;
	WHILE i > 0 DO
		SELECT NOW();
		SET i = i - 1;
	END WHILE;
END //
delimiter ;

CALL NOW3();
-- *

DROP PROCEDURE IF EXISTS NOWN;
delimiter //
CREATE PROCEDURE NOWN(IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	IF(num > 0) THEN
		WHILE i < num DO
			SELECT NOW();
			SET i = i + 1;
		END WHILE;
	ELSE
		SELECT 'Ошибка неверный папраметр';
	END IF;
END //
delimiter ;

CALL NOWN(3);


-- * 02. Досрочный выход из циклов LEAVE, 
-- это как break, полный выход из цикла
DROP PROCEDURE IF EXISTS NOWN;
delimiter //
CREATE PROCEDURE NOWN(IN num INT)
BEGIN
	DECLARE i INT DEFAULT 0;
	IF(num > 0) THEN
		cycle: WHILE i < num DO
			IF i >= 2 THEN LEAVE cycle;
			END IF;
			SELECT NOW();
			SET i = i + 1;
		END WHILE;
	ELSE
		SELECT 'Ошибка неверный папраметр';
	END IF;
END //
delimiter ;

CALL NOWN(5);

-- Цыклы можно вкладывать друг в друга

-- Еще один оператор для выхода из цикла явл. ITERATE
-- это как continue в обычных циклах, выход из текущей итерации
DROP PROCEDURE IF EXISTS numbers_string;
delimiter //
CREATE PROCEDURE numbers_string(IN num INT)
BEGIN	
	DECLARE i INT DEFAULT 0;
	DECLARE bin TINYTEXT DEFAULT '';
	IF(num > 0) THEN
		cycle: WHILE i < num DO
			SET i = i + 1;
			SET bin = CONCAT(bin, i);
			IF i > CEILING(num / 2) THEN
				ITERATE cycle;
			END IF;
			SET bin = CONCAT(bin, i); 
		END WHILE cycle;
		SELECT bin;
	ELSE
		SELECT 'Ошибка';
	END IF;
END //
delimiter ;

CALL numbers_string(9);


-- REPEAT - похож на WHILE
-- отличие в том, что усл. выхода находится в конце
-- это как do while, так как в результате цикл выполнится
-- хотя бы один раз.

DROP PROCEDURE IF EXISTS NOW3;
delimiter //
CREATE PROCEDURE NOW3()
BEGIN
	DECLARE i INT DEFAULT 3;
	REPEAT
		SELECT NOW();
		SET i = i - 1;
	UNTIL i <= 0 -- условие выхода из цикла
	END REPEAT;
END //
delimiter ;

CALL NOW3();



-- LOOP - не имеет условтя выхода из цикла
-- поэтому он всегда должен иметь в своем составе LEAVE
DROP PROCEDURE IF EXISTS NOW3;
delimiter //
CREATE PROCEDURE NOW3()
BEGIN
	DECLARE i INT DEFAULT 3;
	cycle: LOOP
		SELECT NOW();
		SET i = i - 1;
		IF i <= 0 THEN LEAVE cycle;
		END IF;
	END LOOP cycle;
END //
delimiter ;

CALL NOW3();


-- * 03. Обработчики ошибок
-- см. лекцию


-- * 04. Курсоры
-- см. лекцию


-- ****************************************************
-- ****************   04. Триггеры   ******************
-- 01. Типы триггеров
-- 02. Создание и удаление Триггеров
-- 03. Просмотр списка триггеров
-- 04. Кл. слова NEW и OLD

-- * 01. Типы триггеров
-- см. лекцию

-- Список созданных триггеров

DROP TRIGGER IF EXISTS name_trigger;








-- 04. Триггеры