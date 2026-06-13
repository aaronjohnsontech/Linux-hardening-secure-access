# Redacted Evidence Notes: UFW Default-Deny Baseline

## Source Summary

The original lab notes documented the following workflow:

1. Install UFW if needed.
2. Reset UFW to a predictable state.
3. Set default inbound policy to deny.
4. Set default outbound policy to allow.
5. Allow SSH only from a trusted administrative/testing host.
6. Enable UFW logging.
7. Enable the firewall.
8. Verify rules with verbose status output.

## Sanitized Command Pattern

```bash
sudo apt-get update && sudo apt-get install -y ufw
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow proto tcp from <ADMIN_IP> to any port 22
sudo ufw logging on
sudo ufw enable
sudo ufw status verbose
```

## Security Meaning

This establishes a least-exposure inbound posture while preserving outbound functionality and administrative SSH from an approved source.
