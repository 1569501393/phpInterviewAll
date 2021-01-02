#############################
# 本文使用mysql workbench 8.0.15

# 快捷键
# 执行当前语句 ctrl+enter
# 执行所有语句或所选语句 crtl+shift+enter
# 格式美化 ctr+b 

# 3种注释类型
#  1. 使用#注释
-- 2. 使用 -- 注释
 /*
 3. 使用 /和*组合 表示注释 
 */
#############################


#############################
# 第3章 使用MySQL
#############################
use crashcourse; #指定使用的数据库
show databases;  # 了解数据库，返回数据库列表
show tables;  # 返回数据库内表的列表
show columns from customers; # 查看customers表中的所有列设置
describe customers;  # 同上，查看customers表中的所有列设置

show status; # 用于显示广泛的服务器状态信息
show create database crashcourse; #查看创建数据库crashcourse的mysql代码语句
show create table productnotes;  #查看创建表productnotes表的mysql代码语句
show grants; #显示授予用户（所有用户或特定用户）的安全权限
# show errors; # 显示服务器错误内容
# show warnings； #显示服务器警告内容


#############################
# 第4章 检索数据
#############################
# select检索单列，多列，所有列
select prod_name from products;  # 从products表中检索prod_name 单列
select prod_id,prod_name,prod_price from products;   # 从products表中检索prod_name，prod_name,prod_price 多列
select * from products;   #  # 从products表中检索所有列，通常情况下，检索不需要的列会降低检索和应用程序的效率

# 使用distinct 去重
select distinct vend_id from products;  # 使用distinct关键字去重，distinc只能放在列名的前面
select distinct vend_id,prod_price from products;  # distinct不仅对前置它的列vend_id起作用，同时也作用于prod_price，两列值有重复，才去重

# 使用limit检索部分行，开始位置为行索引值，索引从0开始
select prod_name from products limit 5; #从第 0 行开始，返回前 5 行
select prod_name from products limit 5,5; #从第 5 行开始，检索 5 行
# 另一种写法
select prod_name from products limit 4 OFFSET 3; #从第 3 行开始，检索 4 行
select prod_name from products limit 3,4; #，同上，从第 3 行开始，检索 4 行

# 行数不够时，mysql只返回它能返回的那么多行
select count(prod_name) from products; # prod_name 共14行，索引为0-13
select prod_name from products limit 10,5; #从第 10 行开始，检索 5 行，行索引10-14，超出范围，只返回10-13共4行数据

# 使用完全限定的表名
select products.prod_name from products;
select products.prod_name from crashcourse.products;


#############################
# 第5章 排序检索数据
#############################

/* 关系型数据库设计理论认为，如果不明确规定排序顺序，
则不应该假定检索出的数据的顺序有意义 */

# order by 子句对输出排序
# 按单列排序 
select prod_name from products order by prod_name;   # 以字母顺序排序prod_name列 
select prod_name from products order by prod_id;  # 使用非检索的列排序数据也是合法的，如使用prod_id顺序排列prod_name
# 按多列排序 
select prod_id, prod_price,prod_name from products order by prod_price, prod_name; #先按价格，再按产品名排序
# 降序排列 desc，desc只作用于直接位于其前面的列名
select prod_id, prod_price,prod_name from products order by prod_price desc; # 按价格降序排列
select prod_id, prod_price,prod_name from products order by prod_price desc, prod_name; #先按价格降序排列，再按产品名升序排列 
select prod_id, prod_price,prod_name from products order by prod_price desc, prod_name desc; #先按价格降序排列，再按产品名降序排列

# 使用order by 和limit组合，找出一列中最高或最低的值
# 顺序：order by子句必须在from子句之后，limit子句必须在order by之后
select prod_price from products order by prod_price desc limit 1; # 最高值 
select prod_price from products order by prod_price limit 1; # 最低值 


#############################
# 第6章 过滤数据
#############################
select prod_name,prod_price from products where prod_price = 2.50;   # 价格等于2.50的产品名、产品价格
select prod_name,prod_price from products where prod_name = "fuses";  # 默认不区分大小写
select prod_name,prod_price from products where prod_price < 10; # 价格小于10的产品名、产品价格
select prod_name,prod_price from products where prod_price <=10; # 价格小于等于10的产品名、产品价格

# 不匹配检查
select vend_id,prod_name from products where vend_id <> 1003; # 检索不是由1003供应商制造的所有产品 
select vend_id,prod_name from products where vend_id != 1003; # 同上，检索不是由1003供应商制造的所有产品 

