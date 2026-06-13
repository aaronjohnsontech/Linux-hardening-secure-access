#!/usr/bin/env bash
set -euo pipefail

# UFW Default-Deny Baseline Example
# Usage:
#   sudo ./ufw-default-deny-baseline.sh <ADMIN_IP>
#
# Safety:
#   Review before running. Do not use on systems where you lack console,
#   snapshot, or out-of-band recovery access.

if [[ "${EUID}" -ne 0 ]]; then
  echo "Run as root or with sudo."
  exit 1
fi

if [[ $# -ne 1 ]]; then
  echo "Usage: sudo $0 <ADMIN_IP>"
  exit 1
fi

ADMIN_IP="$1"

echo "[+] Installing UFW if needed..."
apt-get update
apt-get install -y ufw

echo "[+] Resetting UFW to a known state..."
ufw --force reset

echo "[+] Applying default policies..."
ufw default deny incoming
ufw default allow outgoing

echo "[+] Allowing SSH only from trusted admin source: ${ADMIN_IP}"
ufw allow proto tcp from "${ADMIN_IP}" to any port 22 comment 'SSH from trusted admin host only'

echo "[+] Enabling logging..."
ufw logging on

echo "[+] Enabling UFW..."
ufw --force enable

echo "[+] Current firewall status:"
ufw status verbose
ufw status numbered

echo "[!] Keep your active SSH session open and validate access from a second terminal."
