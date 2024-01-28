#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../common" && pwd)/utils.lib.sh"

set_cluster_context
echo "Will ban IP: ${1} for 24h"
remote_exec 'crowdsec' "cscli decisions add -i ${1}  --duration 24h --reason 'suspicious'"
