# set the base image
FROM debian:trixie-slim

# author
#MAINTAINER Tobias Scharlewsky

LABEL maintainer="dev@scharlewsky.de"
LABEL build_date="2026-01-01"
LABEL name="urlwatch"

RUN apt-get update && apt-get dist-upgrade -y && \
    apt-get install -y --no-install-recommends \
    cron \
    locales \
    urlwatch \
    nano \
    tzdata && \
    # Locales generieren
    sed -i -e 's/# de_DE.UTF-8 UTF-8/de_DE.UTF-8 UTF-8/' /etc/locale.gen && \
    locale-gen && \
    # Cleanup: Entfernt temporäre Dateien sofort im selben Layer
    apt-get purge -y --auto-remove && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

COPY crontab /var/spool/cron/crontabs/root
RUN chmod 0600 /var/spool/cron/crontabs/root

WORKDIR /root

VOLUME ["/root/.urlwatch", "/var/log"]

CMD ["cron", "-f"]

