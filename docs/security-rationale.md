# Security Rationale

## Default-Deny Inbound Firewall

A default-deny inbound firewall posture limits services exposed to the network. Instead of allowing inbound connectivity by default, access must be explicitly permitted. This reduces accidental exposure and makes the system's network surface easier to reason about.

## Trusted-Source SSH Restriction

Restricting SSH to a trusted administrative source reduces noise from scanning and brute-force attempts. Even if SSH is patched and configured securely, reducing the number of systems that can reach it is a meaningful risk reduction.

## Firewall Logging

Firewall logging creates visibility into denied connection attempts and supports troubleshooting. In a SOC context, these logs can help analysts understand blocked behavior, scanning, or unexpected connection attempts.

## SSH Key-Based Authentication

SSH keys reduce reliance on password authentication. When protected with a passphrase and managed correctly, keys provide stronger administrative access control than reusable passwords.

## Disable Password Authentication

Disabling password-based authentication reduces the effectiveness of brute-force, credential-stuffing, and password-spraying attacks against SSH.

## Disable Root Login

Disabling root login forces administrators to authenticate as named users and elevate privileges when needed. This improves accountability and reduces direct exposure of the highest-privilege account.

## Rollback Planning

Security changes can create availability risk if applied carelessly. A rollback plan demonstrates operational maturity: the goal is not just to harden systems, but to do so in a way that preserves authorized access and service continuity.
