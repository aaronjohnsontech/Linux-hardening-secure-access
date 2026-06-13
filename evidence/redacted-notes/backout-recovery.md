# Redacted Evidence Notes: Back-Out / Recovery

## Source Summary

The original lab notes documented rollback steps for both UFW and SSH:

- List UFW rules by number.
- Delete the SSH restriction rule by number.
- Reset or disable UFW if full firewall rollback is needed.
- Restore a backed-up SSH daemon configuration.
- Manually re-enable password authentication if needed.
- Remove restrictive `AllowUsers` entries if they block access.
- Restart SSH.

## Sanitized Rollback Pattern

```bash
sudo ufw status numbered
sudo ufw delete <RULE_NUMBER>
sudo ufw --force reset
sudo ufw disable
sudo cp $(ls -t /etc/ssh/sshd_config.*.bak | head -1) /etc/ssh/sshd_config
sudo systemctl restart ssh
```

## Security Meaning

Rollback planning reduces the chance that a hardening change becomes an availability incident.
