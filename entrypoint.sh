#!/bin/bash
set -e

CONFIG="/root/.urlwatch/urlwatch.yaml"

# Nur wenn die Umgebungsvariable gesetzt ist
if [ ! -z "$SMTP_PASS" ]; then
    echo "Konfiguriere SMTP-Passwort..."
    # Setzt das Passwort und aktiviert den 'insecure' Modus für die Session
    sed -i "s/^    password: .*/    password: \"$SMTP_PASS\"/" "$CONFIG"
    sed -i "s/^    insecure_password: .*/    insecure_password: true/" "$CONFIG"
fi

# Führt den normalen Startbefehl (cron) aus
exec "$@"
