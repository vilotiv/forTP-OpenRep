#!/bin/bash
###############################################################################
# Создание события изменения пароля
###############################################################################

set -euo pipefail

source /opt/password_sync/bin/password_sync_lib.sh

OUTBOX="/opt/password_sync/outbox"

if [ "$#" -ne 1 ]; then
    die "Не указано имя пользователя."
fi

USER_NAME="$1"

HASH=$(/opt/password_sync/bin/get_password_hash.sh "${USER_NAME}")

if [ -z "${HASH}" ]; then
    die "Не удалось получить hash пользователя ${USER_NAME}"
fi

mkdir -p "${OUTBOX}"

EVENT_ID="$(date +%Y%m%d%H%M%S)_$$"

TMP="${OUTBOX}/${EVENT_ID}.tmp"
FILE="${OUTBOX}/${EVENT_ID}.event"

umask 077

cat > "${TMP}" <<EOF
EVENT_ID=${EVENT_ID}
HOSTNAME=$(hostname)
USERNAME=${USER_NAME}
PASSWORD_HASH=${HASH}
DATE=$(date '+%F')
TIME=$(date '+%T')
EOF

mv "${TMP}" "${FILE}"

log_info "Создано событие изменения пароля пользователя ${USER_NAME}. Файл ${FILE}"
