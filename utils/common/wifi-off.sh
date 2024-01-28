#!/usr/bin/env bash
set -euo pipefail

# This script should be ran on the target machine
echo 'Turning wifi off'
sudo nmcli radio wifi off
