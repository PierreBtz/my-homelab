#!/usr/bin/env bash
set -euo pipefail

sudo apt update
sudo apt dist-upgrade -y

echo 'this script does not reboot, make sure to do it to complete the update'