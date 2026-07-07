#!/bin/bash
###############################################################################
# Прием события изменения пароля через SSH
###############################################################################

set -euo pipefail

source /opt/password_sync/bin/password_sync_lib.sh

INBOX="/opt/password_sync/inbox"

mkdir -p "${INBOX}"

umask 077

TMP=$(mktemp "${INBOX}/event.XXXXXX.tmp")

cat > "${TMP}"

EVENT_ID=$(grep '^EVENT_ID=' "${TMP}" | cut -d= -f2)

if [ -z "${EVENT_ID}" ]; then
    log_error "Получено событие без EVENT_ID"
    rm -f "${TMP}"
    exit 1
fi

mv "${TMP}" "${INBOX}/${EVENT_ID}.event"

log_info "Получено новое событие ${EVENT_ID}"

echo "OK"
