# Rollback Plan

This rollback plan is designed to recover from firewall or SSH access-control changes that unintentionally block authorized access.

## Safety Rule

Do not close the active SSH session until a new session has successfully authenticated using the intended hardened access path.

## Roll Back UFW SSH Restriction

List numbered UFW rules:

```bash
sudo ufw status numbered
```

Delete the rule that restricts SSH to the trusted administrative host:

```bash
sudo ufw delete <RULE_NUMBER>
```

Confirm the resulting rule set:

```bash
sudo ufw status verbose
```

## Full UFW Reset or Disable

Use only if access or service availability requires a full reset.

```bash
sudo ufw --force reset
sudo ufw disable
```

## Restore SSH Daemon Configuration from Backup

List backups:

```bash
ls -t /etc/ssh/sshd_config.*.bak
```

Restore the most recent backup:

```bash
sudo cp $(ls -t /etc/ssh/sshd_config.*.bak | head -1) /etc/ssh/sshd_config
sudo systemctl restart ssh
```

## Manual Emergency SSH Configuration Recovery

Edit the SSH daemon configuration:

```bash
sudo nano /etc/ssh/sshd_config
```

Temporarily set:

```text
PasswordAuthentication yes
```

Remove or comment any restrictive `AllowUsers` line if it is blocking authorized access.

Restart SSH:

```bash
sudo systemctl restart ssh
```

## Post-Rollback Review

After recovery:

- Identify which control caused the issue.
- Re-test the change in a safer order.
- Confirm backup and rollback commands are accurate.
- Update documentation before reapplying controls.
