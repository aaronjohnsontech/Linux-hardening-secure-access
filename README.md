# Linux Hardening & Secure Access Control

## Executive Summary

This project implements a secure Linux remote-access baseline using a default-deny firewall policy, SSH key-based authentication, restricted administrative access, firewall logging, validation checks, and rollback procedures.

The goal is to demonstrate a practical security-operations workflow: define the risk, implement controls, validate that access still works as intended, and document a safe recovery path before changes become operationally risky.

> **Recruiter takeaway:** This project shows secure configuration, least privilege, change discipline, validation, and recovery planning — all directly relevant to SOC, IT Security, Endpoint Security, and Detection-focused roles.

## Problem

Linux systems often expose SSH for remote administration. If SSH is left open broadly or allows password-based login, it increases the risk of brute-force attempts, credential stuffing, unauthorized access, and operational disruption. Security teams need a repeatable way to reduce remote-access risk without locking themselves out.

## Objectives

- Establish a default-deny inbound firewall baseline.
- Allow SSH only from a trusted administrative source.
- Enable firewall logging for visibility into denied traffic.
- Move SSH toward key-only authentication.
- Disable root login and password-based authentication.
- Validate that authorized access still works.
- Document rollback procedures for safe recovery.

## Environment

| Component | Role |
|---|---|
| Ubuntu Linux host | System being hardened |
| Kali Linux host | Trusted administrative/test host |
| UFW | Host firewall control |
| OpenSSH Server | Remote administration service |
| ED25519 SSH key | Key-based authentication |
| System logs / UFW logs | Validation and troubleshooting evidence |

All IP addresses and usernames in this public repo are sanitized. Replace placeholders such as `<ADMIN_IP>` and `<USERNAME>` with values from your authorized lab or enterprise environment.

## Implementation Overview

1. Install and reset UFW to a known state.
2. Set default inbound traffic to deny and outbound traffic to allow.
3. Permit SSH only from a trusted administrative host.
4. Enable UFW logging and verify firewall status.
5. Generate an ED25519 SSH key pair.
6. Copy the public key to the Linux host.
7. Backup the SSH daemon configuration.
8. Disable password authentication, challenge-response authentication, and root login.
9. Restart SSH and validate key-based access.
10. Maintain a rollback plan for firewall and SSH configuration recovery.

## Project Structure

```text
linux-hardening-secure-access/
├── README.md
├── docs/
│   ├── case-study.md
│   ├── implementation-guide.md
│   ├── validation-checklist.md
│   ├── rollback-plan.md
│   ├── security-rationale.md
│   └── interview-talking-points.md
├── configs/
│   ├── sshd_config_hardening_example.conf
│   └── ufw-baseline-commands.md
├── scripts/
│   ├── ufw-default-deny-baseline.sh
│   └── ssh-hardening-check.sh
├── evidence/
│   ├── diagrams/
│   │   └── linux-hardening-architecture.svg
│   └── redacted-notes/
│       ├── ufw-default-deny.md
│       ├── ssh-key-only-hardening.md
│       └── backout-recovery.md
└── website/
    ├── linux-hardening-case-study.html
    └── project-card-snippet.html
```

## Skills Demonstrated

- Linux security hardening
- Host firewall configuration
- SSH access control
- Least privilege
- Secure remote administration
- Validation and troubleshooting
- Rollback planning
- Security documentation
- Operational risk reduction

## Safety Notice

Do not run hardening commands on a system you cannot recover through console access, snapshot restore, or out-of-band management. Review the rollback plan before applying firewall or SSH changes.

