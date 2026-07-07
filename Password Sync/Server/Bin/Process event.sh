#!/bin/bash
###############################################################################
# Обработка события и запуск Ansible
###############################################################################

set -euo pipefail

source /opt/password_sync/bin/password_sync_lib.sh

EVENT_FILE="$1"

USER_MAP="/opt/password_sync/config/user_map.conf"
PLAYBOOK="/opt/password_sync/ansible/change-password.yml"

EVENT_ID=$(grep '^EVENT_ID=' "${EVENT_FILE}" | cut -d= -f2-)
USERNAME=$(grep '^USERNAME=' "${EVENT_FILE}" | cut -d= -f2-)
PASSWORD_HASH=$(grep '^PASSWORD_HASH=' "${EVENT_FILE}" | cut -d= -f2-)

if [ -z "${USERNAME}" ] || [ -z "${PASSWORD_HASH}" ]; then
    log_error "Некорректное событие ${EVENT_ID}"
    exit 1
fi

TARGET_GROUP=$(grep "^${USERNAME}=" "${USER_MAP}" | cut -d= -f2)

if [ -z "${TARGET_GROUP}" ]; then
    log_warning "Для пользователя ${USERNAME} нет маршрута"
    exit 0
fi

TMP=$(mktemp /run/password_sync.XXXXXX.yml)

chmod 600 "${TMP}"

cat > "${TMP}" <<EOF
target_user: "${USERNAME}"
password_hash: "${PASSWORD_HASH}"
force_change_on_next_login: true
EOF

ansible-playbook "${PLAYBOOK}" --limit "${TARGET_GROUP}" -e "@${TMP}"

RC=$?

rm -f "${TMP}"

if [ ${RC} -eq 0 ]; then
    log_info "Пароль пользователя ${USERNAME} успешно синхронизирован"
else
    log_error "Ошибка синхронизации пользователя ${USERNAME}"
fi

exit ${RC}
