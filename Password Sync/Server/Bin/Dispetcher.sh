#!/bin/bash
###############################################################################
# Диспетчер очереди событий
###############################################################################

set -euo pipefail

source /opt/password_sync/bin/password_sync_lib.sh

INBOX="/opt/password_sync/inbox"
PROCESSING="/opt/password_sync/processing"
ARCHIVE="/opt/password_sync/archive"
FAILED="/opt/password_sync/failed"

mkdir -p "${PROCESSING}" "${ARCHIVE}" "${FAILED}"

while true
do
    EVENT=$(find "${INBOX}" -type f -name "*.event" | head -n1)

    if [ -z "${EVENT}" ]; then
        sleep 5
        continue
    fi

    NAME=$(basename "${EVENT}")

    mv "${EVENT}" "${PROCESSING}/${NAME}"

    if /opt/password_sync/bin/process_event.sh "${PROCESSING}/${NAME}"
    then
        mv "${PROCESSING}/${NAME}" "${ARCHIVE}/"
    else
        mv "${PROCESSING}/${NAME}" "${FAILED}/"
    fi
done
