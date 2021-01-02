#############################
# 第18章 全文本搜索       
#############################

-- 进行全文本搜索 
# Match() 指定被搜索的列，against()指定要使用的搜索表达式 
select note_text from productnotes where match(note_text) against('rabbit');

# 如果用like语句 
select note_text from productnotes where note_text like '%rabbit%';

# 演示排序如何工作 
/*  注意：RANK (R)在mysql 8.0.2 (reserved)版本中为keyword保留字
当字段名与MySQL保留字冲突时,可以用字符‘’将字段名括起来
或者改为其他名字，比如as rank1等
*/
select note_text, match(note_text) against('rabbit') as 'rank' from productnotes; 

-- 使用查询扩展 
 # 进行一个简单的全文本搜索，没有查询扩展
 select note_text from productnotes where match(note_text) against('anvils');
 # 相同的搜索，这次使用查询扩展
 select note_text from productnotes where match(note_text) against('anvils' with query expansion);

-- 布尔文本搜索
-- 全文本布尔操作符 
#	布尔操作符			说明
#	+				包含，词必须存在 
#	-				排除，词必须不出现
#	>				包含，而且增加等级值 
#	<				包含，且减少等级值 
#	()				把词组成子表达式（允许这些表达式作为一个组被包含、排除、排列等）
#	~				取消一个词的排序值
# 	*				词尾的通配符
#	“ ”				定义一个短语（与单个词的列表不一样，它匹配整个短语一边包含或排除这个短语）

# 全文本搜索检索包含词heavy的所有行
# 关键字IN BOOLEAN MODE，实际上没有指定布尔操作符，其结果与没有指定布尔方式的结果相同
select note_text from productnotes where match(note_text) against('heavy' in boolean mode);
# -rope* 排除包含rope*（任何以rope开始的词，包括ropes）的行
select note_text from productnotes where match(note_text) against('heavy -rope*' in boolean mode);

# 匹配包含词rabbit和bait的行
select note_text from productnotes where match(note_text) against('+rabbit +bait' in boolean mode);

# 不指定操作符，搜索匹配包含rabbit和bait中的至少一个词的行
select note_text from productnotes where match(note_text) against('rabbit bait' in boolean mode);

# 搜索匹配短语rabbit bait而不是匹配两个词rabbit和bait。 
select note_text from productnotes where match(note_text) against('"rabbit bait"' in boolean mode);

# 匹配rabbit和carrot，增加前者的等级，降低后者的等级
select note_text from productnotes where match(note_text) against('>rabbit <carrot' in boolean mode);

# 必须匹配词safe和combination，降低后者的等级
select note_text from productnotes where match(note_text) against('+safe +(<combination)' in boolean mode);


#############################
# 第19章 插入数据 
#############################

-- 插入完整的行 
# 插入一个新客户到customers表
# 简单但不安全，如果原来表列结构调整，会有问题 
insert into customers values (null,'Pep E. LaPew','100 Main Street','Los Angeles','CA','90046','USA',NULL,NULL);
# 表明括号内明确列名，更安全，稍繁琐 
insert into customers (cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country,cust_contact,cust_email)
values ('Pep E. LaPew','100 Main Street','Los Angeles','CA','90046','USA',NULL,NULL);

