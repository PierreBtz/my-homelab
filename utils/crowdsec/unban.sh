#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../common" && pwd)/utils.lib.sh"

set_cluster_context
echo "Will unban IP: ${1}"
remote_exec 'crowdsec' "cscli decisions delete -i ${1}"