# 范围值检索，between A and B，包括A和B
select prod_name,prod_price from products where prod_price between 5 and 10; # 价格 大于等于5，小于等于10 的产品名、产品价格

# 空值检查
select prod_name from products where prod_price is null;  # 返回prod_price为空值null的prod_name,无对应数据 
select cust_id from customers where cust_email is null; # 检索cust_email为空值时的cust_id
/* 在通过过滤选择出不具有特定值的行时，你可能希望返回具有NULL值得行。
但是，不行。因为未知具有特殊的含义，数据库不知道他们是否匹配，所以在匹配过滤和不匹配过滤中不返回NULL。
因此，在过滤数据时，一定要验证返回数据中确实给出了被过滤列具有NULL的行。 
*/


#############################
# 第7章 数据过滤
#############################

# and 或 or 操作符连接多个where子句 
# AND 用在WHERE子句中的关键字，用来指示检索满足所有给定条件的行
select vend_id,prod_price,prod_name from products
where vend_id = 1003 and prod_price <= 10; #检索由供应商1003制造且价格小于等于10美元的产品信息
# OR操作符，指示MySQL检索匹配任一条件的行
select prod_name,prod_price from products 
where vend_id = 1002 or vend_id = 1003; # 检索由任一个指定供应商制造的所有产品的产品信息

# and 和 or结合，and优先计算
# 优先计算and，查找vend_id为1003且价格>=10的产品，或者vend_id为1002的产品，不管价格如何  
select prod_name,prod_price from products 
where vend_id = 1002 or vend_id = 1003 and prod_price >= 10;
# 使用圆括号明确运算顺序：查找vend_id为1002或1003，且价格>=10的产品
select prod_name,prod_price from products 
where (vend_id = 1002 or vend_id = 1003) and prod_price >= 10; 

# IN操作符
# IN操作符后跟由逗号分隔的合法值清单，整个清单必须括在圆括号
select prod_name,prod_price from products
where vend_id in (1002,1003) order by prod_name;
# IN操作符完成与OR相同的功能
select prod_name,prod_price from products
where vend_id = 1002 or vend_id = 1003 order by prod_name; # 同上 

# NOT操作符
# 列出1002和1003之外的供应商生产的产品
select prod_name,prod_price from products
where vend_id not in (1002,1003) order by prod_name;
# Mysql支持not对in，between，exsits子句取反 


#############################
# 第8章 用通配符进行过滤 
#############################
/*
通配符：用来匹配值得一部分的特殊字符 
搜索模式：由字面值、通配符或两者组合构成的搜索条件 
Like操作符：为在搜索子句中使用通配符，必须使用like操作符。
指示mysql，其后跟的搜索模式利用通配符匹配而不是直接相等匹配进行比较。 
*/

-- 通配符类型 
# 百分号 % 通配符 ：表示任何字符（包括0个字符 ）出现任意次数 
# 特殊：注意 % 不能匹配NULL空值！ 
# 找到所有以词jet起头的产品 
select prod_id,prod_name from products where prod_name like "jet%";
# 通配符可以在搜索模式任意位置使用
# 比如下方出现在头尾两处 ，匹配任意位置包含文本anvil的值 
select prod_id,prod_name from products where prod_name like "%anvil%"; 
# 比如下方出现在搜索模式的中间，匹配所有以s开头e结尾的值 
select prod_name from products where prod_name like "s%e"; 

# 下划线 _ 通配符 ：匹配一个字符，不能多不能少 
select prod_id,prod_name from products
where prod_name like "_ ton anvil";

# 技巧：把通配符至于搜索模式的开始处，搜索起来是最慢的！ 


#############################
# 第9章 用正则表达式进行搜索 
#############################

-- 基本字符匹配 
# 查找产品名中含有'1000'的所有行 
select prod_name from products where prod_name regexp "1000";
# .在正则表达式中，匹配任意 一个 字符 
select prod_name from products where prod_name regexp ".000";

-- like 和 正则表达式的区别 ，是否在列值中匹配 
# like在整个列中查找，如果被匹配的文本出现在列值中，匹配不到结果，除非使用通配符 
select prod_name from products where prod_name like "1000" order by prod_name;     #无返回结果 
# like + 通配符
select prod_name from products where prod_name like "%1000" order by prod_name;    # 返回结果'JetPack 1000'
select prod_name from products where prod_name like "%000" order by prod_name;     # 返回结果 'JetPack 1000' 'JetPack 2000'
# Regexp在列值中匹配
select prod_name from products where prod_name regexp ".000" order by prod_name;   # 返回结果 'JetPack 1000' 'JetPack 2000'

