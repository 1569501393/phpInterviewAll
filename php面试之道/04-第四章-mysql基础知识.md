# 第四章 MYSQL基础知识考察点

- - [字段类型](https://www.kancloud.cn/idcpj/php_interview/610389#_2)

  - - [整数类型](https://www.kancloud.cn/idcpj/php_interview/610389#_3)
    - [实数类型](https://www.kancloud.cn/idcpj/php_interview/610389#_15)
    - [字符串类型](https://www.kancloud.cn/idcpj/php_interview/610389#_20)
    - [枚举](https://www.kancloud.cn/idcpj/php_interview/610389#_31)
    - [日期和时间类型](https://www.kancloud.cn/idcpj/php_interview/610389#_38)

  - [数据表引擎](https://www.kancloud.cn/idcpj/php_interview/610389#_48)

  - - [Innodb表引擎](https://www.kancloud.cn/idcpj/php_interview/610389#Innodb_49)
    - [MYISAM表引擎](https://www.kancloud.cn/idcpj/php_interview/610389#MYISAM_61)
    - [其他表引擎](https://www.kancloud.cn/idcpj/php_interview/610389#_68)

  - [锁机制](https://www.kancloud.cn/idcpj/php_interview/610389#_71)

  - - [共享锁(读锁)和排他锁(写锁)](https://www.kancloud.cn/idcpj/php_interview/610389#_73)

    - - [读锁](https://www.kancloud.cn/idcpj/php_interview/610389#_75)
      - [写锁](https://www.kancloud.cn/idcpj/php_interview/610389#_78)

    - [锁粒度](https://www.kancloud.cn/idcpj/php_interview/610389#_81)

  - [事务处理](https://www.kancloud.cn/idcpj/php_interview/610389#_85)

  - [存储过程](https://www.kancloud.cn/idcpj/php_interview/610389#_91)

  - [触发器](https://www.kancloud.cn/idcpj/php_interview/610389#_96)

  - - [使用场景](https://www.kancloud.cn/idcpj/php_interview/610389#_100)

  - [索引的基础和类型](https://www.kancloud.cn/idcpj/php_interview/610389#_108)

  - - [索引对性能的影响](https://www.kancloud.cn/idcpj/php_interview/610389#_109)
    - [索引的使用场景](https://www.kancloud.cn/idcpj/php_interview/610389#_115)
    - [索引的类型](https://www.kancloud.cn/idcpj/php_interview/610389#_119)
    - [创建索引的原则](https://www.kancloud.cn/idcpj/php_interview/610389#_128)
    - [索引的注意事项](https://www.kancloud.cn/idcpj/php_interview/610389#_137)

  - [六种关联查询](https://www.kancloud.cn/idcpj/php_interview/610389#_162)

  - - [交叉连接 CROSS JOIN](https://www.kancloud.cn/idcpj/php_interview/610389#_CROSS_JOIN_163)

    - [内连接 INNER JOIN](https://www.kancloud.cn/idcpj/php_interview/610389#_INNER_JOIN_169)

    - - [内连接分为三类](https://www.kancloud.cn/idcpj/php_interview/610389#_174)

    - [外连接 LEFT JOIN/ RIGHT JOIN](https://www.kancloud.cn/idcpj/php_interview/610389#_LEFT_JOIN_RIGHT_JOIN_179)

    - - [左外连接](https://www.kancloud.cn/idcpj/php_interview/610389#_180)
      - [右外连接](https://www.kancloud.cn/idcpj/php_interview/610389#_182)

    - [联合查询 UNION与 UNION ALL](https://www.kancloud.cn/idcpj/php_interview/610389#_UNION_UNION_ALL_185)

    - [嵌套语句](https://www.kancloud.cn/idcpj/php_interview/610389#_191)

  - [真题](https://www.kancloud.cn/idcpj/php_interview/610389#_195)

## 字段类型

### 整数类型

`TINYINT、 SMALLINT、 MEDIUMINT、INT、 BIGINT`
属性: `UNSIGNED`
长度:可以为整数类型指定宽度,例如:INT(11)、对大多数应用
是没有意义的,它不会限制值的合法范围,只会影响显示字符的个
数

> int(3) 可以存入值为1234567 ,且不会切断,
> 设置长度是为了 如果设置了 `Zerofill` 存入123 会变为 0123,
> 所以 int(0) 也是具有意义的

### 实数类型

`FLOAT、 DOUBLE、 DECIMAL`
DECIMAL可存储比 BIGINT还大的整数;可以用于存储精确的小数,相当于存为字符串
FLOAT和 DOUBLE类型支持使用标准的浮点进行近似计算

### 字符串类型

`VARCHAR、CHAR、TEXT、BLOB`
VARCHAR类型用于存储可变长字符串,它比定长类型更节省空间
VARCHAR使用1或2个额外字节记录字符串的长度,列长度小于
255字节,使用1个字节表示,否则用2个

> `char` 定长 ,如 `char(10)` 不管你存入多长, 都占用10 个字节,用于存储定长的字符串
> `varchar` 与 `char` 会切断长度长度的字符串 ,超过255字节的只能用`varchar`或者`text`；
> 如果存储值很短或定长,可以选择`char`
> 能用`varchar`的地方不用`text`；

### 枚举

`create table user_sex( sex enum('M','F'));`
有时可以使用枚举代替常用的字符串类型
把不重复的集合存储成一个预定义的集合
非常紧凑,把列表值压缩到一个或两个字节
部存储的是整数

### 日期和时间类型

尽量使用 `TIMESTAMP`,比 `DATETIME`空间效率高
用整数保存时间戳的格式通常不方便处理
如果需要存储微秒,可以使用 bigint存储

```
date 	1000-01-01 ~ 9999-12-31
datetime    1000-01-01 00:00:00 ~ 9999-12-31 23:59:59
timestamp    1970-01-01 00:00:01  ~ 2038-01-19 03:14:07
```

## 数据表引擎

### Innodb表引擎

默认事务型引擎,最重要最广泛的存儲引擎,性能非常优秀
数据存储在共享表空间,可以通过配置分开
对主键查询的性能高于其他类型的存储引擎
内部做了很多优化,从磁盘读取数据时自动在内存构建hash索引
插入数据时自动构建插入缓冲区
通过一些机制和工具支持真正的热备份
支持崩溃后的安全恢复
支持行级锁
支持外键

### MYISAM表引擎

51版本前, MYISAM是默认的存储引擎
拥有全文索引l、压缩、空间函数
表锁,不支持事务和行级锁,不支持崩溃后的安全恢复
表存储在两个文件,MYD和MYI
设计简单,某些场景下性能很好

### 其他表引擎

Archive、 Blackhole、csV、 Memory

## 锁机制

表锁是日常开发当中常见的问题,当多个查询同一时刻进行数据修改时,就会产生并发控制的问题

### 共享锁(读锁)和排他锁(写锁)

#### 读锁

共享的,不堵塞,多个用户可以同时读一个资源,互不干扰

#### 写锁

排他的,一个写锁会阻塞其他的写锁和读锁,这样可以只允许一人进行写入,防止其他用户读取正在写入的资源。

### 锁粒度

- 表锁,系统性能开销最小,会锁定整张表, MYISAM使用表锁
- 行锁,最大程度地支持并发处理,但是也带来了最大的锁开销,Innodb实现行级锁

## 事务处理

MYSQL提供事务处理的表引|擎, Inno DB
服务器层不管理事务,由下层的引擎实现,所以同一个事务中,使
用多种存储引擎不靠谱
在非事务的表上执行事务操作 MYSQL不会发出提醒,也不会报错

## 存储过程

为以后的使用而保存的一条或多条 MYSQL语句的集合
存储过程就是有业务逻辑和流程的集合
可以在存储过程中创建表,更新数据,删除等等

## 触发器

提供给程序员和数据分析员来保证数据完整性的一种方法,它是与
表事件相关的特殊的存储过程

### 使用场景

可通过数据库中的相关表实现级联更改
实时监控某张表中的某个字段的更改而需要做出相应的处理
某些业务编号的生成等
滥用会造成数据库及应用程序的维护困难

> [MySQL 视图、函数、存储过程和触发器 简书 详解](https://www.jianshu.com/p/814d8aee700a)

## 索引的基础和类型

### 索引对性能的影响

大大减少服务器需要扫描的数据量
帮助服务器避免排序和临时表
将随机I/O变顺序I/O
大大提高查询速度,降低写的速度、占用磁盘

### 索引的使用场景

对于非常小的表,大部分情况下全表扫描效率更高
特大型的表,建立和使用索引的代价将随之增长,可以使用分区技术来解决

### 索引的类型

索引|有很多种类型,都是实现在存储引擎层的

- 普通索引:最基本的索引,没有任何约束限制
- 唯一索引:与普通索引类似,但是具有唯一性约束
- 主键索引:主键可以与外键构成参照完整性约束,防止数据不一致
- 组合索引:将多个列组合在一起创建索引,可以覆盖多个列
- 外键索引:只有 Innodb类型的表才可以使用外键索引,保证数据的一致性、完整性和实现级联操作
- 全文索引: MYSQL自带的全文索引只能用于 MYISAM,并且只能对英文进行全文检索

### 创建索引的原则

1. 最适合索引的列是出现在 WHERE子句中的列,或连接子句中的列而不是出现在 SELECT关键字后的列
2. 索引列的基数越大,索引的效果越好
3. 对字符串进行索引,应该制定一个前缀长度,可以节省大量的索引空间
4. 根据情况创建复合索引,复合索引可以提高查询效率
5. 避免创建过多索引,索引|会额外占用磁盘空间,降低写操作效率
6. 主键尽可能选择较短的数据类型,可以有效减少索引的磁盘占用提高查询效率

### 索引的注意事项

1. 复合索引遵循前缀原则

```
创建的索引有顺序,非顺序的索引不生效
KEY(a, b, c)  //创建 a b c 索引
WHERE a=l and b=2 and c= 3 //生效
WHERE a=1 and b=2	//生效
WHERE a= 1 	//生效

WHERE b=2 andc= 3  	//无效
WHERE a= 1 and c=3		//无效
```

1. like查询,%在前,则素以失效,可以使用全文索引
2. column is null可以使用索引
   `where name=null //也是可以使用索引`
3. 如果 MYSQL估计使用索引比全表扫描更慢,会放弃使用索引
   `如果只有100 条数据 where id 1>and id<100 会自动转为全表索引`
4. 如果or前的条件中的列有索引,后面的没有,索引都不会被用到
   `where name='cpj' or age='12'`
5. 列类型是字符串,查询时一定要给值加引|号,否则索引失效

```
name varchar(16)
存了 "100"
Where name =100  //虽然能得到值 但是没有使用索引
```

## 六种关联查询

### 交叉连接 CROSS JOIN

```
SELECT* FROM A,B(C)或者
SELECT* FROM A CROSS JOIN B(CROSS JOIN C
//没有任何关联条件,结果是笛卡尔积,结果集会很大,没有意义,很少使用
```

### 内连接 INNER JOIN

```
SELECT* FROM A, B WHERE A id=Bd或者
SELECT FROM A INNER JOIN B ON A.id=Bid
```

#### 内连接分为三类

- 等值连接: ON Aid=Bid
- 不等值连接: ON A id>B.d
- 自连接: `SELECT* FROM A T1 INNER JOIN A T2 on T1.id=T2. pid`
- 

### 外连接 LEFT JOIN/ RIGHT JOIN

#### 左外连接

LEFT OUTER JOIN,以左表为主,先查询出左表,按照ON后的关联条件匹配右表,没有匹配到的用NULL填充,可以简写成 LEFT JOIN

#### 右外连接

RIGHT OUTER JOIN,以右表为主,先查询出右表,按照ON后的关联条件匹配左表,没有匹配到的用NULL填充,可以简写成 RIGHT JOIN

### 联合查询 UNION与 UNION ALL

`SELECT* FROM A UNION SELECT* FROM B UNION··`
就是把多个结果集集中在一起, UNION前的结果为基准,需要注
意的是联合查询的列数要相等,相同的记录行会合并
UNION ALL不会合并重复的结果集

### 嵌套语句

用一条SQL语句的结果作为另外一条SQL语句的条件
`SELECT FROM A WHERE id IN(SELECT id FROM B)`

## 真题

1. 更新 b 表 的 c1 c2 到 A 表的 c1 c2

```
A(id, sex, par, cl, c2)
B(id, age, cl, c2)
//方法一
update a, b set A.cl= B.cl, A.c2=B.c2
where A.id = B.id and B.age >50
//方法二
update a inner join B on Aid B id
set A.c1=B.c1,A.c2= B.c2
where Bage >50
```

上一篇：[第三章 Linux基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610388)下一篇：[mysql查询优化](https://www.kancloud.cn/idcpj/php_interview/610427)