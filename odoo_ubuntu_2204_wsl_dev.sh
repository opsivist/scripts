#!/bin/bash

################################################################################
# Script for installing Odoo development environment on Ubuntu 22.04
# Author: Achraf Bannour
################################################################################

if [[ $EUID -eq 0 ]]; then
  echo "This script must be run as your usual user"
  exit 1
fi

sudo apt-get update
sudo apt-get dist-upgrade -y
sudo apt-get install -y software-properties-common
sudo add-apt-repository -y ppa:deadsnakes/ppa
sudo apt-get install -y --no-install-recommends \
    antiword \
    build-essential \
    ca-certificates \
    expect \
    gettext \
    git \
    graphviz \
    libreoffice-calc \
    libreoffice-writer \
    make \
    mercurial \
    node-clean-css \
    node-less \
    openssh-client \
    pipx \
    poppler-utils \
    postgresql-client \
    python3 \
    python3-dev \
    python3-venv \
    python3.10 \
    python3.10-dev \
    python3.10-venv \
    python3.11 \
    python3.11-dev \
    python3.11-venv \
    python3.8 \
    python3.8-dev \
    python3.8-venv \
    python3.9 \
    python3.9-dev \
    python3.9-venv \
    rsync \
    tcl \
    wget
sudo wget -q -O /tmp/wkhtmltox.deb https://github.com/wkhtmltopdf/packaging/releases/download/0.12.6.1-2/wkhtmltox_0.12.6.1-2.jammy_amd64.deb
sudo echo "ee88d74834bdec650f7432c7d3ef1c981e42ae7a762a75a01f7f5da59abc18d5 /tmp/wkhtmltox.deb" | sha256sum -c -
sudo apt-get -y install /tmp/wkhtmltox.deb
sudo rm -f /tmp/wkhtmltox.deb

sudo bash -c 'export PIPX_BIN_DIR=/usr/local/bin \
           && export PIPX_HOME=/opt/pipx \
           && pipx install --pip-args="--no-cache-dir" \
                acsoo \
                git-aggregator \
                git-autoshare \
                manifestoo \
                pip-deepfreeze \
                pre-commit \
                virtualenv'

git config --global --add safe.directory '*'

cat <<EOF >~/.config/git-autoshare/repos.yml
github.com:
  enterprise:
    orgs:
      - opsivist
      - odoo
    private: True
  "*":
    orgs:
      - opsivist
      - OCA
      - odoo
EOF
