#!/usr/bin/env bash
# encoding:utf-8

# The script is used to fire up the ASGI from the project root. It is a
# blocking script
source "$ENV_DIR/bin/activate"
cd src/ || exit 1
# Start the ASGI
python3 gateway.py