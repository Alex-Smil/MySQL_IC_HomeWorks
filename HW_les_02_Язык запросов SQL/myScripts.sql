mysqldump -uroot -p123456 -P3360 example > D:\GEEK_BRAINS_D\MySQL\text\example-DUMP.sql
mysqldump -uroot -p123456 -P3360 products > D:\GEEK_BRAINS_D\MySQL\text\products-table-dump.sql

mysqldump -uroot -p123456 -P3360 mysql help_keyword > D:\GEEK_BRAINS_D\MySQL\text\mysql.help_keyword-dump.sql
mysqldump --opt --where="1 limit 100" -uroot -p123456 -P3360 mysql help_keyword > D:\GEEK_BRAINS_D\MySQL\text\mysql.help_keyword-dump_100_strs.sql
 

mysql -uroot -p123456 -P3360  sample < D:\GEEK_BRAINS_D\MySQL\text\example-DUMP.sql
mysql -uroot -p123456 -P3360  sample < D:\GEEK_BRAINS_D\MySQL\text\products-table-dump.sql

// *********** 01 les 02 ex *************** 

mysql -uroot -p123456 -P3360

CREATE SCHEMA `example2` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin ; 

CREATE TABLE users (
  `id` INT NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(128) NOT NULL,
  PRIMARY KEY (`id`));

exit;

mysqldump -uroot -p123456 -P3360 example > D:\GEEK_BRAINS_D\MySQL\text\example-DUMP.sql

mysql -uroot -p123456 -P3360
CREATE SCHEMA `sample` DEFAULT CHARACTER SET utf8 COLLATE utf8_bin; 
exit;

mysql -uroot -p123456 -P3360  sample < D:\GEEK_BRAINS_D\MySQL\text\example-DUMP.sql


// *********** END OF 01 les 02 ex ***************
mysqldump --opt --where="1 limit 100" -uroot -p123456 -P3360 mysql help_keyword > D:\GEEK_BRAINS_D\MySQL\text\mysql.help_keyword-dump_100_strs.sql
// *********** 01 les 03 ex ***************



create table test_tab1 (
	`create` INT,
	name VARCHAR(32));