#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../utils/common" && pwd)/utils.lib.sh"

set_cluster_context

CONTAINER=$(container_for_stack "${1}")
echo "Found container: ${CONTAINER}"

docker logs -f "${CONTAINER}"