# regexp如何匹配整个列，同like效果呢，使用^和$定位符即可 


-- 正则表达式匹配默认不分大小写，需使用BINARY区分大小写  
select prod_name from products where prod_name regexp binary "JetPack .000";

-- 正则表达式的OR操作符： |
select prod_name from products where prod_name regexp "1000|2000" order by prod_name;

-- 正则表达式匹配几个字符之一 [ ]
select prod_name from products where prod_name regexp '[123] Ton' order by prod_name;  # [123]匹配单一字符：1或2或3
select prod_name from products where prod_name regexp '[1|2|3] Ton' order by prod_name;  # [1|2|3]同[123]，匹配单一字符：1或2或3
select prod_name from products where prod_name regexp '1|2|3 ton' order by prod_name; # '1|2|3 ton'匹配1或2或'3 ton'
select prod_name from products where prod_name regexp '[^123]' order by prod_name;  # 取反

-- 正则表达式匹配范围 
select prod_name from products where prod_name regexp '[1-5] Ton' order by prod_name;  # [1-5]匹配1,2,3,4,5

-- 正则表达式匹配特殊字符，必须用\\前导，进行转义 
-- 多数正则使用单反斜杠转义，但mysql使用双反斜杠，mysql自己解释一个，正则表达式库解释一个 
select vend_name from vendors where vend_name regexp "\\." order by vend_name; # ‘\\.'匹配字符.
select vend_name from vendors where vend_name regexp "." order by vend_name;  #  '.'匹配任意字符，每行都会被检索出来

-- 正则表达式匹配字符类 
#	[:alnum:]	任意字母和数字（同[a-zA-Z0-9]） 
#	[:alpha:]	任意字符（同[a-zA-Z]） 
#	[:blank:]	空格和制表（同[\\t]） 
#	[:cntrl:]	ASCII控制字符（ASCII 0到31和127） 
#	[:digit:]	任意数字（同[0-9]） 
#	[:graph:]	与[:print:]相同，但不包括空格 
#	[:lower:]	任意小写字母（同[a-z]） 
#	[:print:]	任意可打印字符 
#	[:punct:]	既不在[:alnum:]又不在[:cntrl:]中的任意字符 
#	[:space:]	包括空格在内的任意空白字符（同[\\f\\n\\r\\t\\v]） 
#	[:upper:]	任意大写字母（同[A-Z]） 
#	[:xdigit:]	任意十六进制数字（同[a-fA-F0-9]） 
select prod_name from products where prod_name regexp '[:digit:]' order by prod_name; #[:digit:]匹配任意数字 

-- 匹配多个实例 
#	*		0个或多个匹配 
#	+		1个或多个匹配（等于{1,}）
#	?		0个或1个匹配（等于{0,1}）
# 	{n}		指定数目的匹配 
# 	{n,}	不少于指定数目的匹配
#	{n,m}	匹配数目的范围（m不超过255）
select prod_name from products where prod_name regexp '\\([0-9] sticks?\\)'
order by prod_name;  # 返回了'TNT (1 stick)'和'TNT (5 sticks)'
select prod_name from products where prod_name regexp '[[:digit:]]{4}'
order by prod_name;  # [[:digit:]]{4}匹配连在一起的任意4位数字

-- 定位符
#	^			文本的开始 
#	$			文本的结尾 
#	[[:<:]]		词的开始 
#	[[:>:]]		词的结尾
select prod_name from products where prod_name regexp '^[0-9\\.]' order by prod_name; #找出以一个数（包括以小数点开始的数）开始的所有产品
select prod_name from products where prod_name regexp '[0-9\\.]' order by prod_name;  #找出包括小数点和数字的所有产品


-- ^的双重作用 
# 在集合中（用[和]定义），用它来否定该集合
# 用来指串的开始处

-- 不适用数据库表进行正则表达式的测试：匹配返回1，无匹配返回0
select 'hello' regexp '[0-9]'; # 返回 0 
select 'hello' regexp '[:alnum:]'; # 返回 1


#############################
# 第10章 创建计算字段 
#############################

-- 拼接字段 concat()
select concat(vend_name,' (',vend_country,')') from vendors order by vend_name;  

