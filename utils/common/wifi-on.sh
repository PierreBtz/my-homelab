#!/usr/bin/env bash
set -euo pipefail

# This script should be ran on the target machine
echo 'Turning wifi on'
nmcli radio wifi on
