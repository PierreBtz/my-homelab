#!/usr/bin/env bash
set -euo pipefail

# Don't load it several times
${_LIB_LOADED:-false} && return

function set_cluster_context() {
  docker context use home-cluster
}

function remote_exec() {
  local stack="${1}"
  local command="${2}"
  docker exec -it "$(docker ps -q -f name=${stack} | head -n1)" bash -c "${command}"
}

_LIB_LOADED=true