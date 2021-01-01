# 第一章PHP基础知识考察点

- - [什么是引用变量?在PHP当中,用什么符号定义引用变量?](https://www.kancloud.cn/idcpj/php_interview/610386#PHP_2)

  - [回话控制](https://www.kancloud.cn/idcpj/php_interview/610386#_25)

  - - [cookie](https://www.kancloud.cn/idcpj/php_interview/610386#cookie_26)
    - [session](https://www.kancloud.cn/idcpj/php_interview/610386#session_43)
    - [传递session id](https://www.kancloud.cn/idcpj/php_interview/610386#session_id_64)
    - [Session存储方式](https://www.kancloud.cn/idcpj/php_interview/610386#Session_73)

  - [常用设计模式](https://www.kancloud.cn/idcpj/php_interview/610386#_77)

  - [字符串的定义方式](https://www.kancloud.cn/idcpj/php_interview/610386#_81)

  - [知识点延伸](https://www.kancloud.cn/idcpj/php_interview/610386#_97)

  - - [浮点数不能进行比较运算](https://www.kancloud.cn/idcpj/php_interview/610386#_98)
    - [布尔类型](https://www.kancloud.cn/idcpj/php_interview/610386#_109)
    - [数组类型](https://www.kancloud.cn/idcpj/php_interview/610386#_113)
    - [超全局数组](https://www.kancloud.cn/idcpj/php_interview/610386#_114)
    - [三种情况 为NULL](https://www.kancloud.cn/idcpj/php_interview/610386#_NULL_132)
    - [常量](https://www.kancloud.cn/idcpj/php_interview/610386#_135)
    - [优先级](https://www.kancloud.cn/idcpj/php_interview/610386#_140)

  - [流程控制](https://www.kancloud.cn/idcpj/php_interview/610386#_165)

  - - [if与 elseif](https://www.kancloud.cn/idcpj/php_interview/610386#if_elseif_166)
    - [switch ...case](https://www.kancloud.cn/idcpj/php_interview/610386#switch_case_169)
    - [break](https://www.kancloud.cn/idcpj/php_interview/610386#break_173)

  - [函数](https://www.kancloud.cn/idcpj/php_interview/610386#_188)

  - [函数引用](https://www.kancloud.cn/idcpj/php_interview/610386#_190)

  - - [打印函数](https://www.kancloud.cn/idcpj/php_interview/610386#_203)

  - [正则](https://www.kancloud.cn/idcpj/php_interview/610386#_222)

  - [文件操作](https://www.kancloud.cn/idcpj/php_interview/610386#_269)

  - - [文件读取,写入](https://www.kancloud.cn/idcpj/php_interview/610386#_270)
    - [目录操作函数](https://www.kancloud.cn/idcpj/php_interview/610386#_301)
    - [其他函数](https://www.kancloud.cn/idcpj/php_interview/610386#_308)

## 什么是引用变量?在PHP当中,用什么符号定义引用变量?

1. PHP的引用变量的概念及定义方式
   **概念**:	在PHP中引用意味着用不同的名字访问同一个变量内容。
   **定义方式**:	使用&符号
2. 延伸:PHP引用变量的原理
   普通赋值

```
//定义一个变量
$a= range(8,1988)
//定义变量b,将a变量的值赋值给b
// COW机制 Copy On Write
$b=$a;  //此时, $b和$a指向同一个内存地址,只有当$a改变时,$b才指向新的地址
//对a进行修改
$a= range(8,1999)
```

引用赋值

```
$b=&$a
```

$a和$b永远指向一个变量地址

## 回话控制

### cookie

保存本地中

```
//赋值
setcookie($name, $value, $expire, $path, $domain, $seure);
//取值
$_COOKIE($name);
//删除
setcookie("TestCookie", "", time() - 10000 ); 


//设置数组
setcookie("user[three]", "cookiethree");
setcookie("user[two]", "cookietwo");
setcookie("user[one]", "cookieone");
```

### session

保存在服务器中

```
//开始
session_start();
//赋值
$_SESSION['favcolor'] = 'green';

//清空session
$_SESSION=[];
//删除sesion及cookie中的session_id
session_destroy();

//删除
unset($_SESSION["newsession"]);

//以下设置表示,在超过1440的sesison,有百分之一的概率删除session, 
ini_set('session.gc_probability', 1);
ini_set('session.gc_divisor', 100);  
ini_set('session.gc_maxlifetime', 1440); //设置过期时间
```

### 传递session id

可在cookie被禁用时,也可以使用session_id
常量SID 如果开启了 cookie SID 就为空 如果没开启 SID 等价于 - PHPSESSIONID=session_id()的值,
[如何传递 session_id 参考](https://segmentfault.com/q/1010000007715137)

```
< a href="1.php?<? php echo SID ;?>">下个页面</a>
//等价
< a href="1.php?<?php echo session_name() ;?>= <?php session_id() ;?>">下个页</a>
```

### Session存储方式

如果有部署了多个服务器,那么 session_id 不能存在文件中,而是通过`session_set_save_handler`设置 存入`MYSQL、 Memcache、 Redis` 中
[php 官网有存储在sql 中的类实现方法](http://php.net/manual/zh/function.session-set-save-handler.php)

## 常用设计模式

常见设计模式:工厂模式、单例模式、注册树模式、适配器模式
观察者模式和策略模式

## 字符串的定义方式

1. 单引号
2. 双引号
3. heredoc 类似双引号

```
$str = <<<EoT
...
EoT
```

1. newdoc 类似单引号

```
$str = <<<'EoT'
...
'EoT'
```

## 知识点延伸

### 浮点数不能进行比较运算

浮点转为 cpu 会损耗,

```
$a=0.8;
$b=0.1;

if ($a+$b==0.8){
    echo $a+$b;
}
```

### 布尔类型

FALSE的七种情况
整型0、浮点00、布尔 false、空字符串、0字符串、空数组、NULL

### 数组类型

### 超全局数组

`$GLOBALS、$_GET、$_POST、$_REQUEST、$_SESSION、 $_COOKIE、$_SERVER、$_FILES、$_ENV`
$GLOBALS:包含所有已上所有元素

```
$_SERVER['SERVER_ADDR′]  //获取服务器的 ip
$_SERVER['REMOTE_ADDR']   //用户 ip 

$_SERVER['SERVER_NAME']  //获取服务器的域名  www.example.com
$_SERVER[ REQUEST_TIME'] //请求时间
$_SERVER['QUERY_STRING']  //?后的参数 $_GET 参数
$_SERVER['HTTP_REFERER']  //从哪一页进来
$_SERVER['HTTP_USER_AGENT']  //浏览器信息
$_SERVER['REQUEST_URI']   // 域名后的所有信息 /demo/index.php?name=cpj&age=12
$_SERVER['PATH_INFO'] // 网址路径信息 ,一般用于路由
```

### 三种情况 为NULL

直接赋值为NULL、未定义的变量、 unset销毁的变量

### 常量

const、 define
const更快,是语言结构, define是函数
const 可以在类中定义常量,define 不行

### 优先级

```
递增减 > ! > 算数运算符 > 大小比较 > (不)相等比较 > 引用 > 位运算符(^) > 位运算符(|) > 逻辑与 > 逻辑或 > 三目运算 > 赋值 > and > xor > or
```

短路作用：|| 和 && 与 and 和 or 的优先级不同；

```
//短路作用
$a = true || $b == 3; // $b 不会执行； 相当于$a =( true || $b == 3); 
$b = false && $a == 1; // $b 为false 此表达式不会执行
//优先级问题：
$a = false || true;  // $a = true;
$b = false or true; //  $b = false,整体是true；
```

真题

```
$a = 0;
$b = 0;
if($a = 3 > 0 || $b = 3 > 0){  //短路  $a=((3>0)||$b=3>0) 执行3>0后就短路,所以$ a=true
    $a++;
    $b++;
    echo $a;   //$a = 1 (true);
    echo $b;   //$b = 1;
}
```

## 流程控制

### if与 elseif

把 if 范围小的放前面

### switch ...case

控制表达式只能是 整型,浮点型和字符串
continue语句作用到 switch的作用类似于 break

### break

break 的数字代表跳出几次循环

```
for ($i = 0; $i < 3; $i++){
    echo '外层循环'.$i.' 开始'."\n";
    for ($j = 0; $j < 2; $j++){
        if ($i == 1){
            break 2;    //使用break 2直接跳出2层循环
        }
        echo '内层循环'.$i.'-'.$j."\n";
    }
    echo '外层循环'.$i.' 结束'."\n";
}
```

## 函数

## 函数引用

从函数返回一个引用,必须在函数声明和指派返回值给一个变量时都使用引用运算符`&`

```
function  myFunc(){
    static $b= 10;
    return $b;
}
$a = myFunc();
$a = & myFunc();  //$a 与$ b 互为应用
$a = 100;
echo myFunc();  //100
```

### 打印函数

```
//打印一个字符串
print()		
//打印一个或多个字符串   
echo()		

//格式化输出
$num = 2.12;
$d='123a';
printf("%.1f---%d",$num,$d); //2.1---123

//返回格式化值
$num = 2.12;
$d='123a';
echo sprintf("%.1f---%d",$num,$d); //2.1---123
```

## 正则

```
正则表达式的作用:分割、查找、匹配、替换字符串
分隔符:正斜线(/)、hash符号(#) 以及取反符号(~)
通用原子:\d、\D、\w、\W、\s、\S
元字符: * ? A $ + {n } {n,} {n,m} [] () [^]| [-]
模式修正符: i m e s U x A D u
```

后向引用

```
$str='<b>abc</b>';
Pattern= '/<b>(.*)<\/b>/';
preg_replace($pattern, '\\1', $str);  
```

贪婪模式
![img](https://box.kancloud.cn/4e7bcc1b65b7b7e3fcbc32c875966344_1760x516.jpg)
用`.*?` 取消贪婪模式
![img](https://box.kancloud.cn/b1f80ac13e911b6f86f60f58448fca0f_1682x512.jpg)
用 `U`取消贪婪
`$pattern = '/<b>.*</b>/U'`

常用函数

```
preg_match(),
preg_match_all(),
Preg_replace(),
preg_split()
```

中文匹配
UTF-8汉字编码范围是`0x4e00-0x9fa5`,
ANSI(gb2312)环境下,`0xb0-0xf7`,`0xa1-0xfe`

UTF-8要使用u模式修正符使模式字符串被当成UTF-8,
ANSI(gb2312)环境下,要使用chr将Asc码转换为字符

```
$str='中文'
Pattern ='/[\xt{4e001-\x{t9fa5}]+/u'; 
```

匹配 img 的 src 值

```
$str='<img alt="测试" id="aaa"  src="aaa.jpg" />';
$pattern='/<img. *?src="(.*?).*?\/?>/i'  // .*? 为取消贪婪
Preg_match( $Pattern, $str, $match);
```

## 文件操作

### 文件读取,写入

```
模式	描述
r	打开文件为只读。文件指针在文件的开头开始。
w	打开文件为只写。删除文件的内容或创建一个新的文件，如果它不存在。文件指针在文件的开头开始。
a	打开文件为只写。文件中的现有数据会被保留。文件指针在文件结尾开始。创建新的文件，如果文件不存在。
x	创建新文件为只写。返回 FALSE 和错误，如果文件已存在。
r+	打开文件为读/写、文件指针在文件开头开始。
w+	打开文件为读/写。删除文件内容或创建新文件，如果它不存在。文件指针在文件开头开始。
a+	打开文件为读/写。文件中已有的数据会被保留。文件指针在文件结尾开始。创建新文件，如果它不存在。
x+	创建新文件为读/写。返回 FALSE 和错误，如果文件已存在。
```

打开
`fopen("webdictionary.txt", "r")`

读取

```
fread() 读取文件
fgets()  读取一行
fgetc()  读取一个字符
```

关闭
`fclose()`

file_get_content() 与 file_put_content() 性能更好

其他

```
file()  以数组形式读取字符串
```

### 目录操作函数

```
名称相关: basename()、 dirname()、 patino()
目录读取: opendir()、 readdir()、 closedir()、 rewinder()
目录删除: rmdir()  //只有目录中没有文件,才可以删除
目录创建: mkdir() 
```

### 其他函数

```
文件大小: filesize()  //目录文件大小,需要遍历每个文件
目录大小: disk_free_space()  //磁盘可用空间、 disk_total_space()  //总磁盘空间
文件拷贝:copy()
删除文件: unlink()
文件类型: filetype()
重命名文件或者目录: rename()
文件截取: truncate()
文件属性: file_exists()、 is_readable()、 is_writable()、
is_executable()、 filectime()、 fileatime()、 fillemtime()
```

考题范围
文件操作模式,目录的遍历,目录的删除

```
//在文件开头写入 hello word
$path = 'demo.txt';
$handle = fopen($path, 'r');
$content = fread($handle, filesize($path));
$content = "hello word" . $content;
fclose($handle);
//写入
$handle = fopen($path, 'w');
fwrite($handle, $content);
fclose($handle);
```

目录的遍历

```
function loopdir($dir){
    $handle = opendir($dir);
    while(false!==($file=readdir($handle))){
        if ($file !=='.' &&     $file!=='.'){
           echo $file."\n";
           if (filetype($dir.'/'.$file)=='dir'){
               loopdir($dir.'.'.$file);
           }
        }
    }
}
loopdir($dir);
```

上一篇：[常见经典面试题](https://www.kancloud.cn/idcpj/php_interview/610385)下一篇：[第二章 Javascript、 jquery、AJAX基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610387)