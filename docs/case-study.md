# Linux Hardening & Secure Access Control

## Executive Summary

This project implemented a secure access baseline for a Linux host by combining host firewall controls, SSH key-based authentication, remote access restrictions, logging, validation, and rollback planning. The purpose was to reduce the risk of unauthorized remote access while preserving reliable administrative access.

The work was structured like a security change package: define the risk, implement controls, verify expected behavior, document recovery steps, and explain the security value in operational terms.

## Problem

SSH is a common administrative entry point. If exposed broadly or configured to allow password login, it can become a high-noise target for brute-force activity, credential attacks, and unauthorized access attempts. Even in a lab, the goal was to practice the kind of change discipline expected in production: harden the system without creating avoidable availability risk.

## Environment

- Ubuntu Linux host used as the system being hardened
- Kali Linux host used as the trusted administrative/testing source
- UFW for host firewall policy
- OpenSSH Server for remote administration
- ED25519 key pair for key-based authentication
- SSH daemon configuration and UFW status output for validation

All public examples use placeholder values. Original lab IP addresses and usernames were removed or generalized.

## Objectives

- Configure default-deny inbound firewall behavior.
- Allow SSH only from a trusted administrative host.
- Enable firewall logging for blocked-traffic visibility.
- Replace password-based SSH access with key-based authentication.
- Disable root login over SSH.
- Validate authorized access after hardening.
- Document rollback steps for UFW and SSH recovery.

## Implementation

The firewall baseline started from a clean UFW state. Inbound traffic was denied by default, outbound traffic was allowed, and SSH was explicitly permitted only from a trusted administrative source. Firewall logging was enabled so denied connection attempts could be reviewed during troubleshooting or monitoring.

The SSH hardening workflow used an ED25519 key pair for administrative access. The public key was copied to the Linux host, the SSH server configuration was backed up, and password authentication was disabled. Challenge-response authentication and root login were also disabled to reduce interactive credential attack surface.

The rollback plan documented how to list and delete numbered UFW rules, reset or disable UFW if required, restore a backed-up SSH daemon configuration, re-enable password authentication in an emergency, remove restrictive user rules, and restart SSH.

## Validation

Success was validated through multiple checks:

- UFW status confirmed the firewall was active.
- UFW rules confirmed SSH was allowed only from the trusted administrative host.
- SSH access was tested using key-based authentication.
- The configuration change was verified by confirming that passwordless key access worked as expected.
- Rollback steps were documented and tested in the lab context.

## Security Value

This project demonstrates practical access-control hardening and operational discipline. In a real security operations environment, similar controls can reduce SSH brute-force exposure, limit administrative access paths, support auditability through logging, and reduce the risk of configuration changes causing lockout or service disruption.

## Skills Demonstrated

- Linux hardening
- SSH security
- UFW firewall configuration
- Least-privilege access control
- Secure administration
- Change validation
- Rollback planning
- Security documentation

## Recruiter Takeaway

This project shows that I can secure a Linux administrative access path, validate the control, and document a recovery plan instead of simply applying commands without operational safeguards.
