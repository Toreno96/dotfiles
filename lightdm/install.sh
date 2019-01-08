#!/bin/sh

LIGHTDM_CONFIG_DIR='/etc/lightdm'
find . -type f -not -samefile "${0}" -exec cp -vi {} "${LIGHTDM_CONFIG_DIR}" \;
