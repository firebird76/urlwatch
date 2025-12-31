# Basis-Image: Alpine ist deutlich kleiner (~5MB)
FROM alpine:latest

LABEL maintainer="dev@scharlewsky.de" \
      build_date="2025-02-15" \
      name="urlwatch-alpine"

# Umgebungsvariablen setzen
# Hinweis: Alpine nutzt musl, Locales funktionieren dort etwas anders als in Debian.
# Für die meisten Python-Apps reicht die UTF-8 Einstellung.
ENV LANG=de_DE.UTF-8 \
    LANGUAGE=de_DE:de \
    LC_ALL=de_DE.UTF-8 \
    TZ=Europe/Berlin

# Installation der Pakete
# In Alpine gibt es urlwatch oft direkt im Repository (Community Branch)
RUN apk add --no-cache \
    python3 \
    py3-pip \
    urlwatch \
    tzdata \
    nano \
    bash

# Zeitzone einstellen
RUN cp /usr/share/zoneinfo/$TZ /etc/localtime && \
    echo $TZ > /etc/timezone

# Cron-Konfiguration
# Alpine nutzt BusyBox Cron. Die Spool-Dateien liegen unter /var/spool/cron/crontabs/
COPY crontab /var/spool/cron/crontabs/root
RUN chmod 0600 /var/spool/cron/crontabs/root

WORKDIR /root

# Volumes für Persistenz
VOLUME ["/root", "/var/log"]

# BusyBox Cron im Vordergrund starten
# -f: Vordergrund
# -l 2: Log-Level (Standard)
# -L /dev/stderr: Logs nach stderr leiten, damit 'docker logs' sie sieht
CMD ["crond", "-f", "-l", "2", "-L", "/dev/stderr"]
