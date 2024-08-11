#!/usr/bin/env bash
set -euo pipefail

# Don't load it several times
${_LIB_LOADED:-false} && return

function get_context_name() {
  if [[ "${HOMELAB_VPN}" == true ]];then
    echo 'home-cluster-vpn'
  else
    echo 'home-cluster'
  fi
}

function set_cluster_context() {
  docker context use $(get_context_name)
}

function remote_exec() {
  local stack="${1}"
  local command="${2}"

  local container
  container=$(container_for_stack "${stack}")
  docker exec -it "${container}" bash -c "${command}"
}

function container_for_stack() {
  local stack="${1}"
  docker ps -q -f name="${stack}" | head -n1
}

_LIB_LOADED=true