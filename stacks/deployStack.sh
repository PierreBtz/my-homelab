#!/usr/bin/env bash
set -euo pipefail

# shellcheck source=../utils/common/utils.lib.sh
source "$(cd -P "$(dirname "${BASH_SOURCE[0]}")/../utils/common" && pwd)/utils.lib.sh"

function deploy() {
    local stack=${PWD##*/}
    local compose_file=docker-compose.yml

    if [ ! -f $compose_file ]; then
        echo "Stack doesn't have a compose file" >&2
        return 1
    fi

    (
        # export common variables excluding comments
        [ -f ../.env ] && export $(sed '/^#/d' ../.env)
        # export variables excluding comments
        [ -f .env ] && export $(sed '/^#/d' .env)
        docker stack deploy --compose-file $compose_file $stack
    )
}

function create_network() {
    network_name="internal-network"
    docker network inspect "${network_name}" >/dev/null 2>&1 || \
    docker network create --driver overlay "${network_name}"
}

STACK="${1}"

set_cluster_context
echo "Starting to deploy ${STACK}"
create_network
pushd "${STACK}" || exit
deploy
popd || exit
