# Redacted Evidence Notes: SSH Key-Only Hardening

## Source Summary

The original lab notes documented the following workflow:

1. Generate an ED25519 SSH key.
2. Copy the public key to the Linux host.
3. Backup the SSH server configuration.
4. Edit SSH settings.
5. Disable password authentication.
6. Disable challenge-response authentication.
7. Enable public key authentication.
8. Disable root login.
9. Optionally restrict SSH access to a specific user/source.
10. Restart SSH.
11. Test key-based access.

## Sanitized Configuration Pattern

```text
PasswordAuthentication no
ChallengeResponseAuthentication no
PubkeyAuthentication yes
PermitRootLogin no
# Optional: AllowUsers <USERNAME>@<ADMIN_IP>
```

## Security Meaning

This reduces password-based remote access risk and supports stronger administrative access control.