-- 删除数据左侧多余空格 ltrim()
-- 删除数据两侧多余空格 trim()
-- 删除数据右侧多余空格 rtrim()
select concat(rtrim(vend_name),' (',rtrim(vend_country),')') from vendors order by vend_name;

-- as赋予别名
select concat(rtrim(vend_name),' (',rtrim(vend_country),')') as vend_title from vendors order by vend_name;

-- 执行算数计算
select prod_id,quantity,item_price from orderitems where order_num = 20005;

select prod_id,quantity,item_price,quantity * item_price as expanded_price
from orderitems where order_num = 20005;  # 计算总价expanded_price

-- 简单测试计算 
select 2*3;
select trim('abc');
select now();  # 返回当前日期和时间


#############################
# 第11章 利用数据处理函数  
#############################

-- 文本处理函数 
#	left()			返回串左边的字符 
#	length()		返回串的长度 
#	locate()		找出串的一个子串 
#	lower()			将串转换为小写
#	ltrim()			去掉串左边的空格
#	right()			返回串右边的字符 
#	rtrim()			去掉串右边的空格  
#	soundex()		返回串的soundex值
#	substring()		返回子串的字符 
#	upper()			将串转换为大写

-- UPPER()函数 转换文本为大写 
select vend_name, upper(vend_name) as vend_name_upcase from vendors order by vend_name;

# soundex() 描述语音表示的字母数字模式的算法,对串按照发音比较而不是字母比较
select cust_name,cust_contact from customers where cust_contact = 'Y. Lie';  # 无返回 
select cust_name,cust_contact from customers where soundex(cust_contact) = soundex('Y. Lie'); # 按发音搜索 

-- 日期和时间处理函数 
#	adddate()		增加一个日期（天，周等）
#	addtime()		增加一个时间（时、分等）
#	curdate()		返回当前日期 
#	curtime()		返回当前时间 
#	date()			返回日期时间的日期部分 	
#	datediff()		计算两个日期之差 
#	date_add()		高度灵活的日期运算函数 
#	date_format()	返回一个格式化的日期或时间串 
#	day()			返回一个日期的天数部分 	
#	dayofweek()		对于一个日期，返回对应的星期几 
#	hour()			返回一个时间的小时部分 
#	minute()		返回一个时间的分钟部分 
#	month()			返回一个日期的月份部分 
#	now()			返回当前日期和事件 
#	second()		返回一个时间的秒部分 
#	time()	 		返回一个日期时间的时间部分 
#	year()			返回一个日期的年份部分 

# 首选的日期格式yyyy-mm-dd，避免多义性 
select cust_id,order_num from orders where order_date = "2005-09-01";
select * from orders; # order_date为datetime数据类型，含有时间信息；如果时间信息不是00:00:00,上句查找无结果
# 按照date()日期进行过滤信息，更可靠 
select cust_id,order_num from orders where date(order_date) = "2005-09-01";

# 检索2005年9月下的订单 
select cust_id,order_num from orders where year(order_date) = 2005 and month(order_date) = 9;
select cust_id,order_num from orders where date(order_date) between "2005-09-01" and "2005-09-30";

-- 数值处理函数 
#	abs()			返回一个数的绝对值
#	cos()			返回一个角度的余弦
#	exp()			返回一个数的指数值
#	mod()			返回除操作的余数
#	pi()			返回圆周率	
#	sin()			返回一个角度的正弦 
#	sqrt()			返回一个数的平方根 
#	tan()			返回一个角度的正切 
 
 
#############################
# 第12章 汇总数据   
#############################

-- 聚类函数 
# avg()			返回某列的平均值 
# count()		返回某列的行数 
# max()			返回某列的最大值 
# min()			返回某列的最小值 
# sum()			返回某列值之和 

-- avg()
# AVG()返回products表中所有产品的平均价格
select avg(prod_price) as avg_price from products;
# 返回特定供应商所提供产品的平均价格
select avg(prod_price) as avg_price from products where vend_id = 1003;
# avg()只能作用于单列，多列使用多个avg()
select avg(item_price) as avg_itemprice,avg(quantity) as avg_quantity from orderitems;

-- count()
# COUNT(*)对表中行的数目进行计数，不忽略空值 
select count(*) as num_cust from customers; 
# 使用COUNT(column)对特定列中具有值的行进行计数，忽略NULL值
select count(cust_email) as num_cust from customers;  

