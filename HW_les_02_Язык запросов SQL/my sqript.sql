use shop_online;
drop table if exists catalogs;
create table catalogs(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина'; 
select * from catalogs;
describe catalogs;

drop table if exists cat;
create table cat(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название раздела',
    UNIQUE unique_name(name(10))
) COMMENT = 'Разделы интернет-магазина'; 
select * from cat;
describe cat;
insert into cat select * from catalogs; 

insert into catalogs values
	(DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат.платы'),
    (DEFAULT, 'Видеокарты');
insert into catalogs value(null, 'Удалить!');
delete from catalogs where id= 5;

update catalogs
set 
	name = 'Процессоры (Intel)'
where
	name = 'Процессоры';
	


select * from catalogs;
insert into catalogs(name) value('Процессоры');
insert into catalogs(name) value('Мат.платы');
insert into catalogs(name) value('Видеокарты');

drop table if exists users;
create table users(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Имя покупателя',
    birthday_at DATE COMMENT 'Дата рождения',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Покупатели'; 

drop table if exists products;
create table products(
	id SERIAL PRIMARY KEY,
	name VARCHAR(255) COMMENT 'Название',
    description TEXT COMMENT 'Описание',
    price DECIMAL(11, 2) COMMENT 'Цена',
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_catalog_id (catalog_id)
) COMMENT = 'Товарные позиции'; 
describe products;

drop table if exists orders;
create table orders (
	id SERIAL PRIMARY KEY,
    user_id INT unsigned,
    catalog_id INT UNSIGNED,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id)
) COMMENT = 'Заказы';
describe orders;

drop table if exists orders_products;
create table orders_products (
	id SERIAL PRIMARY KEY,
    order_id INT unsigned,
    product_id INT unsigned,
    total INT unsigned DEFAULT 1 COMMENT 'Количество заказов',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Состав заказов';

drop table if exists discounts;
create table discounts (
	id SERIAL PRIMARY KEY,
    user_id INT unsigned,
    product_id INT unsigned,
    discounts FLOAT unsigned COMMENT 'Величина скидки от 0.00 до 1.0',
    started_at DATETIME,
    finished_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    KEY index_of_user_id(user_id),
    KEY index_of_product_id(product_id)
) COMMENT = 'Скидки';
select * from discounts;
describe discounts;

drop table if exists storehouses;
create table storehouses (
	id SERIAL PRIMARY KEY,
    name VARCHAR(255) COMMENT 'Название',
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Склады';

drop table if exists storehouses_products;
create table storehouses_products (
	id SERIAL PRIMARY KEY,
    storehouse_id INT unsigned,
    product_id INT unsigned,
    `value` INT unsigned COMMENT 'Запас товарный позиции на складке' б
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) COMMENT = 'Запасы на складе';

/* ============================= */

select null;

ALTER TABLE test_tab1 RENAME TO tab1;
insert into tab1 () values ();
insert into tab1 (id, name) values (136, 'Intel i7');
insert into tab1 (id) values (136);

describe tab1; 
/*describe tab1\G - Работает в cmd*/

select * from tab1;
truncate tab1;/*Очистить таблицу полностью*/

alter table tab1 CHANGE `create` id INT unsigned NOT NULL; 
alter table tab1 CHANGE `name` name VARCHAR(128) DEFAULT 'NoName' NOT NULL;

/*Добавить новый столбец в сущ. таблицу*/
alter table tab1 ADD collect JSON;
insert into tab1 values (1, 'Intel i7', '{"first": "Hello", "second": "World"}');
select collect ->> "$.first" FROM tab1;


insert into users (id, name, birthday_at) values (1, 'Bob', '1979-01-27');
select * from users;
describe users;








