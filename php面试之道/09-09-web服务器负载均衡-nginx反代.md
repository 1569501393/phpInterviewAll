# Web服务器的负载均衡-ngnix 反向 代理

- - [七层负载均衡的实现](https://www.kancloud.cn/idcpj/php_interview/610461#_2)

  - - [Nginx负载均衡](https://www.kancloud.cn/idcpj/php_interview/610461#Nginx_6)

    - - [内置策略](https://www.kancloud.cn/idcpj/php_interview/610461#_10)
      - [扩展策略](https://www.kancloud.cn/idcpj/php_interview/610461#_19)

  - [四层负载均衡的实现](https://www.kancloud.cn/idcpj/php_interview/610461#_43)

## 七层负载均衡的实现

基于URL等应用层信息的负载均衡
Nginx的 proxy是它一个很强大的功能,实现了7层负载均衡

### Nginx负载均衡

内置策略、扩展策略
内置策略: IP Hash、加权轮询
扩展策略:fair策略、通用hash、一致性hash

#### 内置策略

- 加权轮询策略
  首先将请求都分给高权重的机器,直到该机器的权值降到了比其他机器低,才开始将请求分给下一个高权重的机器
  当所有后端机器都down掉时, Nginx会立即将所有机器的标志位清成初始状态,以避免造成所有的机器都处在 timeout的状态
- IP Hash
  Nginx内置的另一个负载均衡的策略,流程和轮询很类似,只是其中的算法和具体的策略有些变化
  IP Hash算法是一种变相的轮询算法

#### 扩展策略

- fair策略
  根据后端服务器的响应时间判断负载情况,从中选出负载最轻的机器进行分流
- 通用Hash、一致性Hash策略
  通用hash比较简单,可以以 Nginx内置的变量为key进行hash,致性hash采用了 Nginx内置的一致性hash环,支持 memcache

```
Nginx配置
http{
    upstream imooc_cluster {
        server 121.42.68.3:8001 weight=10;// 加权中
        server 121.42.69.3:8002 weight=9;
        #server 121.42.68.3:8003;
        #server 121.42.68.4;
    }
    server {
        listen 80;
        location / {
            proxy_pass http: //imooc_cluster;
        }
    }
}
```

## 四层负载均衡的实现

通过报文中的目标地址和端口,再加上负载均衡设备设置的服务器选择方式,决定最终选择的内部服务器

LVS实现服务器集群负载均衡有三种方式,NAT,DR和TUN

上一篇：[数据库缓存](https://www.kancloud.cn/idcpj/php_interview/610460)