# Implementation Guide

> This guide uses placeholders and sanitized values. Replace `<ADMIN_IP>`, `<USERNAME>`, and `<HOST_IP>` with approved values from your lab or enterprise environment.

## 1. Establish a Known Firewall State

```bash
sudo apt-get update
sudo apt-get install -y ufw
sudo ufw --force reset
```

Starting from a known state reduces confusion from inherited rules and makes the baseline easier to validate.

## 2. Apply Default-Deny Firewall Policy

```bash
sudo ufw default deny incoming
sudo ufw default allow outgoing
```

This blocks inbound connections unless explicitly allowed while preserving normal outbound system functionality.

## 3. Restrict SSH to a Trusted Administrative Source

```bash
sudo ufw allow proto tcp from <ADMIN_IP> to any port 22 comment 'SSH from trusted admin host only'
```

Only a trusted administrative host should be allowed to reach SSH. This reduces exposure to broad network scanning and brute-force attempts.

## 4. Enable Logging and Activate Firewall

```bash
sudo ufw logging on
sudo ufw enable
sudo ufw status verbose
sudo ufw status numbered
```

Logging supports visibility into denied traffic. Numbered status output is useful for later rollback.

## 5. Generate an ED25519 SSH Key

Run this from the administrative host:

```bash
ssh-keygen -t ed25519 -a 100 -C "admin-to-linux-hardening-lab"
```

ED25519 keys are compact and modern, and the increased KDF rounds harden the private key passphrase derivation.

## 6. Copy the Public Key to the Linux Host

```bash
ssh-copy-id -i ~/.ssh/id_ed25519.pub <USERNAME>@<HOST_IP>
```

Validate that key-based login works before disabling passwords.

```bash
ssh <USERNAME>@<HOST_IP>
```

## 7. Backup SSH Server Configuration

```bash
sudo cp /etc/ssh/sshd_config /etc/ssh/sshd_config.$(date +%F).bak
```

A backup is required before editing remote access settings.

## 8. Harden SSH Configuration

Edit the SSH daemon configuration:

```bash
sudo nano /etc/ssh/sshd_config
```

Set or confirm:

```text
PasswordAuthentication no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
```

Optionally restrict access to a specific user from the trusted administrative host:

```text
AllowUsers <USERNAME>@<ADMIN_IP>
```

## 9. Restart SSH and Validate Access

```bash
sudo systemctl restart ssh
sudo systemctl status ssh --no-pager
```

From the administrative host:

```bash
ssh <USERNAME>@<HOST_IP>
```

Do not close the current working session until a second session has successfully authenticated.

## 10. Document Validation and Rollback

Capture:

- `sudo ufw status verbose`
- `sudo ufw status numbered`
- SSH service status
- Successful key-based login
- Current rollback steps

