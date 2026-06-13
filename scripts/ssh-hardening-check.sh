#!/usr/bin/env bash
set -euo pipefail

# SSH Hardening Check
# This script reads sshd_config and reports whether key hardening values are present.
# It does not modify the system.

CONFIG_PATH="${1:-/etc/ssh/sshd_config}"

if [[ ! -f "${CONFIG_PATH}" ]]; then
  echo "Config file not found: ${CONFIG_PATH}"
  exit 1
fi

check_setting() {
  local key="$1"
  local expected="$2"
  if grep -Eiq "^[[:space:]]*${key}[[:space:]]+${expected}([[:space:]]+|$)" "${CONFIG_PATH}"; then
    printf "[PASS] %s %s\n" "${key}" "${expected}"
  else
    printf "[REVIEW] Expected: %s %s\n" "${key}" "${expected}"
  fi
}

check_setting "PasswordAuthentication" "no"
check_setting "ChallengeResponseAuthentication" "no"
check_setting "PubkeyAuthentication" "yes"
check_setting "PermitRootLogin" "no"

if grep -Eiq "^[[:space:]]*AllowUsers[[:space:]]+" "${CONFIG_PATH}"; then
  echo "[INFO] AllowUsers restriction is present. Confirm user and source are correct."
else
  echo "[INFO] No AllowUsers restriction found. This may be acceptable depending on the environment."
fi
