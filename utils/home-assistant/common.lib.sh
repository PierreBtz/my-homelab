#!/usr/bin/env bash
set -euo pipefail

HERE="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Don't load it several times
${_HA_LIB_LOADED:-false} && return

[ -f "${HERE}/.env" ] && export "$(sed '/^#/d' "${HERE}/.env")"

function curl_ha_api() {
  local endpoint="${1}"

  curl -X POST \
  -H "Authorization: Bearer: ${HA_TOKEN}" \
  -H 'Content-Type: application/json' \
  "${HA_URL}/api/${endpoint}"
}

_HA_LIB_LOADED=true