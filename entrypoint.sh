#!/bin/bash
# Ersetzt den Platzhalter in der Config durch die Umgebungsvariable
if [ ! -z "$SMTP_PASSWORD" ]; then
    sed -i "s/password: .*/password: \"$SMTP_PASSWORD\"/" /root/.urlwatch/urlwatch.yaml
    sed -i "s/insecure_password: .*/insecure_password: true/" /root/.urlwatch/urlwatch.yaml
fi

# Führt den eigentlichen Befehl (cron) aus
exec "$@"
