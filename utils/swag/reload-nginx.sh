#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../common" && pwd)/utils.lib.sh"

set_cluster_context
echo 'Will reload the nginx configuration'
docker exec -it "$(docker ps -q -f name=swag | head -n1)" nginx -s reload
