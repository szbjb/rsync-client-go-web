# rsync-client-go-web
用于同步k8s一键离线安装包使用
默认端口42344
每天凌晨6点同步一次,首次运行自动同步一次较慢
使用如下
#首次启动 
``` shell 
docker run -it    --restart=always  --name=rsynck8s    -d   -p   42344:42344   -v   /data:/data/dw   7104475/rsync-client:v1.0
```
#关闭
``` shell 
docker stop   rsynck8s
```
#启动
``` shell 
docker start   rsynck8s
```

#查看启动日志
``` shell 
docker logs rsynck8s
```
#查看同步日志
``` shell 
docker exec  rsynck8s   cat /data/dw/rsync.log
```

浏览器访问 http://IP:42344


#   例 无视后面的提示
``` shell 
[root@VM_0_3_centos ~]# docker logs -f rsynck8s
首次运行同步时间较长耐心等待即可,默认24小时同步一次
'/opt/web-go' -> '/data/dw/web-go'
rsync K8s

receiving incremental file list
./
K8s_1.0.tar
K8s_1.0.tar_9.13
K8s_1.0.tar_9.25
K8s_1.0.tar_9.26
jdk-8u221-linux-x64.rpm
nohup.out

sent 141 bytes  received 4,572,421,192 bytes  4,602,336.52 bytes/sec
total size is 4,578,100,503  speedup is 1.00
本机ip地址列表：
172.18.0.2
K8s_内网yum仓库文件共享服务开启，监听42344端口
请使用浏览器打开:http://ip地址:42344,eg:http://172.18.0.2:42344
请不要关闭此程序，祝使用愉快


```