-- 插入多个行 
# 方法1： 提交多个insert 语句
insert into customers(cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
values('Pep E. LaPew','100 Main Street','Los Angeles','CA','90046','USA');
insert into customers(cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
values('M. Martian','42 Galaxy Way','New York','NY','11213','USA');
# 方法2： 只要每条INSERT语句中的列名（和次序）相同，可以如下组合各语句
# 单条INSERT语句有多组值，每组值用一对圆括号括起来，用逗号分隔
insert into customers(cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
values('Pep E. LaPew','100 Main Street','Los Angeles','CA','90046','USA'),('M. Martian','42 Galaxy Way','New York','NY','11213','USA');

-- 插入检索出来的值 
# 新建custnew表（非书本内容）
CREATE TABLE `custnew` (
  `cust_id` int(11) NOT NULL AUTO_INCREMENT,
  `cust_name` char(50) NOT NULL,
  `cust_address` char(50) DEFAULT NULL,
  `cust_city` char(50) DEFAULT NULL,
  `cust_state` char(5) DEFAULT NULL,
  `cust_zip` char(10) DEFAULT NULL,
  `cust_country` char(50) DEFAULT NULL,
  `cust_contact` char(50) DEFAULT NULL,
  `cust_email` char(255) DEFAULT NULL,
  PRIMARY KEY (`cust_id`)
) ENGINE=InnoDB;

# 在表custnew中插入一行数据 （非书本内容）
insert into custnew (cust_id,cust_contact,cust_email,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
values(null,null,'mysql carsh course@learning.com','Y.CARY','BAKE WAY','NEW YORK','NY','112103','USA');

# 将custnew中内容插入到customers表中 
# 同书本代码不同，这里省略了custs_id,这样MySQL就会生成新值。
insert into customers (cust_contact,cust_email,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country)
select cust_contact,cust_email,cust_name,cust_address,cust_city,cust_state,cust_zip,cust_country from custnew;


#############################
# 第20章 更新和删除数据 
#############################

-- update语句 : 删除或更新指定列 
# 更新： 客户10005现在有了电子邮件地址
update customers set cust_email = 'elmer@fudd.com' where cust_id = 10005;
# 更新： 多个列 
UPDATE customers 
SET cust_name = 'The Fudds',
    cust_email = 'elmer@fudd.com'
WHERE cust_id = 10005;

# 删除： 某个列的值，可设置它为NULL（假如表定义允许NULL值）
update customers set cust_email = null where cust_id = 10005;

-- delete 语句： 删除整行而不是某列 
# 从customers表中删除一行
delete from customers where cust_id = 10006;

-- truncate table语句 
# 如果想从表中删除 所有行，不要使用DELETE，可使用TRUNCATE TABLE语句
# TRUNCATE实际是删除原来的表并重新创建一个表，而不是逐行删除表中的数据


#############################
# 第21章 创建和操纵表  
#############################

-- 新建表 create table
# 参书本配套文件create.sql

-- 更新表 alter table 
# 给vendors表增加一个名为vend_phone的列
alter table vendors 
add vend_phone char(20);
# 删除刚刚添加的列
alter table vendors
drop column vend_phone;

# ALTER TABLE的一种常见用途是定义外键
# 以下为书本配套文件create.sql中定义外键的语句 
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_orders FOREIGN KEY (order_num) REFERENCES orders (order_num);
ALTER TABLE orderitems ADD CONSTRAINT fk_orderitems_products FOREIGN KEY (prod_id) REFERENCES products (prod_id);
ALTER TABLE orders ADD CONSTRAINT fk_orders_customers FOREIGN KEY (cust_id) REFERENCES customers (cust_id);
ALTER TABLE products ADD CONSTRAINT fk_products_vendors FOREIGN KEY (vend_id) REFERENCES vendors (vend_id);

-- 删除表
# 删除customers2表（假设它存在）
drop table customers2;

-- 重命名表 
# 使用RENAME TABLE语句可以重命名一个表 (假设存在下述表)
rename table customers2 to customers;
# 对多个表重命名(假设存在下述表)
rename table backup_customers to customer,
			 backup_vendors to vendors,
             backup_products to products;


#############################
# 第22章 使用视图   
#############################

/*视图提供了一种MySQL的SELECT语句层次的封装，可用来简化数据处理以及重新格式化基础数据或保护基础数据。 */ 

-- 创建视图 create view
-- 创建视图的语句 show create view viewname
-- 删除视图 drop view viewname
-- 更新视图 1. 先drop后create 2. 直接用create or repalce view

# 创建一个名为productcustomers的视图
create view productcustomers as
select cust_name,cust_contact,prod_id
from customers,orders,orderitems
where customers.cust_id = orders.cust_id
and orders.order_num = orderitems.order_num;
# 检索订购了产品TNT2的客户
select cust_name,cust_contact from productcustomers where prod_id = 'TNT2';

# 用视图重新格式化检索出的数据
# (来自第10章）在单个组合计算列中返回供应商名和位置
select concat(rtrim(vend_name),' (',rtrim(vend_country),')') as vend_title from vendors order by vend_name;
# 若经常使用上述格式组合，可以创建视图 
create view vendorlocations as
select concat(rtrim(vend_name),' (',rtrim(vend_country),')') as vend_title from vendors order by vend_name;
# 检索出以创建所有邮件标签的数据
select * from vendorlocations;

# 用视图过滤不想要的数据
# 定义customeremaillist视图，它过滤没有电子邮件地址的客户
create view customeremaillist as 
select cust_id,cust_name,cust_email from customers
where cust_email is not null;
select * from customeremaillist;

# 使用视图与计算字段
# (来自第10章）检索某个特定订单中的物品，计算每种物品的总价格
select prod_id,quantity,item_price,quantity*item_price as expanded_price from orderitems where order_num = 20005;
# 将其转换为一个视图
create view orderitemsexpanded as 
select order_num,prod_id,quantity,item_price,quantity*item_price as expanded_price from orderitems;
# 创建视图的时候select添加了列名order_num,否则无法按照order_num进行过滤查找 
select * from orderitemsexpanded where order_num = 20005;

# 更新视图 
# 视图中虽然可以更新数据，但是有很多的限制。
# 一般情况下，最好将视图作为查询数据的虚拟表，而不要通过视图更新数据


#############################
# 第23章 使用存储过程    
#############################

-- 创建存储过程 
# 返回产品平均价格的存储过程
delimiter //
create procedure productpricing()
begin
	select avg(prod_price) as priceaverage from products;
end //
delimiter ;
# 调用上述存储过程 
call productpricing();

-- 删除存储过程,请注意:没有使用后面的()，只给出存储过程名。
drop procedure productpricing;

-- 使用参数 out
# 重新定义存储过程productpricing
delimiter //
create procedure productpricing(out pl decimal(8,2), out ph decimal(8,2), out pa decimal(8,2))
begin
	select min(prod_price) into pl from products;
    select max(prod_price) into ph from products;
	select avg(prod_price) into pa from products;
end //
delimiter ;

# 为调用上述存储过程，必须指定3个变量名
call productpricing(@pricelow,@pricehigh,@priceaverage);
# 显示检索出的产品平均价格
select @priceaverage;
# 获得3个值
select @pricehigh,@pricelow,@priceaverage;

-- 使用参数 in 和 out
# 使用IN和OUT参数,存储过程ordertotal接受订单号并返回该订单的合计
delimiter //
create procedure ordertotal(
	in onumber int,   				# onumber定义为IN，因为订单号被传入存储过程
    out ototal decimal(8,2)			# ototal为OUT，因为要从存储过程返回合计
)
begin
	select sum(item_price*quantity) from orderitems 
    where order_num = onumber
    into ototal;
end //
delimiter ;
# 给ordertotal传递两个参数；
# 第一个参数为订单号，第二个参数为包含计算出来的合计的变量名
call ordertotal(20005,@total);
# 显示此合计
select @total;
# 得到另一个订单的合计显示
call ordertotal(20009,@total);
select @total;

-- 建立智能存储过程 
# 获得与以前一样的订单合计，但只针对某些顾客对合计增加营业税

-- Name:ordertotal
-- Parameters: onumber = order number
-- 			   taxable = 0 if not taxable, 1 if taxable
-- 			   ototal  = order total variable
delimiter //
create procedure ordertotal(
	in onumber int,
	in taxable boolean,
    out ototal decimal(8,2)
) comment 'obtain order total, optionally adding tax'
begin
	-- declare variable for total 定义局部变量total
    declare total decimal(8,2);
    -- declare tax percentage 定义局部变量税率 
    declare taxrate int default 6;
    -- get the order total 获得订单合计
	SELECT SUM(item_price * quantity)
	FROM orderitems
	WHERE order_num = onumber INTO total;
	-- is this taxable? 是否要增加营业税？ 
	if taxable then
		-- Yes,so add taxrate to the total 给订单合计增加税率
		select total+(total/100*taxrate) into total;
	end if;
	-- and finally,save to out variable 最后，传递给输出变量 
	SELECT total INTO ototal;
END //
delimiter ;
# 调用上述存储过程，不加税 
call ordertotal(20005,0,@total);
select @total;
# 调用上述存储过程，加税 
call ordertotal(20005,1,@total);
select @total;

# 显示用来创建一个存储过程的CREATE语句
show create procedure ordertotal;

# 获得包括何时、由谁创建等详细信息的存储过程列表
# 该语句列出所有存储过程
show procedure status;
# 过滤模式 
show procedure status like 'ordertotal';


#############################
# 第24章 使用游标     
#############################

-- 创建、打开、关闭游标 
# 定义名为ordernumbers的游标，检索所有订单
delimiter //
create procedure processorders()
begin
	-- decalre the cursor 声明游标 
	declare ordernumbers cursor
    for
    select order_num from orders;
    
	-- open the cursor 打开游标
	open ordernumbers;
	-- close the cursor 关闭游标
	close ordernumbers;
end //
delimiter ;

-- 使用游标数据 
# 例1：检索 当前行 的order_num列，对数据不做实际处理
delimiter //
create procedure processorders()
begin

	-- declare local variables 声明局部变量
    declare o int;
    
    -- decalre the cursor 声明游标 
	declare ordernumbers cursor
    for
    select order_num from orders;
    
	-- open the cursor 打开游标
	open ordernumbers;
    
    -- get order number 获得订单号 
    fetch ordernumbers into o;
    /*fetch检索 当前行 的order_num列（将自动从第一行开始）到一个名为o的局部声明变量中。
    对检索出的数据不做任何处理。*/
        
	-- close the cursor 关闭游标
	close ordernumbers;

END //
delimiter ;

# 例2：循环检索数据，从第一行到最后一行，对数据不做实际处理
delimiter //
create procedure processorders()
begin
	-- declare local variables 声明局部变量
    declare done boolean default 0;
    declare o int;
   
    -- decalre the cursor 声明游标 
	declare ordernumbers cursor
    for
    select order_num from orders;
   
    -- declare continue handler
    declare continue handler for sqlstate '02000' set done =1;
    -- SQLSTATE '02000'是一个未找到条件，当REPEAT由于没有更多的行供循环而不能继续时，出现这个条件。
    
    -- open the cursor 打开游标
	open ordernumbers;
    
    -- loop through all rows 遍历所有行 
    repeat
    
    -- get order number 获得订单号 
    fetch ordernumbers into o;
    -- FETCH在REPEAT内，因此它反复执行直到done为真
    
    -- end of loop
    until done end repeat;
    
	-- close the cursor 关闭游标
	close ordernumbers;

end //
delimiter ;


# 例3：循环检索数据，从第一行到最后一行，对取出的数据进行某种实际的处理
delimiter //
create procedure processorders()
begin
	-- declare local variables 声明局部变量 
    declare done boolean default 0;
    declare o int;
    declare t decimal(8,2);
    
    -- declare the cursor 声明游标
    declare ordernumbers cursor
    for
    select order_num from orders;
    
    -- declare continue handler
    declare continue handler for sqlstate '02000' set done = 1;
    
    -- create a table to store the results 新建表以保存数据
    create table if not exists ordertotals
    (order_num int,total decimal(8,2));
    
    -- open the cursor 打开游标
    open ordernumbers;
    
    -- loop through all rows 遍历所有行
    repeat
    
    -- get order number 获取订单号
    fetch ordernumbers into o;
    
    -- get the total for this order 计算订单金额
    call ordertotal(o,1,t);  # 参见23章代码，已创建可使用
    
    -- insert order and total into ordertotals 将订单号、金额插入表ordertotals内
    insert into ordertotals(order_num,total) values(o,t);
    
	-- end of loop
    until done end repeat;
    
	-- close the cursor 关闭游标
	close ordernumbers;

end // 
delimiter ;
# 调用存储过程 precessorders()
call processorders();
# 输出结果
select * from ordertotals;


#############################
# 第25章 使用触发器      
#############################

-- 创建触发器 
create trigger newproduct after insert on products for each row select 'product added' into @new_pro;
# mysql 5.0以上版本在TRIGGER中不能返回结果集，定义了变量 @new_pro;
insert into products(prod_id,vend_id,prod_name,prod_price) values ('ANVNEW','1005','3 ton anvil','6.09'); # 插入一行 
select @new_pro;  # 显示Product added消息

-- 删除触发器 
drop trigger newproduct;

-- 使用触发器 
# insert触发器
create trigger neworder after insert on orders for each row select new.order_num into @order_num;
insert into orders(order_date,cust_id) values (now(),10001);
select @order_num;

# delete触发器
# 使用OLD保存将要被删除的行到一个存档表中 
delimiter //
create trigger deleteorder before delete on orders for each row
begin
	insert into archive_orders(order_num,order_date,cust_id)
    values(old.order_num,old.order_date,old.cust_id); # 引用一个名为OLD的虚拟表，访问被删除的行
end //
delimiter ;

# update触发器
# 在更新vendors表中的vend_state值时，插入前先修改为大写格式 
create trigger updatevendor before update on vendors 
for each row set new.vend_state = upper(new.vend_state);
# 更新1001供应商的州为china
update vendors set vend_state = 'china' where vend_id =1001;
# 查看update后数据，1001供应商对应的vend_state自动更新为大写的CHINA
select * from vendors;


#############################
# 第26章 管理事务处理 
#############################

-- 事务 transaction 指一组sql语句
-- 回退 rollback 指撤销指定sql语句的过程
-- 提交 commit 指将未存储的sql语句结果写入数据库表
-- 保留点 savepoint 指事务处理中设置的临时占位符，可以对它发布回退（与回退整个事务处理不同）

-- 控制事务处理
# 开始事务及回退 
select * from ordertotals;   # 查看ordertotals表显示不为空
start transaction;  		 # 开始事务处理 
delete from ordertotals;     # 删除ordertotals表中所有行
select * from ordertotals;   # 查看ordertotals表显示 为空
rollback;				     # rollback语句回退 
select * from ordertotals;   # rollback后，再次查看ordertotals表显示不为空

# commit 提交 
start transaction;
delete from orderitems where order_num = 20010;
delete from orders where order_num = 20010;
commit;   # 仅在上述两条语句不出错时写出更改 

# savepoint 保留点 
# 创建保留点
savepoint delete1;
# 回退到保留点 
rollback to delete1;
# 释放保留点 
release savepoint delete1;

-- 更改默认的提交行为 
set autocommit = 0;  # 设置autocommit为0（假）指示MySQL不自动提交更改


#############################
# 第27章 全球化和本地化
#############################

-- 字符集和校对顺序
# 查看所支持的字符集完整列表
show character set;
# 查看所支持校对的完整列表,以及它们适用的字符集
show collation;
# 确定所用系统的字符集和校对
show variables like 'character%';
show variables like 'collation%';
# 使用带子句的CREATE TABLE，给表指定字符集和校对
create table mytable
(
	column1 int,
    column2 varchar(10)
) default character set hebrew 
  collate hebrew_general_ci;
# 除了能指定字符集和校对的表范围外，MySQL还允许对每个列设置它们
create table mytable
(
	column1 int,
    column2 varchar(10),
    column3 varchar(10) character set latin1 collate latin1_general_ci
)default character set hebrew 
 collate hebrew_general_ci;
# 校对collate在对用ORDER BY子句排序时起重要的作用
# 如果要用与创建表时不同的校对顺序排序,可在SELECT语句中说明 
select * from customers order by lastname,firstname collate latin1_general_cs;


#############################
# 第28章 安全管理
#############################

-- 管理用户
# 需要获得所有用户账号列表时
# mysql数据库有一个名为user的表，它包含所有用户账号。user表有一个名为user的列
use mysql;
select user from user;

-- 创建用户账号 
# 使用create user
create user ben identified by 'p@$$w0rd';
# 重命名一个用户账号
rename user ben to bforta;
# 删除用户账号 
drop user bforta;
# 查看赋予用户账号的权限
show grants for bforta;
# 允许用户在（crashcourse数据库的所有表）上使用SELECT，只读
grant select on crashcourse.* to bforta;
# 重新查看赋予用户账号的权限，发生变化 
show grants for bforta;
# 撤销特定的权限
revoke select on crashcourse.* from bforta;
# 简化多次授权
grant select,insert on crashcourse.* to bforta;

-- 更改口令,新口令必须传递到Password()函数进行加密。
set password for bforta = 'n3w p@$$w0rd';  # 原来课本中使用的password()加密函数，在8.0版本中已经移除 
# password() :This function was removed in MySQL 8.0.11.
-- 如果不指定用户名，直接修改当前登录用户的口令 
set password = 'n3w p@$$w0rd';


#############################
# 第29章 数据库维护 
#############################

# 分析表 键状态是否正确
analyze table orders;
# 检查表是否存在错误 
check table orders,orderitems;
check table orders,orderitems quick; # QUICK只进行快速扫描
# 优化表OPTIMIZE TABLE，消除删除和更新造成的磁盘碎片，从而减少空间的浪费
optimize table orders;