-- max() & min()
# MAX()返回products表中最贵的物品的价格
select max(prod_price) as max_price from products;
# 在用于文本数据时，如果数据按相应的列排序，则MAX()返回最后一行
select max(prod_name) from products; 
# MIN()返回products表中最便宜物品的价格
select min(prod_price) as min_price from products;
# 在用于文本数据时，如果数据按相应的列排序，则MIN()返回最前面一行
select min(prod_name) from products; 

-- sum()
# 检索所订购物品的总数（所有quantity值之和）
select sum(quantity) as items_ordered from orderitems;
select sum(quantity) as items_ordered from orderitems where order_num = 20005;
# 订单20005的总订单金额
select sum(quantity * item_price) as total_price from orderitems where order_num = 20005;

-- 聚类不同值 distinct
# 使用了DISTINCT参数，因此平均值只考虑各个不同的价格
select avg(distinct prod_price) as avg_price from products where vend_id = 1003;
# distinct 只能作用于count(),不能用于count(*)
# distinct 同max(),min()的结合使用，没有意义 

-- 组合聚类函数 
# 4个聚集计算:物品的数目，产品价格的最高、最低以及平均值 
SELECT 
    COUNT(*) AS num_items,
    MIN(prod_price) AS price_min,
    MAX(prod_price) AS price_max,
    AVG(prod_price) AS price_avg
FROM
    products;


#############################
# 第13章 分组计算    
#############################

-- group by 分组 
# 按vend_id排序并分组数据
select vend_id, count(*) as num_prods from products group by vend_id;
# 使用WITH ROLLUP关键字，可以得到每个分组的汇总值，下述语句得到所有分组count(*)的和14 
select vend_id, count(*) as num_prods from products group by vend_id with rollup;

-- having子句 过滤分组 
# where过滤行，having过滤分组 
# WHERE在数据分组前进行过滤，HAVING在数据分组后进行过滤
# COUNT(*) >=2（两个以上的订单）的那些分组
select cust_id, count(*) as orders from orders group by cust_id having count(*)>=2;

-- where和having组合使用 
#列出具有2个（含）以上、价格为10（含）以上的产品的供应商
select vend_id,count(*) as num_prods from products where prod_price >=10 group by vend_id having count(*)>=2;
#不加where条件，结果不同 
select vend_id,count(*) as num_prods from products group by vend_id having count(*) >=2;

-- 分组和排序 
# 检索总计订单价格大于等于50的订单的订单号和总计订单价格
select order_num,sum(quantity * item_price) as ordertotal from orderitems group by order_num having sum(quantity * item_price) >=50;
# 按总计订单价格排序输出
SELECT 
    order_num, SUM(quantity * item_price) AS ordertotal
FROM
    orderitems
GROUP BY order_num
HAVING SUM(quantity * item_price) >= 50
ORDER BY ordertotal;


-- select子句总结及顺序 
# 子句			说明						是否必须使用 
# select		要返回的列或表达式			是 
# from			从中检索数据的表			仅在从表选择数据时使用 
# where			行级过滤					否 
# group by		分组说明					仅在按组计算聚集时使用 
# having		组级过滤  					否 
# order by		输出排序顺序 				否
# limit			要检索的行数 				否 


#############################
# 第14章 使用子查询     
#############################

-- 利用子查询进行过滤
# 列出订购物品TNT2的所有客户
SELECT cust_name, cust_contact
FROM customers
WHERE cust_id IN (SELECT cust_id
				  FROM orders
				  WHERE order_num IN (SELECT order_num
									  FROM orderitems
							          WHERE prod_id = 'TNT2'));
                                      
                                      
-- 作为计算字段使用子查询
# 对客户10001的订单进行计数
select count(order_num) from orders where cust_id = 10001;
# 显示customers 表中每个客户的订单总数
select cust_name,cust_state, (select count(*) from orders where orders.cust_id = customers.cust_id) as orders
from customers order by cust_name;


#############################
# 第15章 联结表      
#############################

-- 创建联结 
# where子句联结 
select vend_name,prod_name,prod_price 
from vendors,products
where vendors.vend_id = products.vend_id
order by vend_name,prod_name;

-- 笛卡尔积 / 叉联结 
/*由没有联结条件的表关系返回的结果为笛卡尔积。
检索出的行的数目将是第一个表中的行数乘以第二个表的行数。*/

# 删除where联结条件 
# 返回的数据用每个供应商匹配了每个产品，它包括了供应商不正确的产品
select vend_name,prod_name,prod_price 
from vendors,products
order by vend_name,prod_name;

