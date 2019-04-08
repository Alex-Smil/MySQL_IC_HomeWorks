-- ********* les_04 решения домашних заданий ***********
-- ********** ex_01 ***********
-- *** 1. Подсчитайте средний возраст пользователей в таблице users. ***
SELECT ROUND(AVG((TO_DAYS(NOW()) - TO_DAYS(birthday_at)) / 365.25), 0) AS AVG_Age FROM users;

-- Вариант решения GB
SELECT ROUND(AVG(TIMESTAMPDIFF(YEAR, birthday_at, NOW())), 0) AS AVG_Age FROM users;




-- ********** ex_02 ***********
-- *** 2. Подсчитайте количество дней рождения, которые приходятся на каждый из дней недели.***
-- *** Следует учесть, что необходимы дни недели текущего года, а не года рождения. ***********

-- ******** Подбор решения **********
-- SELECT YEAR(NOW());

-- SELECT CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10)) AS birthday FROM users;

-- SELECT
--     DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday
-- FROM users;
-- *********************************

-- ***** само РЕШЕНИЕ для ex02 *****
SELECT
    DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year,
    COUNT(*) AS amount_of_birthday
FROM
    users
GROUP BY 
    week_day_of_birthday_in_this_Year
ORDER BY
	amount_of_birthday DESC;

-- скрипт для проверки ex_2
-- SELECT
-- 	name,
-- 	birthday_at,
-- 	CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10)) AS date_of_birthday_in_this_Year,
--     DAYNAME(CONCAT(YEAR(NOW()), '-', SUBSTRING(birthday_at, 6, 10))) AS week_day_of_birthday_in_this_Year
-- FROM
--     users
-- ORDER BY
-- 	week_day_of_birthday_in_this_Year;

-- Вариант решения GB
SELECT DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))) AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users;
SELECT DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day FROM users GROUP BY day;
-- само решение
SELECT
	DATE_FORMAT(DATE(CONCAT_WS('-', YEAR(NOW()), MONTH(birthday_at), DAY(birthday_at))), '%W') AS day,
	COUNT(*) AS total
FROM
	users
GROUP BY
	day
ORDER BY
	total DESC;

-- ********** ex_03 ***********
-- *** 3. (по желанию) Подсчитайте произведение чисел в столбце таблицы. ***
CREATE TABLE integers(
    value SERIAL PRIMARY KEY
);

INSERT INTO integers VALUES
    (NULL),
    (NULL),
    (NULL),
    (NULL),
    (NULL),
    (NULL);

-- решение ex_03
SELECT ROUND(exp(SUM(log(value))), 0) AS factorial FROM integers;

-- Вариант решения GB
SELECT ROUND(exp(SUM(ln(value))), 0) AS factorial FROM integers;



