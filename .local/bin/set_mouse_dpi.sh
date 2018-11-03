#!/bin/sh

DEVICE_NAME='pointer:Logitech MX Master 2S'
PROPERTY_NAME='libinput Accel Speed'

DELTA="${1}"

if [ -z "${DELTA}" ]; then
    DEFAULT_DPI="$(xinput list-props "${DEVICE_NAME}" | grep "${PROPERTY_NAME}" | grep 'Default' | awk '{print $NF}')"
    xinput set-prop "${DEVICE_NAME}" "${PROPERTY_NAME}" "${DEFAULT_DPI}"
else
    CURRENT_DPI="$(xinput list-props "${DEVICE_NAME}" | grep "${PROPERTY_NAME}" | grep -v 'Default' | awk '{print $NF}')"
    NEW_DPI="$(python -c "print(${CURRENT_DPI} + ${DELTA})")"
    xinput set-prop "${DEVICE_NAME}" "${PROPERTY_NAME}" "${NEW_DPI}"
fi
