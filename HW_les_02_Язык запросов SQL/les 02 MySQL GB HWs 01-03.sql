/*les 02 MySQL GB*/

mysql -uroot -p123456 -P3360

/* *** ex - 01: *** */

use shop_online;

insert into catalogs value
	(null, null),
	(null, null),
	(null, null);

select * from catalogs;
describe catalogs;

update catalogs set name ='empty' where (name is null);

/*Проведенный выше запрос (update catalogs) не исполним, так как на столбец name установлен уникальный индекс (UNIQUE unique_name(name(10))),
т.е. если значение уже было ранее введено в данный столбец, то попытка добавить дубликат приведет к ошибке:
'update catalogs set name ='empty' where (name is null)	Error Code: 1062. Duplicate entry 'empty' for key 'unique_name'	0.000 sec'*/
на null, в качестве значения, это ограничение не действует. 

/* *** ex - 02:*** */

drop SCHEMA if exists file_storage;
CREATE SCHEMA file_storage DEFAULT CHARACTER SET utf8 COLLATE utf8_bin;
/*create database file_storage;*/
use file_storage;

drop table if exists media_files;
create table media_files (
	id serial primary key,
    `path` varchar(256) not null,
    file_type varchar(128) not null,
    title varchar(128) not null,
    author varchar(128) not null,
    `description` text,
    style varchar(128),
    owner_user_id int 
);

select * from media_files;
describe media_files;

insert into media_files values
	(null, 
    'Библиотеки\\Музыка\\1.mp3',
    'audio',
    'Bicycle Race',
    'Queen',
    'You say black, I say white You say bark, I say bite You say shark, I say hey man Jaws was never my scene And I don''t like Star Wars',
    'rock',
    1),
    (null, 
    'Библиотеки\\Музыка\\2.mp4',
    'video',
    'Bicycle Race',
    'Queen',
    'You say black, I say white You say bark, I say bite You say shark, I say hey man Jaws was never my scene And I don''t like Star Wars',
    'rock',
    1),
    (null, 
    'Библиотеки\\Музыка\\3.jpeg',
    'picture',
    'Bicycle Race',
    'Queen',
    'You say black, I say white You say bark, I say bite You say shark, I say hey man Jaws was never my scene And I don''t like Star Wars',
    'rock',
    1);
    
select * from media_files;


show databases;

/* *** ex - 03:*** */
https://ru.stackoverflow.com/questions/77896/mysql-%D0%B8-%D0%B4%D1%83%D0%B1%D0%BB%D0%B8%D1%80%D0%BE%D0%B2%D0%B0%D0%BD%D0%B8%D0%B5-%D0%BF%D0%B5%D1%80%D0%B2%D0%B8%D1%87%D0%BD%D0%BE%D0%B3%D0%BE-%D0%BA%D0%BB%D1%8E%D1%87%D0%B0

drop table if exists cat;
create table cat (
	id serial primary key,
	name varchar(255)
);

insert into cat values
	(DEFAULT, 'Процессоры'),
    (DEFAULT, 'Мат.платы'),
    (DEFAULT, 'Видеокарты');

insert into 
	sample.cat
select 
	*
from
	shop_online.catalogs
on duplicate key update id = values(id);

