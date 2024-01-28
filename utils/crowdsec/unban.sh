#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../common" && pwd)/utils.lib.sh"

set_cluster_context
echo "Will unban IP: ${1}"

docker exec "$(docker ps -q -f name=crowdsec | head -n1)" bash -c "cscli decisions delete -i ${1}"
