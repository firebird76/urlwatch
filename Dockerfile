FROM debian:buster

RUN apt-get update && apt-get install -y urlwatch python3-pip cron 
RUN apt-get dist-upgrade -y
RUN python3 -m pip install  --upgrade pip
RUN python3 -m pip install pyyaml minidb requests keyring appdirs
RUN pip3 install --upgrade urlwatch
RUN echo "Europe/Berlin" > /etc/timezone    
RUN dpkg-reconfigure -f noninteractive tzdata

WORKDIR /root

COPY crontab /etc/cron.d/crontab

CMD urlwatch 

VOLUME /root
VOLUME /var/log 

CMD ["cron", "-f"]
