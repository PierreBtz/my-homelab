#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=./common.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)/common.lib.sh"

curl_ha_api '/services/homeassistant/restart'