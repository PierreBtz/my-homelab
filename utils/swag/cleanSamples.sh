#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../common" && pwd)/utils.lib.sh"

set_cluster_context
echo 'Will delete swag samples'
remote_exec 'swag' 'rm -rf /config/nginx/proxy-confs/*.sample'