-- 内部联结 inner join ： 表间相等测试 
select vend_name,prod_name,prod_price 
from vendors inner join products
on vendors.vend_id = products.vend_id;

# 编号为20005的订单中的物品及对应情况 
select prod_name,vend_name,prod_price,quantity
from orderitems,products,vendors
where products.vend_id = vendors.vend_id
and orderitems.prod_id = products.prod_id
and order_num = 20005;

# 订购产品TNT2的客户列表
select cust_name,cust_contact
from customers,orders,orderitems
where customers.cust_id = orders.cust_id
and orders.order_num =  orderitems.order_num
and prod_id = 'TNT2';


#############################
# 第16章 创建高级联结      
#############################

-- 使用表别名
# 给列名或计算字段起别名 
 select concat(rtrim(vend_name),' (',rtrim(vend_country),')') as vend_title
 from vendors order by vend_name;
 # 给表起别名 
 select cust_name,cust_contact 
 from customers as c,orders as o,orderitems as oi
 where c.cust_id = o.cust_id
 and oi.order_num = o.order_num
 and prod_id = 'TNT2';
 
-- 自联结 
# ID为DTNTR该物品的供应商生产的其他物品
#方法：子查询 
select prod_id,prod_name from products
where vend_id = (select vend_id from products where prod_id = 'DTNTR');
 #方法：使用联结 
select p1.prod_id,p1.prod_name
from products as p1, products as p2
where p1.vend_id = p2.vend_id
and p2.prod_id = 'DTNTR';

-- 自然联结
# 自然联结使每个列只返回一次
# 方法：通过对表使用通配符*，对所有其他表的列使用明确的子集 
select c.*,o.order_num,o.order_date,oi.prod_id,oi.quantity,oi.item_price
from customers as c,orders as o,orderitems as oi
where c.cust_id = o.cust_id
and oi.order_num = o.order_num
and prod_id = 'FB';
 
-- 外部联结 
# 检索所有客户及其订单
# 方法： 内部联结 
select customers.cust_id,orders.order_num
from customers inner join orders
on customers.cust_id = orders.cust_id;
 
# 检索所有客户及其订单,包括那些没有订单的客户
# 01 ： 左外部联结
select customers.cust_id,orders.order_num
from customers left outer join orders
on customers.cust_id = orders.cust_id;

# 02 ：若使用 右外部联结 结果不同 
select customers.cust_id,orders.order_num
from customers right outer join orders
on customers.cust_id = orders.cust_id;

# 03： 若使用 右外部联结 调换两表位置 结果同01代码相同 
select customers.cust_id,orders.order_num
from orders right outer join customers
on customers.cust_id = orders.cust_id;
 
-- 使用带聚集函数的联结 
 # 检索所有客户分别对应的订单数，inner join 
select customers.cust_name,
	   customers.cust_id,
       count(orders.order_num) as num_ord
from customers inner join orders 
on customers.cust_id = orders.cust_id
group by customers.cust_id; 
 
  # 检索所有客户分别对应的订单数，包括没有订单的客户，left outer join 
 select customers.cust_name,
	   customers.cust_id,
       count(orders.order_num) as num_ord
from customers left outer join orders 
on customers.cust_id = orders.cust_id
group by customers.cust_id; 


#############################
# 第17章 组合查询      
#############################

-- 使用union 
# 价格小于等于5的所有物品
select vend_id,prod_id,prod_price from products where prod_price <=5;
# 供应商1001和1002生产的所有物品
select vend_id,prod_id,prod_price from products where vend_id in (1001,1002);
# 价格小于等于5的所有物品的列表，而且包括供应商1001和1002生产的所有物品（不考虑价格）
# 方法1 使用union 
select vend_id,prod_id,prod_price from products where prod_price <=5
union
select vend_id,prod_id,prod_price from products where vend_id in (1001,1002);
# 方法2 使用where 
select vend_id,prod_id,prod_price from products 
where prod_price <=5 or vend_id in (1001,1002);

# union默认自动去除重复的行 
# union all，匹配所有行 ，不取消重复行 
select vend_id,prod_id,prod_price from products where prod_price <=5
union all
select vend_id,prod_id,prod_price from products where vend_id in (1001,1002);  # 有一行出现2次 

# 对union组合结果进行排序
# union组合完只能使用一条order by语句，放在最后一个select语句后面 
select vend_id,prod_id,prod_price from products where prod_price <=5
union
select vend_id,prod_id,prod_price from products where vend_id in (1001,1002)
order by vend_id,prod_price;
