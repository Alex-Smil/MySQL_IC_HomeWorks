use shop_online;

drop table if exists media_file;
create database file_storage;

drop table if exists media_files;
create table media_files (
	id serial primary key,
    `path` varchar(256) not null,
    file_type varchar(128) not null,
    title varchar(128) not null,
    author varchar(128) not null,
    `description` text default 'No describe',
    style varchar(128),
    owner_user_id int 
);

drop table if exists file_types;
create table file_types (
	id serial primary key,
    `type` varchar(32),
    unique unique_type (`type`(8))
);

drop table if exists users;
create table users (
	id serial primary key,
    name varchar(128) not null,
    registred_at DATETIME default CURRENT_TIMESTAMP,
    updated_at DATETIME default CURRENT_TIMESTAMP
);



