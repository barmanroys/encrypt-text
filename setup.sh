#!/usr/bin/env bash
# encoding:utf-8

# Set up the libraries inside the docker container and self destructs in the end

# Exit upon error to preemptively detect incompatibilities at build stage
set -e
# Install the system libraries
apt-get --assume-yes update
# Set the timezone to avoid input prompt while installing libraries
ZONE="Asia/Singapore" # "UTC"
ln --symbolic --no-dereference --force /usr/share/zoneinfo/$ZONE /etc/localtime
echo $ZONE > /etc/timezone
apt-get --assume-yes --no-install-recommends install apt-utils uvicorn moreutils \
    software-properties-common build-essential cmake git python3-pip redis-server celery
# This shenanigan is to install the correct version of the development library
PYVER="$(python3 --version|awk '{print $2}')"
MAJOR="$(cut --delimiter='.' -f1 <<<"$PYVER")"
MINOR="$(cut --delimiter='.' -f2 <<<"$PYVER")"
apt-get --assume-yes --no-install-recommends install "libpython$MAJOR.$MINOR-dev" "python$MAJOR.$MINOR-venv"
python3 -m venv "$ENV_DIR"
source "$ENV_DIR/bin/activate"
# Install the python dependencies
time python3 -m pip install --requirement pip_requirements.txt

# Clean up to reduce image size
rm pip_requirements.txt setup.sh