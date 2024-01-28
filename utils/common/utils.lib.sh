#!/usr/bin/env bash
set -euo pipefail

# Don't load it several times
${_LIB_LOADED:-false} && return

function set_cluster_context() {
  docker context use home-cluster
}

_LIB_LOADED=true