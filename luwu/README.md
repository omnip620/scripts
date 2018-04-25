一键生成nginx index文件

配置文件
```
port: 8070
domain: localhost
root: /Users/centos/Downloads
auth:
  enable: on
  name: 'admin'
  pwd: 'admin'
```
如启用密码验证，则密码配置文件会保存在指定的root目录下