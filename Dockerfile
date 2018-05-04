FROM alpine:edge

RUN apk add --update git lua-dev gcc make openssl-dev pcre-dev g++ 

WORKDIR /root

RUN git clone https://github.com/thp/urlwatch.git

WORKDIR /root/urlwatch

RUN make all
RUN make install
RUN mkdir /root/.urlwatch


COPY crontab /var/spool/cron/crontabs/root
CMD urlwatch 




VOLUME /root/.urlwatch
CMD ["crond", "-f", "-l", "0", "-d", "0"]
