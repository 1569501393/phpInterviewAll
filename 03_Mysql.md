[TOC]

# [20210102_mysql必知必会](https://www.processon.com/mindmap/5ef6324607912929cb5e25b5)

# mysql必知必会

> 作者： 本*福塔（ben forta）
> 译者： 刘晓霞 钟鸣
> 2009.01 2020.04重印

# 1.了解sql

## 1.1.数据库基础

数据库是一个以某种有组织的方式存储的数据集合

## 1.2.什么是sql

结构化查询语句
Structured Query Language

## 1.3.动手实践

多动手实践，强烈建议试验每个例子

## 1.4.小结

这一章介绍了什么是SQL以及它为什么很有用。因为SQL是用来与数
据库打交道的，所以，我们也复习了一些基本的数据库术语。 



# 2.MySql简介

## 2.1.什么是MySql

数据库软件

## 2.2.MySql工具

mysql 命令行根据
mysql administrator
mysql query browser

## 2.3.小结

本章介绍了什么是MySQL，并引入了几个客户机实用程序（一个命
令行实用程序，两个可选但强烈建议使用的图形实用程序）。



# 3.使用mysql

## 3.1.连接

```mysql
root@SKY-20191125ANA:~# mysql -uroot -p -h 127.0.0.1
Enter password: 
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 30
Server version: 8.0.12 MySQL Community Server - GPL

Copyright (c) 2000, 2013, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.
```

## 3.2.选择数据库

```mysql
mysql> use mysql_crash_course
Reading table information for completion of table and column names
You can turn off this feature to get a quicker startup with -A

Database changed
```

## 3.3.了解数据库和表

```mysql
mysql> show databases;
+------------------------+
| Database               |
+------------------------+
| grade                  |
| information_schema     |
| miaosha                |
| mobilecms              |
| mysql                  |
| mysql_crash_course     |
| mysql_crash_course_bak |
| newepweikedb           |
| performance_schema     |
| recovery               |
| sys                    |
| test                   |
| wc2                    |
| wg                     |
| youche                 |
| yourls                 |
+------------------------+
16 rows in set (0.00 sec)

mysql> show tables;
+------------------------------+
| Tables_in_mysql_crash_course |
+------------------------------+
| customers                    |
| orderitems                   |
| orders                       |
| productnotes                 |
| products                     |
| vendors                      |
+------------------------------+
6 rows in set (0.00 sec)
```

## 3.4.小结

本章介绍了如何连接和登录MySQL，如何用USE选择数据库，如何用
SHOW查看MySQL数据库、表和内部信息。在这些知识的帮助下，我们可
以进一步深入学习所有重要的SELECT语句了

```mysql
mysql> show columns from customers;
mysql> desc customers;
mysql> describe customers;
+--------------+-----------+------+-----+---------+----------------+
| Field        | Type      | Null | Key | Default | Extra          |
+--------------+-----------+------+-----+---------+----------------+
| cust_id      | int(11)   | NO   | PRI | NULL    | auto_increment |
| cust_name    | char(50)  | NO   |     | NULL    |                |
| cust_address | char(50)  | YES  |     | NULL    |                |
| cust_city    | char(50)  | YES  |     | NULL    |                |
| cust_state   | char(5)   | YES  |     | NULL    |                |
| cust_zip     | char(10)  | YES  |     | NULL    |                |
| cust_country | char(50)  | YES  |     | NULL    |                |
| cust_contact | char(50)  | YES  |     | NULL    |                |
| cust_email   | char(255) | YES  |     | NULL    |                |
+--------------+-----------+------+-----+---------+----------------+
9 rows in set (0.01 sec) 

mysql> show create database mysql_crash_course  \G
*************************** 1. row ***************************
       Database: mysql_crash_course
Create Database: CREATE DATABASE `mysql_crash_course` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_unicode_ci */
1 row in set (0.01 sec)

mysql root@localhost:mysql_crash_course> show create table customers;
+-----------+----------------+
| Table     | Create Table   |
|-----------+----------------|
| customers | CREATE TABLE `customers` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` char(50) COLLATE utf8_unicode_ci NOT NULL,
  `cust_address` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_city` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_state` char(5) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_zip` char(10) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_country` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_contact` char(50) COLLATE utf8_unicode_ci DEFAULT NULL,
  `cust_email` char(255) COLLATE utf8_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10006 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                |
+-----------+----------------+
1 row in set
Time: 0.003s
mysql root@localhost:mysql_crash_course> 

mysql root@localhost:mysql_crash_course> show grants \G
***************************[ 1. row ]***************************
Grants for root@% | GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `root`@`%` WITH GRANT OPTION
***************************[ 2. row ]***************************
Grants for root@% | GRANT BACKUP_ADMIN,BINLOG_ADMIN,CONNECTION_ADMIN,ENCRYPTION_KEY_ADMIN,GROUP_REPLICATION_ADMIN,PERSIST_RO_VARIABLES_ADMIN,REPLICATION_SLAVE_ADMIN,RESOURCE_GROUP_ADMIN,RESOURCE_GROUP_USER,ROLE_ADMIN,SET_USER_ID,SYSTEM_VARIABLES_ADMIN,XA_RECOVER_ADMIN ON *.* TO `root`@`%` WITH GRANT OPTION
***************************[ 3. row ]***************************
Grants for root@% | GRANT PROXY ON ''@'' TO 'root'@'%' WITH GRANT OPTION

3 rows in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> 

mysql root@localhost:mysql_crash_course> show errors;
+---------+--------+-----------+
| Level   | Code   | Message   |
|---------+--------+-----------|
+---------+--------+-----------+
0 rows in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> show warnings;
+---------+--------+-----------+
| Level   | Code   | Message   |
|---------+--------+-----------|
+---------+--------+-----------+
0 rows in set
```



# 4.检索数据

## 4.1.SELECT语句

```mysql
select * from customers;
```

## 4.2.检索单个列

```mysql
mysql root@localhost:mysql_crash_course> select prod_name from products;
+----------------+

| prod_name      |
| -------------- |
| .5 ton anvil   |
| 1 ton anvil    |
| 2 ton anvil    |
| Detonator      |
| Bird seed      |
| Carrots        |
| Fuses          |
| JetPack 1000   |
| JetPack 2000   |
| Oil can        |
| Safe           |
| Sling          |
| TNT (1 stick)  |
| TNT (5 sticks) |

+----------------+
14 rows in set
Time: 0.006s
```

## 4.3.检索多个列

```mysql
mysql root@localhost:mysql_crash_course> SELECT prod_id, prod_name, prod_price FROM products
                                      -> ;
+-----------+----------------+--------------+
| prod_id   | prod_name      |   prod_price |
|-----------+----------------+--------------|
| ANV01     | .5 ton anvil   |         5.99 |
| ANV02     | 1 ton anvil    |         9.99 |
| ANV03     | 2 ton anvil    |        14.99 |
| DTNTR     | Detonator      |        13    |
| FB        | Bird seed      |        10    |
| FC        | Carrots        |         2.5  |
| FU1       | Fuses          |         3.42 |
| JP1000    | JetPack 1000   |        35    |
| JP2000    | JetPack 2000   |        55    |
| OL1       | Oil can        |         8.99 |
| SAFE      | Safe           |        50    |
| SLING     | Sling          |         4.49 |
| TNT1      | TNT (1 stick)  |         2.5  |
| TNT2      | TNT (5 sticks) |        10    |
+-----------+----------------+--------------+
14 rows in set
```

## 4.4.检索所有列

```mysql
mysql root@localhost:mysql_crash_course> SELECT * FROM products;
+-----------+-----------+----------------+--------------+----------------------------------------------------------------+
| prod_id   |   vend_id | prod_name      |   prod_price | prod_desc                                                      |
|-----------+-----------+----------------+--------------+----------------------------------------------------------------|
| ANV01     |      1001 | .5 ton anvil   |         5.99 | .5 ton anvil, black, complete with handy hook                  |
| ANV02     |      1001 | 1 ton anvil    |         9.99 | 1 ton anvil, black, complete with handy hook and carrying case |
| ANV03     |      1001 | 2 ton anvil    |        14.99 | 2 ton anvil, black, complete with handy hook and carrying case |
| DTNTR     |      1003 | Detonator      |        13    | Detonator (plunger powered), fuses not included                |
| FB        |      1003 | Bird seed      |        10    | Large bag (suitable for road runners)                          |
| FC        |      1003 | Carrots        |         2.5  | Carrots (rabbit hunting season only)                           |
| FU1       |      1002 | Fuses          |         3.42 | 1 dozen, extra long                                            |
| JP1000    |      1005 | JetPack 1000   |        35    | JetPack 1000, intended for single use                          |
| JP2000    |      1005 | JetPack 2000   |        55    | JetPack 2000, multi-use                                        |
| OL1       |      1002 | Oil can        |         8.99 | Oil can, red                                                   |
| SAFE      |      1003 | Safe           |        50    | Safe with combination lock                                     |
| SLING     |      1003 | Sling          |         4.49 | Sling, one size fits all                                       |
| TNT1      |      1003 | TNT (1 stick)  |         2.5  | TNT, red, single stick                                         |
| TNT2      |      1003 | TNT (5 sticks) |        10    | TNT, red, pack of 10 sticks                                    |
+-----------+-----------+----------------+--------------+----------------------------------------------------------------+
14 rows in set
```

