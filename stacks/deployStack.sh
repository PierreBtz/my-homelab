#!/usr/bin/env bash
set -euo pipefail

function deploy() {
    stack=${PWD##*/}
    compose_file=docker-compose.yml

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

function createNetwork() {
    network_name="internal-network"
    docker network inspect "${network_name}" >/dev/null 2>&1 || \
    docker network create --driver overlay "${network_name}"
}

STACK="${1}"

docker context use home-cluster
echo "Starting to deploy ${STACK}"
createNetwork
pushd "${STACK}" || exit
deploy
popd || exit
