#!/bin/bash
###############################################################################
# Password Sync Agent
# Общая библиотека функций
###############################################################################

LOG_FILE="/var/log/password_sync/password_sync.log"

log_write() {
    local level="$1"
    local message="$2"

    mkdir -p "$(dirname "${LOG_FILE}")"

    {
        echo "=============================================================="
        echo "Дата: $(date '+%d.%m.%Y %H:%M:%S')"
        echo "Уровень: ${level}"
        echo "Сообщение:"
        echo "${message}"
        echo "=============================================================="
    } >> "${LOG_FILE}"
}

log_info() {
    log_write "ИНФОРМАЦИЯ" "$1"
}

log_warning() {
    log_write "ПРЕДУПРЕЖДЕНИЕ" "$1"
}

log_error() {
    log_write "ОШИБКА" "$1"
}

die() {
    log_error "$1"
    exit 1
}