## 4.5.检索不同的行

```mysql
mysql root@localhost:mysql_crash_course> select vend_id from products;
+-----------+

| vend_id |
| ------- |
| 1001    |
| 1001    |
| 1001    |
| 1002    |
| 1002    |
| 1003    |
| 1003    |
| 1003    |
| 1003    |
| 1003    |
| 1003    |
| 1003    |
| 1005    |
| 1005    |

+-----------+
14 rows in set
```

## 4.6.限制结果

```mysql
mysql root@localhost:mysql_crash_course> select prod_name from products limit 5;
+--------------+

| prod_name    |
| ------------ |
| .5 ton anvil |
| 1 ton anvil  |
| 2 ton anvil  |
| Detonator    |
| Bird seed    |

+--------------+
5 rows in set
```

## 4.7.使用完全限定的表名

```mysql
mysql root@localhost:mysql_crash_course> select products.prod_name from products limit 5;
+--------------+

| prod_name    |
| ------------ |
| .5 ton anvil |
| 1 ton anvil  |
| 2 ton anvil  |
| Detonator    |
| Bird seed    |

+--------------+
5 rows in set
```



## 4.8.小结

本章学习了如何使用SQL的SELECT语句来检索单个表列、多个表列
以及所有表列。下一章将讲授如何排序检索出来的数据。



# 5.排序检索数据

## 5.1.排序数据

order by

## 5.2.按多个列排序

## 5.3.指定排序方向

desc/asc

和校对集有关 collaction

```mysql
mysql root@localhost:mysql_crash_course> show collation;

mysql root@localhost:mysql_crash_course> show create table products \G;
***************************[ 1. row ]***************************
Table        | products
Create Table | CREATE TABLE `products` (
  `prod_id` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `vend_id` int(11) NOT NULL,
  `prod_name` char(255) COLLATE utf8_unicode_ci NOT NULL,
  `prod_price` decimal(8,2) NOT NULL,
  `prod_desc` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`prod_id`),
  KEY `fk_products_vendors` (`vend_id`),
  CONSTRAINT `fk_products_vendors` FOREIGN KEY (`vend_id`) REFERENCES `vendors` (`vend_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci
```

## 5.4.小结

本章学习了如何用SELECT语句的ORDER BY子句对检索出的数据进行
排序。这个子句必须是SELECT语句中的最后一条子句。可根据需要，利
用它在一个或多个列上对数据进行排序。



# 6.过滤数据

## 6.1.使用WHERE子句

## 6.2.WHERE子句操作符

=
<>
!=
<
<=

>
>=
>between

## 6.3.小结

本章介绍了如何用SELECT语句的WHERE子句过滤返回的数据。我们学
习了如何对相等、不相等、大于、小于、值的范围以及NULL值等进行测
试。

# 7.数据过滤

## 7.1.组合WHERE子句

and
or

## 7.2.IN操作符

## 7.3.NOT 操作符

## 7.4.小结

本章讲授如何用AND和OR操作符组合成WHERE子句，而且还讲授了如
何明确地管理计算的次序，如何使用IN和NOT操作符。

# 8.用通配符进行过滤

%
_

## 8.1.LIKE操作符

## 8.2.使用通配符的技巧

## 8.3.小结

本章介绍了什么是通配符以及如何在WHERE子句中使用SQL通配符，
并且还说明了通配符应该细心使用，不要过度使用。

# 9.用正则表达式进行搜索

regexp

```mysql
mysql root@localhost:mysql_crash_course> select prod_name
                                      -> from products
                                      -> where prod_name regexp '10000'
                                      -> order by prod_name;
+-------------+
| prod_name   |
|-------------|
+-------------+
0 rows in set
Time: 0.005s

mysql root@localhost:mysql_crash_course> select prod_name
                                      -> from products
                                      -> where prod_name regexp '.000'
                                      -> order by prod_name;
+--------------+

| prod_name    |
| ------------ |
| JetPack 1000 |
| JetPack 2000 |

+--------------+
2 rows in set
Time: 0.002s
```

## 9.1.正则表达式介绍

## 9.2.使用MySql正则表达式

## 9.3.小结

本章介绍了正则表达式的基础知识，学习了如何在MySQL的SELECT
语句中通过REGEXP关键字使用它们。



# 10.创建计算字段

## 10.1.计算字段

```mysql
mysql root@localhost:mysql_crash_course> select prod_price, prod_price*1.1  AS "涨价10%" from products;
+--------------+-----------+
|   prod_price |   涨价10% |
|--------------+-----------|
|         5.99 |     6.589 |
|         9.99 |    10.989 |
|        14.99 |    16.489 |
|        13    |    14.3   |
|        10    |    11     |
|         2.5  |     2.75  |
|         3.42 |     3.762 |
|        35    |    38.5   |
|        55    |    60.5   |
|         8.99 |     9.889 |
|        50    |    55     |
|         4.49 |     4.939 |
|         2.5  |     2.75  |
|        10    |    11     |
+--------------+-----------+
14 rows in set
```

## 10.2.拼接字段

```mysql
mysql root@localhost:mysql_crash_course> select concat(vend_name, '(', vend_country, ')') from vendors 
                                      -> order by vend_name;
+---------------------------------------------+

| concat(vend_name, '(', vend_country, ')') |
| ----------------------------------------- |
| ACME(USA)                                 |
| Anvils R Us(USA)                          |
| Furball Inc.(USA)                         |
| Jet Set(England)                          |
| Jouets Et Ours(France)                    |
| LT Supplies(USA)                          |

+---------------------------------------------+
6 rows in set
Time: 0.001s
```



## 10.3.执行算术计算

```mysql
mysql root@localhost:mysql_crash_course> select prod_id, quantity, item_price, quantity * item_price AS ex
                                      -> pander_price 
                                      -> from orderitems
                                      -> where order_num = 20005;
+-----------+------------+--------------+------------------+
| prod_id   |   quantity |   item_price |   expander_price |
|-----------+------------+--------------+------------------|
| ANV01     |         10 |         5.99 |            59.9  |
| ANV02     |          3 |         9.99 |            29.97 |
| TNT2      |          5 |        10    |            50    |
| FB        |          1 |        10    |            10    |
+-----------+------------+--------------+------------------+
4 rows in set
```



## 10.4.小结

本章介绍了计算字段以及如何创建计算字段。我们用例子说明了计
算字段在串拼接和算术计算的用途。此外，还学习了如何创建和使用别
名，以便应用程序能引用计算字段

# 11.使用数据处理函数

## 11.1.函数

与其他大多数计算机语言一样，SQL支持利用函数来处理数据。函数
一般是在数据上执行的，它给数据的转换和处理提供了方便。
在前一章中用来去掉串尾空格的RTrim()就是一个函数的例子。

## 11.2.使用函数

 用于处理文本串（如删除或填充值，转换值为大写或小写）的文本函数。

 用于在数值数据上进行算术操作（如返回绝对值，进行代数运算）
的数值函数。

 用于处理日期和时间值并从这些值中提取特定成分（例如，返回
两个日期之差，检查日期有效性等）的日期和时间函数。

 返回DBMS正使用的特殊信息（如返回用户登录信息，检查版本
细节）的系统函数。

```mysql
mysql root@localhost:mysql_crash_course> select vend_name, upper(vend_name) as vend_name_upcase
                                      -> from vendors
                                      -> order by vend_name;
+----------------+--------------------+
| vend_name      | vend_name_upcase   |
|----------------+--------------------|
| ACME           | ACME               |
| Anvils R Us    | ANVILS R US        |
| Furball Inc.   | FURBALL INC.       |
| Jet Set        | JET SET            |
| Jouets Et Ours | JOUETS ET OURS     |
| LT Supplies    | LT SUPPLIES        |
+----------------+--------------------+
```



Left() 返回串左边的字符
Length() 返回串的长度
Locate() 找出串的一个子串
Lower() 将串转换为小写
LTrim() 去掉串左边的空格
Right() 返回串右边的字符
RTrim() 去掉串右边的空格
Soundex() 返回串的SOUNDEX值
SubString() 返回子串的字符
Upper() 将串转换为大写



```mysql
mysql root@localhost:mysql_crash_course> help soundex;
+---------+---------------+-----------+
| name    | description   | example   |
|---------+---------------+-----------|
| SOUNDEX | Syntax:
SOUNDEX(str)

Returns a soundex string from str. Two strings that sound almost the
same should have identical soundex strings. A standard soundex string
is four characters long, but the SOUNDEX() function returns an
arbitrarily long string. You can use SUBSTRING() on the result to get a
standard soundex string. All nonalphabetic characters in str are
ignored. All international alphabetic characters outside the A-Z range
are treated as vowels.

*Important*:

When using SOUNDEX(), you should be aware of the following limitations:

