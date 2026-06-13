# Linux Hardening & Secure Access Control — Case Study

## Executive Summary

This project hardened an Ubuntu host used for remote administration by applying a UFW default-deny inbound baseline, restricting SSH to a trusted administrative source, moving SSH to key-only access, validating the service state, and documenting rollback steps.

The project is intentionally presented like a security operations deliverable rather than a raw lab note set. The emphasis is on control implementation, validation, and recoverability.

## Problem

Remote administration often remains more open than it needs to be. A host that allows SSH from anywhere and still accepts password-based authentication is more exposed to brute-force activity, password guessing, and unauthorized access attempts.

## Objectives

- Reduce SSH exposure using host firewall controls.
- Allow administration only from a trusted source.
- Replace password-based SSH access with key-based authentication.
- Disable root login.
- Confirm that authorized administration still works.
- Maintain a rollback path for both firewall and SSH changes.

## Environment

- **Target host:** Ubuntu / Wazuh Manager (`<HOST_IP>`)
- **Administrative host:** Kali Linux (`<ADMIN_IP>`)
- **Services:** UFW, OpenSSH Server
- **Authentication:** ED25519 key pair

## Implementation Summary

### 1. Firewall Baseline

- Reset UFW to a known state.
- Set **default deny incoming**.
- Set **default allow outgoing**.
- Permit SSH only from the trusted Kali source IP.
- Enable firewall logging.
- Verify final rule state with `ufw status verbose`.

### 2. SSH Hardening

- Generate a new ED25519 key pair.
- Install the public key with `ssh-copy-id`.
- Back up `sshd_config`.
- Set:
  - `PasswordAuthentication no`
  - `ChallengeResponseAuthentication no`
  - `PubkeyAuthentication yes`
  - `PermitRootLogin no`
- Restart SSH.

### 3. Validation

- Confirm SSH service is active and healthy with `systemctl status ssh`.
- Validate successful passwordless login from the trusted administrative host.
- Confirm firewall state and source restriction.

### 4. Rollback & Recovery

- Review the numbered UFW rule list.
- Delete the SSH allow rule if needed.
- Reset or disable UFW for recovery.
- Restart SSH after configuration adjustments.
- Restore the SSH configuration backup if access issues occur.

## Security Value

This project demonstrates more than basic Linux commands. It shows how to apply host hardening in a way that balances **security**, **availability**, and **operational safety**.

That matters in real teams, because a poorly executed security change can create an outage as easily as it reduces risk.

## What This Demonstrates

This project shows the ability to:

- harden Linux administration paths
- reduce attack surface
- validate security changes
- document rollback procedures
- communicate clearly enough for handoff or team use
