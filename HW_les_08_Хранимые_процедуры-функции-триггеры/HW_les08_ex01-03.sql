-- **************************************************************
-- ****************** Home work for les 08 **********************
mysql -uroot -p123456 -P3360
use shop_online;

-- *************** ex 01 ***************
-- ex 1. Создайте хранимую функцию hello(), которая будет возвращать приветствие,
-- в зависимости от текущего времени суток.
-- С 6:00 до 12:00 функция должна возвращать фразу "Доброе утро",
-- с 12:00 до 18:00 функция должна возвращать фразу "Добрый день",
-- с 18:00 до 00:00 — "Добрый вечер", с 00:00 до 6:00 — "Доброй ночи".

-- ex 01 с использ. CASE
DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	CASE 
		WHEN CURTIME() BETWEEN '06:00:00' AND '12:00:00' THEN
			SELECT 'Доброе утро';
		WHEN CURTIME() BETWEEN '12:00:00' AND '18:00:00' THEN
			SELECT 'Добрый день';
		WHEN CURTIME() BETWEEN '18:00:00' AND '00:00:00' THEN
			SELECT 'Добрый вечер';
		ELSE
			SELECT 'Доброй ночи';
	END CASE;
END //
delimiter ;

CALL hello();

-- ex 01 с использ. IF ELSE
DROP PROCEDURE IF EXISTS hello;
delimiter //
CREATE PROCEDURE hello()
BEGIN
	IF(CURTIME() BETWEEN '06:00:00' AND '12:00:00') THEN
		SELECT 'Доброе утро';
	ELSEIF(CURTIME() BETWEEN '12:00:00' AND '18:00:00') THEN
		SELECT 'Добрый день';
	ELSEIF(CURTIME() BETWEEN '18:00:00' AND '00:00:00') THEN
		SELECT 'Добрый вечер';
	ELSE
		SELECT 'Доброй ночи';
	END IF;
END //
delimiter ;

CALL hello();


-- *************** ex 02 ***************
-- ex 2. В таблице products есть два текстовых поля: name с названием товара и description с его описанием. 
-- Допустимо присутствие обоих полей или одно из них. Ситуация, когда оба поля принимают неопределенное
-- значение NULL неприемлема. Используя триггеры, добейтесь того, чтобы одно из этих полей или оба поля
-- были заполнены. При попытке присвоить полям NULL-значение необходимо отменить операцию.

DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name) AND ISNULL(NEW.description)) THEN
		SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Trigger Warning! NULL in both fields!';
	END IF;
END //
delimiter ;

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 5000, 2); -- FAIL ! Trigger Warning

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", NULL, 15000, 12); -- success

INSERT INTO products (name, description, price, catalog_id)
VALUES ("GeForce GTX 1080", "Мощная видеокарта", 15000, 12); -- success

-- На случай если я не верно понял задание.
-- данный триггер вместе выбрасывания ошибки и отмены опреации присваивает значение DEFAULT
DROP TRIGGER IF EXISTS nullTrigger;
delimiter //
CREATE TRIGGER nullTrigger BEFORE INSERT ON products
FOR EACH ROW
BEGIN
	IF(ISNULL(NEW.name)) THEN
		SET NEW.name = 'NoName';
	END IF;
	IF(ISNULL(NEW.description)) THEN
		SET NEW.description = 'No Desc';
	END IF;
END //
delimiter ;

INSERT INTO products (name, description, price, catalog_id)
VALUES (NULL, NULL, 20000, 12); -- FAIL ! Trigger Warning


-- *************** ex 03 ***************
-- ex 3. (по желанию) Напишите хранимую функцию для вычисления произвольного числа Фибоначчи.
-- Числами Фибоначчи называется последовательность в которой число равно сумме двух предыдущих чисел.
-- Вызов функции FIBONACCI(10) должен возвращать число 55.

-- Рабочий алгоритм из LISP наработок 
-- (define (fib n)
--   (define (fib-iter a b count)
--     (if(= 0 count)
--       b
--       (fib-iter (+ a b) a (- count 1))
--     )
--   )
--   (fib-iter 1 0 n)
-- )


-- Не работает !!!
-- DROP FUNCTION IF EXISTS fib();
-- delimiter //
-- CREATE FUNCTION fib(n INT) RETURNS INT NOT DETERMINISTIC
-- BEGIN
-- 	IF(n <= 1)
-- 		RETURN n;
-- 	ELSE
-- 		RETURN (
-- 			fib(n - 1) + fib(n - 2);
-- 		)
-- 	END IF;
-- END //
-- delimiter ;

-- SELECT fib(10);


-- SELECT IF(X=1, Fn_1, Fn_2) F
-- FROM(
--   SELECT @I := @I + @J Fn_1, @J := @I + @J Fn_2
--   FROM
--     (SELECT 0 dummy UNION ALL SELECT 0 UNION ALL SELECT 0)a,
--     (SELECT 0 dummy UNION ALL SELECT 0 UNION ALL SELECT 0)b,
--     (SELECT @I := 1, @J := 1)IJ
-- )T,
--   /*Фиктивная таблица, для вывода последовательности в 1 столбец*/
--   (SELECT 1 X UNION ALL SELECT 2)X;



-- SELECT  IF(X=1, Fn_1, Fn_2) F
-- FROM(
--   SELECT @I := @I + @J AS Fn_1, @J := @I + @J AS Fn_2
--   FROM
--     (SELECT 0 dummy UNION ALL SELECT 0 UNION ALL SELECT 0) AS a,
--     (SELECT 0 dummy UNION ALL SELECT 0 UNION ALL SELECT 0) AS b,
--     (SELECT @I := 1, @J := 1) AS IJ
-- ) AS T,
--   /*Фиктивная таблица, для вывода последовательности в 1 столбец*/
--   (SELECT 1 X UNION ALL SELECT 2) AS X;