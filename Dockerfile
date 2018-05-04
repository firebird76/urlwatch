FROM ubuntu

RUN apt-get update
RUN apt-get install python3-pip git --yes

RUN python3 -m pip install  --upgrade pip

RUN python3 -m pip install pyyaml minidb requests keyring appdirs
RUN python3 -m pip install chump


WORKDIR /root

RUN git clone https://github.com/thp/urlwatch.git

WORKDIR /root/urlwatch





COPY crontab /var/spool/cron/crontabs/root
CMD urlwatch 




VOLUME /root/.urlwatch
CMD ["crond", "-f", "-l", "0", "-d", "0"]
