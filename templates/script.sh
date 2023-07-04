#!/bin/bash

VERSION=0.0.1

USAGE=$(cat << EOF
Usage: $(basename "${0}") [-hv]

Placeholder title.

Placeholder description.

Options:
  -h  Show this help message and exit
  -v  Show version information and exit
EOF
)

while getopts 'hv' option; do
    case "${option}" in
        'h')
            echo "${USAGE}"
            exit
            ;;
        'v')
            echo "${VERSION}"
            exit
            ;;
        *)
            echo "${USAGE}"
            exit 1
            ;;
    esac
done

dependencies_available() {
    (command -v brew &>/dev/null) && (command -v semver &>/dev/null)
}

main() {
}

if dependencies_available; then
    main
fi

# CHANGELOG
#
# All notable changes to this project will be documented in this file.
#
# The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
# and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).
#
# [0.0.1] - yyyy-mm-dd
#
# ADDED
#
# - Initial version of this script.
