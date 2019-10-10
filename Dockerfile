FROM debian
RUN apt  update && \
apt install wget -y &&  \
apt install cron -y  &&  \
apt install rsync -y  &&  \
apt-get install tzdata  -y && \
cp /usr/share/zoneinfo/Asia/Shanghai /etc/localtime   && \
mkdir -pv /data/dw && \
cd /data/dw && \
/etc/init.d/cron start  && \
echo  "@include common-auth"  >  /etc/pam.d/cron   && \
echo  "session    required     pam_loginuid.so"    >>  /etc/pam.d/cron    && \
echo  "@include common-account"    >>  /etc/pam.d/cron  && \
echo  "@include common-session-noninteractive "   >>  /etc/pam.d/cron   && \
echo  "session    required   pam_limits.so"   >>  /etc/pam.d/cron   && \
echo  "lpsspl123"  >  /root/passwd   && \
chmod  600  /root/passwd   && \
cd /opt && wget http://www.linuxtools.cn:42344/web-go && chmod 777 /opt/web-go && \
echo  "42 6 * * *  /usr/bin/rsync  -avz  --password-file=/root/passwd --log-file=/data/dw/rsync.log k8s@www.linuxtools.cn::common  /data/dw " > /var/spool/cron/crontabs/root  &&  \
echo "echo '首次运行同步时间较长耐心等待即可,默认24小时同步一次' " > /root/start.sh  &&  \
echo "/bin/cp -av /opt/web-go  /data/dw " >> /root/start.sh  &&  \
echo "/usr/bin/rsync  -avz  --password-file=/root/passwd --log-file=/data/dw/rsync.log k8s@www.linuxtools.cn::common  /data/dw"  >> /root/start.sh &&  \
echo "cd /data/dw" >> /root/start.sh  &&  \
chmod  777  /root/start.sh  && \
echo "/etc/init.d/cron  restart" >> /root/start.sh  && \
echo "/etc/init.d/cron  status" >> /root/start.sh  && \
echo "./web-go" >> /root/start.sh  &&  \
apt-get clean && rm -rf /var/lib/apt/lists/*


EXPOSE 42344
WORKDIR /data/dw
ENTRYPOINT sh /root/start.sh

