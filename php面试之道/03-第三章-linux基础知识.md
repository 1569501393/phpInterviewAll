# 第三章 Linux基础知识考察点

- - [常用命令](https://www.kancloud.cn/idcpj/php_interview/610388#_2)

  - - [系统安全](https://www.kancloud.cn/idcpj/php_interview/610388#_4)
    - [进程管理](https://www.kancloud.cn/idcpj/php_interview/610388#_7)
    - [用户管理](https://www.kancloud.cn/idcpj/php_interview/610388#_10)
    - [文件系统](https://www.kancloud.cn/idcpj/php_interview/610388#_13)
    - [网络应用](https://www.kancloud.cn/idcpj/php_interview/610388#_16)
    - [网络测试](https://www.kancloud.cn/idcpj/php_interview/610388#_19)
    - [网络配置](https://www.kancloud.cn/idcpj/php_interview/610388#_22)
    - [软件包管理](https://www.kancloud.cn/idcpj/php_interview/610388#_25)
    - [文件内容查看](https://www.kancloud.cn/idcpj/php_interview/610388#_28)
    - [文件处理](https://www.kancloud.cn/idcpj/php_interview/610388#_31)
    - [目录操作](https://www.kancloud.cn/idcpj/php_interview/610388#_34)
    - [文件权限属性](https://www.kancloud.cn/idcpj/php_interview/610388#_37)
    - [文件传输](https://www.kancloud.cn/idcpj/php_interview/610388#_40)
    - [定时任务](https://www.kancloud.cn/idcpj/php_interview/610388#_43)
    - [crontab命令](https://www.kancloud.cn/idcpj/php_interview/610388#crontab_44)
    - [at命令](https://www.kancloud.cn/idcpj/php_interview/610388#at_48)

  - [shell 命令](https://www.kancloud.cn/idcpj/php_interview/610388#shell__56)

  - - [脚本执行方式](https://www.kancloud.cn/idcpj/php_interview/610388#_57)
    - [编写基础](https://www.kancloud.cn/idcpj/php_interview/610388#_63)

## 常用命令

### 系统安全

```
sudo、su、 chmod、setfac
```

### 进程管理

```
w、top、ps、kill、 pkill,、 pstree、 killall
```

### 用户管理

```
id、 usermod、 useradd、 groupadd、 userdel
```

### 文件系统

```
mount、 umount、fsck、df、du
```

### 网络应用

```
curl、 telnet、mail、 elinks
```

### 网络测试

```
ping、 netstat、host
```

### 网络配置

```
hostname、 ifconfig
```

### 软件包管理

```
yum、rpm、apt-get
```

### 文件内容查看

```
head、tail、less、more
```

### 文件处理

```
touch、 unlink、 rename、ln、cat
```

### 目录操作

```
cd、mv、rm、pwd、tree、cp、ls
```

### 文件权限属性

```
setfac、 chmod、 chown、 chgrp
```

### 文件传输

```
ftp、scp
```

### 定时任务

### crontab命令

```
crontab -e`
`* * * * * 命令(分时日月周)
```

### at命令

一次性执行命令

```
at 2: 00 tomorrow
at>/home/Jason/do job
at> Ctrl+D
```

## shell 命令

### 脚本执行方式

1. 赋予权限,直接执行,
   `chmod+ x test.sh;/test.sh`
2. 调用解释器使得脚本执行,
   `bash、csh、csh、ash、bsh、ksh等等`

### 编写基础

开头用#!指定脚本解释器
`#!/bin/sh`

上一篇：[第二章 Javascript、 jquery、AJAX基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610387)下一篇：[第四章 MYSQL基础知识考察点](https://www.kancloud.cn/idcpj/php_interview/610389)