# 第二章 Javascript、 jquery、AJAX基础知识考察点

- - [javascript](https://www.kancloud.cn/idcpj/php_interview/610387#javascript_2)

  - - [数据类型](https://www.kancloud.cn/idcpj/php_interview/610387#_4)

    - [函数](https://www.kancloud.cn/idcpj/php_interview/610387#_8)

    - [内置对象](https://www.kancloud.cn/idcpj/php_interview/610387#_13)

    - - [Number](https://www.kancloud.cn/idcpj/php_interview/610387#Number_14)
      - [String](https://www.kancloud.cn/idcpj/php_interview/610387#String_21)
      - [Array](https://www.kancloud.cn/idcpj/php_interview/610387#Array_28)
      - [Date](https://www.kancloud.cn/idcpj/php_interview/610387#Date_35)
      - [Math](https://www.kancloud.cn/idcpj/php_interview/610387#Math_38)
      - [Regexp](https://www.kancloud.cn/idcpj/php_interview/610387#Regexp_44)
      - [Window对象](https://www.kancloud.cn/idcpj/php_interview/610387#Window_49)
      - [DOM对象](https://www.kancloud.cn/idcpj/php_interview/610387#DOM_51)

## javascript

### 数据类型

字符串、数字、布尔、数组、对象、Null、 Undefined
Javascript变量均为对象。当您声明一个变量时,就创建了一个新的对象。

### 函数

- 无默认值
- 函数内部声明的变量(使用var)是局部变量
- 在函数外声明的变量是全局变量,所有脚本和函数都能访问它(与 php 不同, php 外部变量也不可再函数 内部使用)

### 内置对象

#### Number

```
var p=3.14;
var mynum=new Number(value);
var my_Num= Number(value);
```

#### String

```
var str='This is String';
var str=new String(s);
var str=String(s);
```

#### Array

```
var arr=new Array ();
var arr=new Array(size)
var arr=new Array(el, e2, e3,.en);
```

#### Date

```
var date=new Date ();
```

#### Math

```
var pi_value= Math.PI
var sqrt_value=Math sqrt(9);  //9 开根
```

#### Regexp

```
/pattern/attributes
new Regexp(pattern, attributes)
```

#### Window对象

```
Window、 Navigator、 Screen、 History、 Location
```

#### DOM对象

```
Document、Element、Attr、 Event
```

上一篇：[第一章PHP基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610386)下一篇：[第三章 Linux基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610388)