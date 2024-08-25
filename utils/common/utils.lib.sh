#!/usr/bin/env bash
set -euo pipefail

# Don't load it several times
${_LIB_LOADED:-false} && return

HERE="$(cd -P "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
UTILS_ROOT="${HERE}"/..
STACKS_ROOT="${UTILS_ROOT}"/../stacks
WITH_VPN=${HOMELAB_VPN:-false}

function get_context_name() {
  if [[ "${WITH_VPN}" == true ]];then
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

function build_service_list_for_stack() {
  local stack="${1}"

  pushd "${STACKS_ROOT}" || exit
  readarray services< <(cat docker-compose.yml|yq '.services | keys')

  for service in ${services[@]}
  do
    echo "${stack}_${service}" 
  done
  popd || exit
}

_LIB_LOADED=true