o This function, as currently implemented, is intended to work well
  with strings that are in the English language only. Strings in other
  languages may not produce reliable results.

o This function is not guaranteed to provide consistent results with
  strings that use multibyte character sets, including utf-8. See Bug
  #22638 for more information.

URL: http://dev.mysql.com/doc/refman/8.0/en/string-functions.html
 | mysql> SELECT SOUNDEX('Hello');
    -> 'H400'
    
mysql> SELECT SOUNDEX('Quadratically');
        -> 'Q36324'
           |
+---------+---------------+-----------+
Time: 0.001s
mysql root@localhost:mysql_crash_course> select soundex('jieqiang');
+-----------------------+


| soundex('jieqiang') |
| ------------------- |
| J520                |

+-----------------------+
1 row in set

mysql root@localhost:mysql_crash_course> help left;
+--------+---------------+-----------+
| name   | description   | example   |
|--------+---------------+-----------|
| LEFT   | Syntax:
LEFT(str,len)

Returns the leftmost len characters from the string str, or NULL if any
argument is NULL.

URL: http://dev.mysql.com/doc/refman/8.0/en/string-functions.html

               | mysql> SELECT LEFT('foobarbar', 5);
        -> 'fooba'
           |

+--------+---------------+-----------+
Time: 0.001s
mysql root@localhost:mysql_crash_course> select left('jieqiang', 3);
+-----------------------+

| left('jieqiang', 3) |
| ------------------- |
| jie                 |

+-----------------------+
1 row in set
Time: 0.001s
```




表11-2 常用日期和时间处理函数
函 数 说 明
AddDate() 增加一个日期（天、周等）
AddTime() 增加一个时间（时、分等）
CurDate() 返回当前日期
CurTime() 返回当前时间
Date() 返回日期时间的日期部分
DateDiff() 计算两个日期之差
Date_Add() 高度灵活的日期运算函数
Date_Format() 返回一个格式化的日期或时间串
Day() 返回一个日期的天数部分
DayOfWeek() 对于一个日期，返回对应的星期几
Hour() 返回一个时间的小时部分
Minute() 返回一个时间的分钟部分
Month() 返回一个日期的月份部分
Now() 返回当前日期和时间
Second() 返回一个时间的秒部分
Time() 返回一个日期时间的时间部分
Year() 返回一个日期的年份部分

```mysql
mysql root@localhost:mysql_crash_course> help adddate;
+---------+---------------+-----------+
| name    | description   | example   |
|---------+---------------+-----------|
| ADDDATE | Syntax:
ADDDATE(date,INTERVAL expr unit), ADDDATE(expr,days)

When invoked with the INTERVAL form of the second argument, ADDDATE()
is a synonym for DATE_ADD(). The related function SUBDATE() is a
synonym for DATE_SUB(). For information on the INTERVAL unit argument,
see the discussion for DATE_ADD().

mysql> SELECT DATE_ADD('2008-01-02', INTERVAL 31 DAY);
        -> '2008-02-02'
mysql> SELECT ADDDATE('2008-01-02', INTERVAL 31 DAY);
        -> '2008-02-02'

When invoked with the days form of the second argument, MySQL treats it
as an integer number of days to be added to expr.

URL: http://dev.mysql.com/doc/refman/8.0/en/date-and-time-functions.html

               | mysql> SELECT ADDDATE('2008-01-02', 31);
        -> '2008-02-02'
           |

mysql root@localhost:mysql_crash_course> select * from orders 
                                      -> where order_date = "2005-09-01";
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
+-------------+---------------------+-----------+
1 row in set
Time: 0.001s
mysql root@localhost:mysql_crash_course> select *, date('order_date') from orders;
+-------------+---------------------+-----------+----------------------+
|   order_num | order_date          |   cust_id |   date('order_date') |
|-------------+---------------------+-----------+----------------------|
|       20005 | 2005-09-01 00:00:00 |     10001 |               <null> |
|       20006 | 2005-09-12 00:00:00 |     10003 |               <null> |
|       20007 | 2005-09-30 00:00:00 |     10004 |               <null> |
|       20008 | 2005-10-03 00:00:00 |     10005 |               <null> |
|       20009 | 2005-10-08 00:00:00 |     10001 |               <null> |
+-------------+---------------------+-----------+----------------------+
5 rows in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> select *, date(order_date) from orders;
+-------------+---------------------+-----------+--------------------+
|   order_num | order_date          |   cust_id | date(order_date)   |
|-------------+---------------------+-----------+--------------------|
|       20005 | 2005-09-01 00:00:00 |     10001 | 2005-09-01         |
|       20006 | 2005-09-12 00:00:00 |     10003 | 2005-09-12         |
|       20007 | 2005-09-30 00:00:00 |     10004 | 2005-09-30         |
|       20008 | 2005-10-03 00:00:00 |     10005 | 2005-10-03         |
|       20009 | 2005-10-08 00:00:00 |     10001 | 2005-10-08         |
+-------------+---------------------+-----------+--------------------+
5 rows in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> select * from orders 
                                      -> where date(order_date) = "2005-09-01";
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
+-------------+---------------------+-----------+
1 row in set
Time: 0.001s


mysql root@localhost:mysql_crash_course> # 筛选2005年9月的数据
                                      -> select * from orders 
                                      -> where year(order_date) = 2005 AND month(order_date) = 9; 
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
|       20006 | 2005-09-12 00:00:00 |     10003 |
|       20007 | 2005-09-30 00:00:00 |     10004 |
+-------------+---------------------+-----------+
3 rows in set
Time: 0.003s
mysql root@localhost:mysql_crash_course> # 筛选2005年9月的数据
                                      -> select * from orders 
                                      -> where year(order_date) = '2005' AND month(order_date) = '9'; 
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
|       20006 | 2005-09-12 00:00:00 |     10003 |
|       20007 | 2005-09-30 00:00:00 |     10004 |
+-------------+---------------------+-----------+
3 rows in set
Time: 0.002s


mysql root@localhost:mysql_crash_course> create table orders_cp_select 
                                      -> select * from orders;
Query OK, 5 rows affected
Time: 0.077s
mysql root@localhost:mysql_crash_course> show tables;
+--------------------------------+

| Tables_in_mysql_crash_course |
| ---------------------------- |
| customers                    |
| orderitems                   |
| orders                       |
| orders_cp_select             |
| productnotes                 |
| products                     |
| vendors                      |

