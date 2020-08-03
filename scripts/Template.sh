#!/usr/bin/env bash

if [ $# -eq 0 ]; then
    echo "usage: $0 <args>" > /dev/stderr
    exit 1
fi

OUTPUT="`$* 2>&1`"

if [ $? -ne 0 ]; then
    echo "$OUTPUT" > /dev/stderr
    exit $?
fi