+--------------------------------+
7 rows in set
Time: 0.003s
mysql root@localhost:mysql_crash_course> show create table orders_cp_select;
+------------------+----------------+
| Table            | Create Table   |
|------------------+----------------|
| orders_cp_select | CREATE TABLE `orders_cp_select` (
  `order_num` int(11) NOT NULL DEFAULT '0',
  `order_date` datetime NOT NULL,
  `cust_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                |
+------------------+----------------+
1 row in set
Time: 0.003s
mysql root@localhost:mysql_crash_course> show create table orders;
+---------+----------------+
| Table   | Create Table   |
|---------+----------------|
| orders  | CREATE TABLE `orders` (
  `order_num` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `cust_id` int(11) NOT NULL,
  PRIMARY KEY (`order_num`),
  KEY `fk_orders_customers` (`cust_id`),
  CONSTRAINT `fk_orders_customers` FOREIGN KEY (`cust_id`) REFERENCES `customers` (`cust_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20010 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                |
+---------+----------------+
1 row in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> create table orders_cp_like orders;
(1064, "You have an error in your SQL syntax; check the manual that corresponds to your MySQL server version for the right syntax to use near 'orders' at line 1")
mysql root@localhost:mysql_crash_course> create table orders_cp_like like  orders;
Query OK, 0 rows affected
Time: 0.099s
mysql root@localhost:mysql_crash_course> show create table orders_cp_like;
+----------------+----------------+
| Table          | Create Table   |
|----------------+----------------|
| orders_cp_like | CREATE TABLE `orders_cp_like` (
  `order_num` int(11) NOT NULL AUTO_INCREMENT,
  `order_date` datetime NOT NULL,
  `cust_id` int(11) NOT NULL,
  PRIMARY KEY (`order_num`),
  KEY `fk_orders_customers` (`cust_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                |
+----------------+----------------+
1 row in set
Time: 0.003s
```




> 表11-3 常用数值处理函数
> 函 数 说 明
> Abs() 返回一个数的绝对值
> Cos() 返回一个角度的余弦
> Exp() 返回一个数的指数值
> Mod() 返回除操作的余数
> Pi() 返回圆周率
> Rand() 返回一个随机数
> Sin() 返回一个角度的正弦
> Sqrt() 返回一个数的平方根
> Tan() 返回一个角度的正切



## 11.3.小结

本章介绍了如何使用SQL的数据处理函数，并着重介绍了日期处理函数。

本章介绍什么是SQL的聚集函数以及如何利用它们汇总表的数据。



# 12.汇总数据

## 12.1.聚集函数

我们经常需要汇总数据而不用把它们实际检索出来，为此MySQL提
供了专门的函数。使用这些函数，MySQL查询可用于检索数据，以便分
析和报表生成。这种类型的检索例子有以下几种。
 确定表中行数（或者满足某个条件或包含某个特定值的行数）。
 获得表中行组的和。
 找出表列（或所有行或某些特定的行）的最大值、最小值和平均
值。
上述例子都需要对表中数据（而不是实际数据本身）汇总。因此，
返回实际表数据是对时间和处理资源的一种浪费（更不用说带宽了）。重
复一遍，实际想要的是汇总信息。

表12-1 SQL聚集函数
函 数 说 明
AVG() 返回某列的平均值
COUNT() 返回某列的行数
MAX() 返回某列的最大值
MIN() 返回某列的最小值
SUM() 返回某列值之和

```mysql
mysql root@localhost:mysql_crash_course> select avg(prod_price) as avg_price
                                      -> from products;
+-------------+
| avg_price |
| --------- |
| 16.1336   |
+-------------+
1 row in set

mysql root@localhost:mysql_crash_course> select count(*) as num_cust
                                      -> from customers;
+------------+
| num_cust |
| -------- |
| 5        |
+------------+
1 row in set
Time: 0.003s

在此例子中，利用COUNT(*)对所有行计数，不管行中各列有
什么值。计数值在num_cust中返回。


mysql root@localhost:mysql_crash_course> select count(cust_email) as num_cust
                                      -> from customers;
+------------+
| num_cust |
| -------- |
| 3        |
+------------+
1 row in set
Time: 0.001s
```

这条SELECT语句使用COUNT(cust_email)对cust_email列
中有值的行进行计数。在此例子中，cust_email的计数为3（表
示5个客户中只有3个客户有电子邮件地址）。

## 12.2.聚集不同值

```
mysql root@localhost:mysql_crash_course> select avg(distinct prod_price) as avg_price
                                      -> from products
                                      -> where  vend_id=1003;
+-------------+
| avg_price |
| --------- |
| 15.998    |
+-------------+
1 row in set
Time: 0.003s
```

## 12.3.组合聚集函数

表字段不能带引号

```
mysql root@localhost:mysql_crash_course> select count(*) as num_items, min(prod_price) as 'price_min', max
                                      -> (prod_price) as "price_max", avg(prod_price) as price_avg
                                      -> from products;
+-------------+-------------+-------------+-------------+
|   num_items |   price_min |   price_max |   price_avg |
|-------------+-------------+-------------+-------------|
|          14 |         2.5 |          55 |     16.1336 |
+-------------+-------------+-------------+-------------+
1 row in set
```

## 12.4.小结

聚集函数用来汇总数据。MySQL支持一系列聚集函数，可以用多种
方法使用它们以返回所需的结果。这些函数是高效设计的，它们返回结
果一般比你在自己的客户机应用程序中计算要快得多。

# 13.分组数据

group by

## 13.1.数据分组

从上一章知道，SQL聚集函数可用来汇总数据。这使我们能够对行进
行计数，计算和与平均数，获得最大和最小值而不用检索所有数据。
13.2.创建分组

```mysql
mysql root@localhost:mysql_crash_course> select vend_id, count(*) as num_prods
                                      -> from products
                                      -> group by vend_id;
+-----------+-------------+
|   vend_id |   num_prods |
|-----------+-------------|
|      1001 |           3 |
|      1002 |           2 |
|      1003 |           7 |
|      1005 |           2 |
+-----------+-------------+
4 rows in set
Time: 0.001s
```

## 13.3.过滤分组

除了能用GROUP BY分组数据外，MySQL还允许过滤分组，规定包括
哪些分组，排除哪些分组。例如，可能想要列出至少有两个订单的所有
顾客。为得出这种数据，必须基于完整的分组而不是个别的行进行过滤。
我们已经看到了WHERE子句的作用（第6章中引入）。但是，在这个例
子中WHERE不能完成任务，因为WHERE过滤指定的是行而不是分组。事实
上，WHERE没有分组的概念。
那么，不使用WHERE使用什么呢？MySQL为此目的提供了另外的子
句，那就是HAVING子句。HAVING非常类似于WHERE。事实上，目前为止所
学过的所有类型的WHERE子句都可以用HAVING来替代。唯一的差别是
WHERE过滤行，而HAVING过滤分组

```
mysql root@localhost:mysql_crash_course> select cust_id, count(*) as orders
                                      -> from orders
                                      -> group by cust_id
                                      -> having orders >= 2;
+-----------+----------+
|   cust_id |   orders |
|-----------+----------|
|     10001 |        2 |
+-----------+----------+
1 row in set
Time: 0.004s
mysql root@localhost:mysql_crash_course> explain select cust_id, count(*) as orders
                                      -> from orders
                                      -> group by cust_id
                                      -> having orders >= 2;
+------+---------------+---------+--------------+--------+---------------------+---------------------+-----------+--------+--------+------------+-------------+
|   id | select_type   | table   |   partitions | type   | possible_keys       | key                 |   key_len |    ref |   rows |   filtered | Extra       |
|------+---------------+---------+--------------+--------+---------------------+---------------------+-----------+--------+--------+------------+-------------|
|    1 | SIMPLE        | orders  |       <null> | index  | fk_orders_customers | fk_orders_customers |         4 | <null> |      5 |        100 | Using index |
+------+---------------+---------+--------------+--------+---------------------+---------------------+-----------+--------+--------+------------+-------------+
1 row in set
Time: 0.004s
mysql root@localhost:mysql_crash_course> show warnings;
+---------+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Level   |   Code | Message                                                                                                                                                                                                    |
|---------+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note    |   1003 | /* select#1 */ select `mysql_crash_course`.`orders`.`cust_id` AS `cust_id`,count(0) AS `orders` from `mysql_crash_course`.`orders` group by `mysql_crash_course`.`orders`.`cust_id` having (`orders` >= 2) |
+---------+--------+------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set
Time: 0.003s
```



## 13.4.分组和排序

```
mysql root@localhost:mysql_crash_course> select order_num, sum(quantity * item_price) as ordertotal
                                      -> from orderitems
                                      -> group by order_num
                                      -> having sum(ordertotal) >= 50;
+-------------+--------------+
|   order_num |   ordertotal |
|-------------+--------------|
|       20005 |       149.87 |
|       20006 |        55    |
|       20007 |      1000    |
|       20008 |       125    |
|       20009 |        38.47 |
+-------------+--------------+
5 rows in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> explain select order_num, sum(quantity * item_price) as ordertota
                                      -> l
                                      -> from orderitems
                                      -> group by order_num
                                      -> having sum(ordertotal) >= 50;
+------+---------------+------------+--------------+--------+--------------------------------+---------+-----------+--------+--------+------------+---------+
|   id | select_type   | table      |   partitions | type   | possible_keys                  | key     |   key_len |    ref |   rows |   filtered |   Extra |
|------+---------------+------------+--------------+--------+--------------------------------+---------+-----------+--------+--------+------------+---------|
|    1 | SIMPLE        | orderitems |       <null> | index  | PRIMARY,fk_orderitems_products | PRIMARY |         8 | <null> |     11 |        100 |  <null> |
+------+---------------+------------+--------------+--------+--------------------------------+---------+-----------+--------+--------+------------+---------+
1 row in set
Time: 0.003s
mysql root@localhost:mysql_crash_course> show warnings;
+---------+--------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
| Level   |   Code | Message                                                                                                                                                                                                                                                                                                                                |
|---------+--------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Note    |   1003 | /* select#1 */ select `mysql_crash_course`.`orderitems`.`order_num` AS `order_num`,sum((`mysql_crash_course`.`orderitems`.`quantity` * `mysql_crash_course`.`orderitems`.`item_price`)) AS `ordertotal` from `mysql_crash_course`.`orderitems` group by `mysql_crash_course`.`orderitems`.`order_num` having (sum(`ordertotal`) >= 50) |
+---------+--------+----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
1 row in set
Time: 0.002s
mysql root@localhost:mysql_crash_course> 
```

## 13.5.SELECT子句排序

下面回顾一下SELECT语句中子句的顺序。表13-2以在SELECT语句中
使用时必须遵循的次序，列出迄今为止所学过的子句。
表13-2 SELECT子句及其顺序
子 句 说 明 是否必须使用
SELECT 要返回的列或表达式 是
FROM 从中检索数据的表 仅在从表选择数据时使用
WHERE 行级过滤 否
分析
输入
输出
输入
输出
（续）
子 句 说 明 是否必须使用
GROUP BY 分组说明 仅在按组计算聚集时使用
HAVING 组级过滤 否
ORDER BY 输出排序顺序 否
LIMIT 要检索的行数 否

## 13.6.小结

在第12章中，我们学习了如何用SQL聚集函数对数据进行汇总计算。
本章讲授了如何使用GROUP BY子句对数据组进行这些汇总计算，返回每
个组的结果。我们看到了如何使用HAVING子句过滤特定的组，还知道了
ORDER BY和GROUP BY之间以及WHERE和HAVING之间的差异。



# 14.使用子查询

## 14.1.子查询

SQL还允许创建子查询（subquery），即嵌套在其他查询中的查询。

## 14.2.利用子查询进行过滤

```
mysql root@localhost:mysql_crash_course> select cust_id
                                      -> from orders
                                      -> where order_num in (
                                      -> select order_num from orderitems where prod_id= 'TNT2'
                                      -> );
+-----------+

| cust_id |
| ------- |
| 10001   |
| 10004   |

+-----------+
2 rows in set
Time: 0.004s

mysql root@localhost:mysql_crash_course> 
```



## 14.3.作为计算字段使用子查询

```
select cust_name, cust_state,
                                      -> (select count(*) from orders
                                      -> where orders.cust_id = customers.cust_id) as orders
                                      -> from customers
                                      -> order by cust_name;
+----------------+--------------+----------+
| cust_name      | cust_state   |   orders |
|----------------+--------------+----------|
| Coyote Inc.    | MI           |        2 |
| E Fudd         | IL           |        1 |
| Mouse House    | OH           |        0 |
| Wascals        | IN           |        1 |
| Yosemite Place | AZ           |        1 |
+----------------+--------------+----------+
5 rows in set
Time: 0.003s
```



## 14.4.小结

本章学习了什么是子查询以及如何使用它们。子查询最常见的使用
是在WHERE子句的IN操作符中，以及用来填充计算列。我们举了这两种操
作类型的例子



# 15.联结表

## 15.1.联结

SQL最强大的功能之一就是能在数据检索查询的执行中联结（join）
表。联结是利用SQL的SELECT能执行的最重要的操作，很好地理解联结
及其语法是学习SQL的一个极为重要的组成部分。
在能够有效地使用联结前，必须了解关系表以及关系数据库设计的
一些基础知识。下面的介绍并不是这个内容的全部知识，但作为入门已
经足够了。

## 15.2.创建联结

```
mysql root@localhost:mysql_crash_course> select vend_name, prod_name, prod_price
                                      -> from vendors, products
                                      -> where vendors.vend_id = products.vend_id
                                      -> order by vend_name, prod_name;
+-------------+----------------+--------------+
| vend_name   | prod_name      |   prod_price |
|-------------+----------------+--------------|
| ACME        | Bird seed      |        10    |
| ACME        | Carrots        |         2.5  |
| ACME        | Detonator      |        13    |
| ACME        | Safe           |        50    |
| ACME        | Sling          |         4.49 |
| ACME        | TNT (1 stick)  |         2.5  |
| ACME        | TNT (5 sticks) |        10    |
| Anvils R Us | .5 ton anvil   |         5.99 |
| Anvils R Us | 1 ton anvil    |         9.99 |
| Anvils R Us | 2 ton anvil    |        14.99 |
| Jet Set     | JetPack 1000   |        35    |
| Jet Set     | JetPack 2000   |        55    |
| LT Supplies | Fuses          |         3.42 |
| LT Supplies | Oil can        |         8.99 |
+-------------+----------------+--------------+
14 rows in set
```



## 15.3.小结

联结是SQL中最重要最强大的特性，有效地使用联结需要对关系数据
库设计有基本的了解。本章随着对联结的介绍讲述了关系数据库设计的
一些基本知识，包括等值联结（也称为内部联结）这种最经常使用的联
结形式。下一章将介绍如何创建其他类型的联结。



# 16.创建高级联结

## 16.1.使用表别名

```
mysql root@localhost:mysql_crash_course> select cust_name, cust_contact
                                      -> from customers as c, orders as o, orderitems as oi
                                      -> where c.cust_id = o.cust_id
                                      -> AND oi.order_num = o.order_num
                                      -> AND prod_id = 'TNT2';
+----------------+----------------+
| cust_name      | cust_contact   |
|----------------+----------------|
| Coyote Inc.    | Y Lee          |
| Yosemite Place | Y Sam          |
+----------------+----------------+
2 rows in set
Time: 0.002s
```



## 16.2.使用不同类型的联结

### 16.2.1.自联结

```
mysql root@localhost:mysql_crash_course> select p1.prod_id, p1.prod_name
                                      -> from products as p1, products as p2
                                      -> where p1.vend_id = p2.vend_id
                                      -> AND p2.prod_id = 'DTNTR';
+-----------+----------------+
| prod_id   | prod_name      |
|-----------+----------------|
| DTNTR     | Detonator      |
| FB        | Bird seed      |
| FC        | Carrots        |
| SAFE      | Safe           |
| SLING     | Sling          |
| TNT1      | TNT (1 stick)  |
| TNT2      | TNT (5 sticks) |
+-----------+----------------+
7 rows in set
```

### 16.2.2.自然联结

```
mysql root@localhost:mysql_crash_course> select c.*, o.order_num, o.order_date, oi.prod_id, oi.quantity, o
                                      -> i.item_price
                                      -> from customers as c, orders as o, orderitems as oi
                                      -> where c.cust_id = o.cust_id
                                      -> AND oi.order_num = o.order_num
                                      -> AND prod_id = 'FB';
+-----------+-------------+----------------+-------------+--------------+------------+----------------+----------------+-----------------+-------------+---------------------+-----------+------------+--------------+
|   cust_id | cust_name   | cust_address   | cust_city   | cust_state   |   cust_zip | cust_country   | cust_contact   | cust_email      |   order_num | order_date          | prod_id   |   quantity |   item_price |
|-----------+-------------+----------------+-------------+--------------+------------+----------------+----------------+-----------------+-------------+---------------------+-----------+------------+--------------|
|     10001 | Coyote Inc. | 200 Maple Lane | Detroit     | MI           |      44444 | USA            | Y Lee          | ylee@coyote.com |       20005 | 2005-09-01 00:00:00 | FB        |          1 |           10 |
|     10001 | Coyote Inc. | 200 Maple Lane | Detroit     | MI           |      44444 | USA            | Y Lee          | ylee@coyote.com |       20009 | 2005-10-08 00:00:00 | FB        |          1 |           10 |
+-----------+-------------+----------------+-------------+--------------+------------+----------------+----------------+-----------------+-------------+---------------------+-----------+------------+--------------+
2 rows in set
Time: 0.003s
```

### 16.2.3.外部联结

```
mysql root@localhost:mysql_crash_course> select customers.cust_id, orders.order_num
                                      -> from customers left outer join orders
                                      -> on customers.cust_id = orders.cust_id;
+-----------+-------------+
|   cust_id |   order_num |
|-----------+-------------|
|     10001 |       20005 |
|     10001 |       20009 |
|     10002 |      <null> |
|     10003 |       20006 |
|     10004 |       20007 |
|     10005 |       20008 |
+-----------+-------------+
6 rows in set
Time: 0.002s
```

## 16.3.使用带聚集函数的联结

## 16.4.使用联结和联结条件

## 16.5.小结

本章是上一章关于联结的继续。本章从讲授如何以及为什么要使用
别名开始，然后讨论不同的联结类型及对每种类型的联结使用的各种语
法形式。我们还介绍了如何与联结一起使用聚集函数，以及在使用联结
时应该注意的某些问题。



# 17.组合查询

## 17.1.组合查询

多数SQL查询都只包含从一个或多个表中返回数据的单条SELECT语
句。MySQL也允许执行多个查询（多条SELECT语句），并将结果作为单个
查询结果集返回。这些组合查询通常称为并（union）或复合查询
（compound query）。

## 17.2.创建组合查询

union/union all

```
mysql root@localhost:mysql_crash_course> select vend_id, prod_id, prod_price
                                      -> from products
                                      -> where prod_price <= 5
                                      -> union
                                      -> select vend_id, prod_id, prod_price
                                      -> from products
                                      -> where vend_id in (1001, 1002);
+-----------+-----------+--------------+
|   vend_id | prod_id   |   prod_price |
|-----------+-----------+--------------|
|      1003 | FC        |         2.5  |
|      1002 | FU1       |         3.42 |
|      1003 | SLING     |         4.49 |
|      1003 | TNT1      |         2.5  |
|      1001 | ANV01     |         5.99 |
|      1001 | ANV02     |         9.99 |
|      1001 | ANV03     |        14.99 |
|      1002 | OL1       |         8.99 |
+-----------+-----------+--------------+
8 rows in set

mysql root@localhost:mysql_crash_course> select vend_id, prod_id, prod_price
                                      -> from products
                                      -> where prod_price <= 5
                                      -> union all
                                      -> select vend_id, prod_id, prod_price
                                      -> from products
                                      -> where vend_id in (1001, 1002);
+-----------+-----------+--------------+
|   vend_id | prod_id   |   prod_price |
|-----------+-----------+--------------|
|      1003 | FC        |         2.5  |
|      1002 | FU1       |         3.42 |
|      1003 | SLING     |         4.49 |
|      1003 | TNT1      |         2.5  |
|      1001 | ANV01     |         5.99 |
|      1001 | ANV02     |         9.99 |
|      1001 | ANV03     |        14.99 |
|      1002 | FU1       |         3.42 |
|      1002 | OL1       |         8.99 |
+-----------+-----------+--------------+
9 rows in set
```

## 17.3.小结

本章讲授如何用UNION操作符来组合SELECT语句。利用UNION，可把
多条查询的结果作为一条组合查询返回，不管它们的结果中包含还是不
包含重复。使用UNION可极大地简化复杂的WHERE子句，简化从多个表中
检索数据的工作。



# 18.全文本搜索

## 18.1.理解全文本搜索

并非所有引擎都支持全文本搜索 正如第21章所述，MySQL
支持几种基本的数据库引擎。并非所有的引擎都支持本书所描
述的全文本搜索。两个最常使用的引擎为MyISAM和InnoDB，
前者支持全文本搜索，而后者不支持。这就是为什么虽然本书
中创建的多数样例表使用 InnoDB ，而有一个样例表
（productnotes表）却使用MyISAM的原因。如果你的应用中需
要全文本搜索功能，应该记住这一点。

## 18.2.使用全文本搜索

```mysql
mysql root@localhost:mysql_crash_course> show create table productnotes;
+--------------+----------------+
| Table        | Create Table   |
|--------------+----------------|
| productnotes | CREATE TABLE `productnotes` (
  `note_id` int(11) NOT NULL AUTO_INCREMENT,
  `prod_id` char(10) COLLATE utf8_unicode_ci NOT NULL,
  `note_date` datetime NOT NULL,
  `note_text` text COLLATE utf8_unicode_ci,
  PRIMARY KEY (`note_id`),
  FULLTEXT KEY `note_text` (`note_text`)
) ENGINE=MyISAM AUTO_INCREMENT=115 DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci                |
+--------------+----------------+
1 row in set

mysql root@localhost:mysql_crash_course> select note_text
                                      -> from productnotes
                                      -> where match(note_text) against('rabbit');
+----------------------------------------------------------------------------------------------+

| note_text                                                    |
| ------------------------------------------------------------ |
| Customer complaint: rabbit has been able to detect trap, food apparently less effective now. |

| Quantity varies, sold by the sack load.
All guaranteed to be bright and orange, and suitable for use as rabbit bait.                                                                                              |
+----------------------------------------------------------------------------------------------+
2 rows in set

mysql root@localhost:mysql_crash_course> select note_text, match(note_text) against('rabbit')  from productnotes \G;
***************************[ 1. row ]***************************
note_text                          | Customer complaint:
Sticks not individually wrapped, too easy to mistakenly detonate all at once.
Recommend individual wrapping.
match(note_text) against('rabbit') | 0
***************************[ 2. row ]***************************
note_text                          | Can shipped full, refills not available.
Need to order new can if refill needed.
match(note_text) against('rabbit') | 0
***************************[ 3. row ]***************************
note_text                          | Safe is combination locked, combination not provided with safe.
This is rarely a problem as safes are typically blown up or dropped by customers.
match(note_text) against('rabbit') | 0
***************************[ 4. row ]***************************
note_text                          | Quantity varies, sold by the sack load.
All guaranteed to be bright and orange, and suitable for use as rabbit bait.
match(note_text) against('rabbit') | 1.5905543565750122
***************************[ 5. row ]***************************
note_text                          | Included fuses are short and have been known to detonate too quickly for some customers.
Longer fuses are available (item FU1) and should be recommended.
match(note_text) against('rabbit') | 0
***************************[ 6. row ]***************************
note_text                          | Matches not included, recommend purchase of matches or detonator (item DTNTR).
match(note_text) against('rabbit') | 0
***************************[ 7. row ]***************************
note_text                          | Please note that no returns will be accepted if safe opened using explosives.
match(note_text) against('rabbit') | 0
***************************[ 8. row ]***************************
note_text                          | Multiple customer returns, anvils failing to drop fast enough or falling backwards on purchaser. Recommend that customer considers using heavier anvils.
match(note_text) against('rabbit') | 0
***************************[ 9. row ]***************************
note_text                          | Item is extremely heavy. Designed for dropping, not recommended for use with slings, ropes, pulleys, or tightropes.
match(note_text) against('rabbit') | 0
***************************[ 10. row ]***************************
note_text                          | Customer complaint: rabbit has been able to detect trap, food apparently less effective now.
match(note_text) against('rabbit') | 1.6408053636550903
***************************[ 11. row ]***************************
note_text                          | Shipped unassembled, requires common tools (including oversized hammer).
match(note_text) against('rabbit') | 0
***************************[ 12. row ]***************************
note_text                          | Customer complaint:
Circular hole in safe floor can apparently be easily cut with handsaw.
match(note_text) against('rabbit') | 0
***************************[ 13. row ]***************************
note_text                          | Customer complaint:
Not heavy enough to generate flying stars around head of victim. If being purchased for dropping, recommend ANV02 or ANV03 instead.
match(note_text) against('rabbit') | 0
***************************[ 14. row ]***************************
note_text                          | Call from individual trapped in safe plummeting to the ground, suggests an escape hatch be added.
Comment forwarded to vendor.
match(note_text) against('rabbit') | 0

14 rows in set
```

## 18.3.小结

本章介绍了为什么要使用全文本搜索，以及如何使用MySQL的
Match()和Against()函数进行全文本搜索。我们还学习了查询扩展（它
能增加找到相关匹配的机会）和如何使用布尔方式进行更细致的查找控
制。



# 19.插入数据

## 19.1.数据插入

## 19.2.插入完整的行

## 19.3.插入多个行

## 19.4.插入检索出的数据

## 19.5.小结



# 20.更新和删除数据

## 20.1.更新数据

## 20.2.删除数据

## 20.3.更新和删除的指导原则

## 20.4.小结



# 21.创建和操纵表

## 21.1.创建表

## 21.2.更新表

## 21.3.删除表

## 21.4.重命名表

## 21.5.小结



# 22.使用视图

## 22.1.视图

## 22.2.使用视图

## 22.3.小结



# 23.使用存储过程

## 23.1.存储过程

## 23.2.为什么要使用存储过程

## 23.3.使用存储过程

## 23.4.小结



# 24.使用游标

## 24.1.游标

## 24.2.使用游标

## 24.3.小结



# 25.使用触发器

## 25.1.触发器

## 25.2.创建触发器

## 25.3.删除触发器

## 25.4.使用触发器

## 25.5.小结



# 26.管理事务处理

## 26.1.事务处理

事务处理（transaction processing）可以用来维护数据库的完整性，它
保证成批的MySQL操作要么完全执行，要么完全不执行。

## 26.2.控制事务处理

```
mysql root@localhost:mysql_crash_course> create table ordertotals_cp_select
                                      -> as 
                                      -> select * from orders;
Query OK, 5 rows affected
Time: 0.117s
mysql root@localhost:mysql_crash_course> select  * from ordertotals_cp_select;
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
|       20006 | 2005-09-12 00:00:00 |     10003 |
|       20007 | 2005-09-30 00:00:00 |     10004 |
|       20008 | 2005-10-03 00:00:00 |     10005 |
|       20009 | 2005-10-08 00:00:00 |     10001 |
+-------------+---------------------+-----------+
5 rows in set
Time: 0.001s
mysql root@localhost:mysql_crash_course> start transaction;
Query OK, 0 rows affected
Time: 0.001s
mysql root@localhost:mysql_crash_course> delete from ordertotals_cp_select;
You're about to run a destructive command.
Do you want to proceed? (y/n): y
Your call!
Query OK, 5 rows affected
Time: 0.001s
mysql root@localhost:mysql_crash_course> select * from ordertotals_cp_select;
+-------------+--------------+-----------+
| order_num   | order_date   | cust_id   |
|-------------+--------------+-----------|
+-------------+--------------+-----------+
0 rows in set
Time: 0.001s
mysql root@localhost:mysql_crash_course> rollback;
Query OK, 0 rows affected
Time: 0.074s
mysql root@localhost:mysql_crash_course> select * from ordertotals_cp_select;
+-------------+---------------------+-----------+
|   order_num | order_date          |   cust_id |
|-------------+---------------------+-----------|
|       20005 | 2005-09-01 00:00:00 |     10001 |
|       20006 | 2005-09-12 00:00:00 |     10003 |
|       20007 | 2005-09-30 00:00:00 |     10004 |
|       20008 | 2005-10-03 00:00:00 |     10005 |
|       20009 | 2005-10-08 00:00:00 |     10001 |
+-------------+---------------------+-----------+
5 rows in set
Time: 0.001s
mysql root@localhost:mysql_crash_course> 
```

## 26.3.小结

本章介绍了事务处理是必须完整执行的SQL语句块。我们学习了如何
使用COMMIT和ROLLBACK语句对何时写数据，何时撤销进行明确的管理。
还学习了如何使用保留点对回退操作提供更强大的控制。



# 27.全球化和本地化

## 27.1.字符集和校对顺序

数据库表被用来存储和检索数据。不同的语言和字符集需要以不同
的方式存储和检索。因此，MySQL需要适应不同的字符集（不同的字母
和字符），适应不同的排序和检索数据的方法。

## 27.2.使用字符集和校对顺序

```mysql
show charset;

mysql root@localhost:mysql_crash_course> show character set;
+-----------+---------------------------------+---------------------+----------+
| Charset   | Description                     | Default collation   |   Maxlen |
|-----------+---------------------------------+---------------------+----------|
| armscii8  | ARMSCII-8 Armenian              | armscii8_general_ci |        1 |
| ascii     | US ASCII                        | ascii_general_ci    |        1 |
| big5      | Big5 Traditional Chinese        | big5_chinese_ci     |        2 |
| binary    | Binary pseudo charset           | binary              |        1 |
| cp1250    | Windows Central European        | cp1250_general_ci   |        1 |
| cp1251    | Windows Cyrillic                | cp1251_general_ci   |        1 |
| cp1256    | Windows Arabic                  | cp1256_general_ci   |        1 |
| cp1257    | Windows Baltic                  | cp1257_general_ci   |        1 |
| cp850     | DOS West European               | cp850_general_ci    |        1 |
| cp852     | DOS Central European            | cp852_general_ci    |        1 |
| cp866     | DOS Russian                     | cp866_general_ci    |        1 |
| cp932     | SJIS for Windows Japanese       | cp932_japanese_ci   |        2 |
| dec8      | DEC West European               | dec8_swedish_ci     |        1 |
| eucjpms   | UJIS for Windows Japanese       | eucjpms_japanese_ci |        3 |
| euckr     | EUC-KR Korean                   | euckr_korean_ci     |        2 |
| gb18030   | China National Standard GB18030 | gb18030_chinese_ci  |        4 |
| gb2312    | GB2312 Simplified Chinese       | gb2312_chinese_ci   |        2 |
| gbk       | GBK Simplified Chinese          | gbk_chinese_ci      |        2 |
| geostd8   | GEOSTD8 Georgian                | geostd8_general_ci  |        1 |
| greek     | ISO 8859-7 Greek                | greek_general_ci    |        1 |
| hebrew    | ISO 8859-8 Hebrew               | hebrew_general_ci   |        1 |
| hp8       | HP West European                | hp8_english_ci      |        1 |
| keybcs2   | DOS Kamenicky Czech-Slovak      | keybcs2_general_ci  |        1 |
| koi8r     | KOI8-R Relcom Russian           | koi8r_general_ci    |        1 |
| koi8u     | KOI8-U Ukrainian                | koi8u_general_ci    |        1 |
| latin1    | cp1252 West European            | latin1_swedish_ci   |        1 |
| latin2    | ISO 8859-2 Central European     | latin2_general_ci   |        1 |
| latin5    | ISO 8859-9 Turkish              | latin5_turkish_ci   |        1 |
| latin7    | ISO 8859-13 Baltic              | latin7_general_ci   |        1 |
| macce     | Mac Central European            | macce_general_ci    |        1 |
| macroman  | Mac West European               | macroman_general_ci |        1 |
| sjis      | Shift-JIS Japanese              | sjis_japanese_ci    |        2 |
| swe7      | 7bit Swedish                    | swe7_swedish_ci     |        1 |
| tis620    | TIS620 Thai                     | tis620_thai_ci      |        1 |
| ucs2      | UCS-2 Unicode                   | ucs2_general_ci     |        2 |
| ujis      | EUC-JP Japanese                 | ujis_japanese_ci    |        3 |
| utf16     | UTF-16 Unicode                  | utf16_general_ci    |        4 |
| utf16le   | UTF-16LE Unicode                | utf16le_general_ci  |        4 |
| utf32     | UTF-32 Unicode                  | utf32_general_ci    |        4 |
| utf8      | UTF-8 Unicode                   | utf8_general_ci     |        3 |
| utf8mb4   | UTF-8 Unicode                   | utf8mb4_0900_ai_ci  |        4 |
+-----------+---------------------------------+---------------------+----------+
41 rows in set
Time: 0.006s

mysql root@localhost:mysql_crash_course> show collation;
+----------------------------+-----------+------+-----------+------------+-----------+-----------------+
| Collation                  | Charset   |   Id | Default   | Compiled   |   Sortlen | Pad_attribute   |
|----------------------------+-----------+------+-----------+------------+-----------+-----------------|
| armscii8_bin               | armscii8  |   64 |           | Yes        |         1 | PAD SPACE 


此语句显示所有可用的校对，以及它们适用的字符集。可以看
到有的字符集具有不止一种校对。例如，latin1对不同的欧洲
语言有几种校对，而且许多校对出现两次，一次区分大小写（由_cs表示），
一次不区分大小写（由_ci表示）。

mysql root@localhost:mysql_crash_course> show variables like '%cha%';
+-------------------------------+-----------------------------------------------------------------+
| Variable_name                 | Value                                                           |
|-------------------------------+-----------------------------------------------------------------|
| character_set_client          | utf8                                                            |
| character_set_connection      | utf8                                                            |
| character_set_database        | utf8                                                            |
| character_set_filesystem      | binary                                                          |
| character_set_results         | utf8                                                            |
| character_set_server          | utf8                                                            |
| character_set_system          | utf8                                                            |
| character_sets_dir            | D:\software\phpstudy_pro\Extensions\MySQL8.0.12\share\charsets\ |
| innodb_change_buffer_max_size | 25                                                              |
| innodb_change_buffering       | all                                                             |
| session_track_state_change    | OFF                                                             |
+-------------------------------+-----------------------------------------------------------------+
11 rows in set
Time: 0.006s
mysql root@localhost:mysql_crash_course> show variables like '%collation%';
+-------------------------------+--------------------+
| Variable_name                 | Value              |
|-------------------------------+--------------------|
| collation_connection          | utf8_general_ci    |
| collation_database            | utf8_unicode_ci    |
| collation_server              | utf8_unicode_ci    |
| default_collation_for_utf8mb4 | utf8mb4_0900_ai_ci |
+-------------------------------+--------------------+
4 rows in set
Time: 0.004s
```

## 27.3.小结

本章中，我们学习了字符集和校对的基础知识，还学习了如何对特
定的表和列定义字符集和校对，如何在需要时使用备用的校对。



# 28.安全管理

## 28.1.访问控制

MySQL服务器的安全基础是：用户应该对他们需要的数据具有适当
的访问权，既不能多也不能少。换句话说，用户不能对过多的数据具有
过多的访问权。

## 28.2.管理用户

```mysql
mysql root@localhost:mysql> select user, host from user;
+------------------+-----------+
| user             | host      |
|------------------+-----------|
| jieqiang         | %         |
| root             | %         |
| test             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
6 rows in set

mysql root@localhost:mysql> select user, host, authentication_string from user;
+------------------+-----------+------------------------------------------------------------------------+
| user             | host      | authentication_string                                                  |
|------------------+-----------+------------------------------------------------------------------------|
| dev              | %         | *27AEDA0D3A56422C3F1D20DAFF0C8109058134F3                              |
| jieqiang         | %         | *167B142DC779D5079A6A7B6190F15D97618322E8                              |
| root             | %         | *81F5E21E35407D884A6CD4A731AEBFB6AF209E1B                              |
| test             | %         | *94BDCEBE19083CE2A1F959FD02F964C7AF4CFC29                              |
| mysql.infoschema | localhost | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED |
| mysql.session    | localhost | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED |
| mysql.sys        | localhost | $A$005$THISISACOMBINATIONOFINVALIDSALTANDPASSWORDTHATMUSTNEVERBRBEUSED |
+------------------+-----------+------------------------------------------------------------------------+
7 rows in set

mysql root@localhost:mysql> rename user dev to dev2;
Query OK, 0 rows affected
Time: 0.097s
mysql root@localhost:mysql> rename user dev2 to dev;
Query OK, 0 rows affected


mysql root@localhost:mysql> select user, host from user;
+------------------+-----------+
| user             | host      |
|------------------+-----------|
| jieqiang         | %         |
| root             | %         |
| test             | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
6 rows in set


mysql root@localhost:mysql> grant select on mysql_crash_course.* to dev;
Query OK, 0 rows affected
Time: 0.085s
mysql root@localhost:mysql> show grants for dev;
+-----------------------------------------------------+

| Grants for dev@%                                    |
| --------------------------------------------------- |
| GRANT USAGE ON *.* TO `dev`@`%`                     |
| GRANT SELECT ON `mysql_crash_course`.* TO `dev`@`%` |

+-----------------------------------------------------+
2 rows in set


mysql root@localhost:mysql> grant select on mysql_crash_course.* to dev;
Query OK, 0 rows affected
Time: 0.085s
mysql root@localhost:mysql> show grants for dev;
+-----------------------------------------------------+

| Grants for dev@%                                    |
| --------------------------------------------------- |
| GRANT USAGE ON *.* TO `dev`@`%`                     |
| GRANT SELECT ON `mysql_crash_course`.* TO `dev`@`%` |

+-----------------------------------------------------+
2 rows in set

mysql root@localhost:mysql> select user, host from user;
+------------------+-----------+
| user             | host      |
|------------------+-----------|
| dev              | %         |
| jieqiang         | %         |
| root             | %         |
| test             | %         |
| zhangsan         | %         |
| mysql.infoschema | localhost |
| mysql.session    | localhost |
| mysql.sys        | localhost |
+------------------+-----------+
8 rows in set
Time: 0.001s
mysql root@localhost:mysql> create user admin identified by 'admin';
Query OK, 0 rows affected
Time: 0.031s
mysql root@localhost:mysql> grant all on *.* to admin WITH grant option;
Query OK, 0 rows affected
Time: 0.105s
mysql root@localhost:mysql> show grants for admin;
+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+

| Grants for admin@%                                           |
| ------------------------------------------------------------ |
| GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, RELOAD, SHUTDOWN, PROCESS, FILE, REFERENCES, INDEX, ALTER, SHOW DATABASES, SUPER, CREATE TEMPORARY TABLES, LOCK TABLES, EXECUTE, REPLICATION SLAVE, REPLICATION CLIENT, CREATE VIEW, SHOW VIEW, CREATE ROUTINE, ALTER ROUTINE, CREATE USER, EVENT, TRIGGER, CREATE TABLESPACE, CREATE ROLE, DROP ROLE ON *.* TO `admin`@`%` WITH GRANT OPTION |
| GRANT BACKUP_ADMIN,BINLOG_ADMIN,CONNECTION_ADMIN,ENCRYPTION_KEY_ADMIN,GROUP_REPLICATION_ADMIN,PERSIST_RO_VARIABLES_ADMIN,REPLICATION_SLAVE_ADMIN,RESOURCE_GROUP_ADMIN,RESOURCE_GROUP_USER,ROLE_ADMIN,SET_USER_ID,SYSTEM_VARIABLES_ADMIN,XA_RECOVER_ADMIN ON *.* TO `admin`@`%` WITH GRANT OPTION |

+---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------+
2 rows in set
Time: 0.002s
```

## 28.3.小结

本章学习了通过赋予用户特殊的权限进行访问控制和保护MySQL服
务器。



# 29.数据库维护

## 29.1.备份数据

像所有数据一样，MySQL的数据也必须经常备份。由于MySQL数据
库是基于磁盘的文件，普通的备份系统和例程就能备份MySQL的数据。
但是，由于这些文件总是处于打开和使用状态，普通的文件副本备份不
一定总是有效。

```mysql
λ mysqldump -uroot -p -B mysql_crash_course > /e/yqjie/today/mysql_scripts/mysql_crash_course_bak20201220.sql
Enter password: ****
/d/software/phpstudy_pro/Extensions/MySQL8.0.12/share/charsets
λ ll /e/yqjie/today/mysql_scripts/mysql_crash_course_bak20201220.sql
-rw-r--r-- 1 Administrator 197121 14474 12月 20 15:23 /e/yqjie/today/mysql_scripts/mysql_crash_course_bak20201220.sql
```

## 29.2.进行数据库维护

```
mysql root@localhost:mysql_crash_course> analyze table orders;
+---------------------------+---------+------------+------------+
| Table                     | Op      | Msg_type   | Msg_text   |
|---------------------------+---------+------------+------------|
| mysql_crash_course.orders | analyze | status     | OK         |
+---------------------------+---------+------------+------------+
1 row in set

mysql root@localhost:mysql_crash_course> check table orderitems;
+-------------------------------+-------+------------+------------+
| Table                         | Op    | Msg_type   | Msg_text   |
|-------------------------------+-------+------------+------------|
| mysql_crash_course.orderitems | check | status     | OK         |
+-------------------------------+-------+------------+------------+
1 row in set
```

## 29.3.诊断启动问题

服务器启动问题通常在对MySQL配置或服务器本身进行更改时出
现。MySQL在这个问题发生时报告错误，但由于多数MySQL服务器是作
为系统进程或服务自动启动的，这些消息可能看不到。
在排除系统启动问题时，首先应该尽量用手动启动服务器。MySQL
服务器自身通过在命令行上执行mysqld启动。下面是几个重要的mysqld
命令行选项：
 --help显示帮助——一个选项列表；
 --safe-mode装载减去某些最佳配置的服务器；
 --verbose显示全文本消息（为获得更详细的帮助消息与--help
联合使用）；  --version显示版本信息然后退出。
几个另外的命令行选项（与日志文件的使用有关）在下一节列出。

root@SKY-20191125ANA:/mnt/d/software/phpstudy_pro/Extensions/MySQL8.0.12/data# mysql --version
mysql  Ver 14.14 Distrib 5.6.14, for Linux (x86_64) using  EditLine wrapper

## 29.4.查看日志文件

MySQL维护管理员依赖的一系列日志文件。主要的日志文件有以下
几种。
 错误日志。它包含启动和关闭问题以及任意关键错误的细节。此
日志通常名为hostname.err，位于data目录中。此日志名可用
--log-error命令行选项更改。
 查询日志。它记录所有MySQL活动，在诊断问题时非常有用。此
日志文件可能会很快地变得非常大，因此不应该长期使用它。此
日志通常名为hostname.log，位于data目录中。此名字可以用
--log命令行选项更改。
 二进制日志。它记录更新过数据（或者可能更新过数据）的所有
语句。此日志通常名为hostname-bin，位于data目录内。此名字
可以用--log-bin命令行选项更改。注意，这个日志文件是MySQL
5中添加的，以前的MySQL版本中使用的是更新日志。
 缓慢查询日志。顾名思义，此日志记录执行缓慢的任何查询。这
个日志在确定数据库何处需要优化很有用。此日志通常名为
hostname-slow.log ，位于 data 目录中。此名字可以用
--log-slow-queries命令行选项更改。
在使用日志时，可用FLUSH LOGS语句来刷新和重新开始所有日志文
件。

## 29.5.小结

本章介绍了MySQL数据库的某些维护工具和技术。 



# 30.改善功能

## 30.1.改善功能

数据库管理员把他们生命中的相当一部份时间花在了调整、试验以
改善DBMS性能之上。在诊断应用的滞缓现象和性能问题时，性能不良的
数据库（以及数据库查询）通常是最常见的祸因。
可以看出，下面的内容并不能完全决定MySQL的性能。我们只是
想回顾一下前面各章的重点，提供进行性能优化探讨和分析的一个出
发点。
 首先，MySQL（与所有DBMS一样）具有特定的硬件建议。在学
习和研究MySQL时，使用任何旧的计算机作为服务器都可以。但
对用于生产的服务器来说，应该坚持遵循这些硬件建议。
 一般来说，关键的生产DBMS应该运行在自己的专用服务器上。
 MySQL是用一系列的默认设置预先配置的，从这些设置开始通常
是很好的。但过一段时间后你可能需要调整内存分配、缓冲区大
小等。（为查看当前设置，可使用SHOW VARIABLES;和SHOW
STATUS;。）
 MySQL一个多用户多线程的DBMS，换言之，它经常同时执行多
个任务。如果这些任务中的某一个执行缓慢，则所有请求都会执
行缓慢。如果你遇到显著的性能不良，可使用SHOW PROCESSLIST
显示所有活动进程（以及它们的线程ID和执行时间）。你还可以用KILL命令终结某个特定的进程（使用这个命令需要作为管理员登
录）。  总是有不止一种方法编写同一条SELECT语句。应该试验联结、并、
子查询等，找出最佳的方法。
 使用EXPLAIN语句让MySQL解释它将如何执行一条SELECT语句。
 一般来说，存储过程执行得比一条一条地执行其中的各条MySQL
语句快。
 应该总是使用正确的数据类型。
 决不要检索比需求还要多的数据。换言之，不要用SELECT *（除
非你真正需要每个列）。  有的操作（包括INSERT）支持一个可选的DELAYED关键字，如果
使用它，将把控制立即返回给调用程序，并且一旦有可能就实际
执行该操作。
 在导入数据时，应该关闭自动提交。你可能还想删除索引（包括
FULLTEXT索引），然后在导入完成后再重建它们。
 必须索引数据库表以改善数据检索的性能。确定索引什么不是一
件微不足道的任务，需要分析使用的SELECT语句以找出重复的
WHERE和ORDER BY子句。如果一个简单的WHERE子句返回结果所花
的时间太长，则可以断定其中使用的列（或几个列）就是需要索
引的对象。
 你的SELECT语句中有一系列复杂的OR条件吗？通过使用多条
SELECT语句和连接它们的UNION语句，你能看到极大的性能改
进。
 索引改善数据检索的性能，但损害数据插入、删除和更新的性能。
如果你有一些表，它们收集数据且不经常被搜索，则在有必要之
前不要索引它们。（索引可根据需要添加和删除。）  LIKE很慢。一般来说，最好是使用FULLTEXT而不是LIKE。  数据库是不断变化的实体。一组优化良好的表一会儿后可能就面
目全非了。由于表的使用和内容的更改，理想的优化和配置也会
改变。
 最重要的规则就是，每条规则在某些条件下都会被打破。

## 30.2.小结

本章回顾了与MySQL性能有关的某些提示和说明。当然，这只是一
小部分，不过，既然你已经完成了本书的学习，你应该能试验和掌握自
己觉得最适合的内容
