# Validation Checklist

Use this checklist after implementing the Linux hardening baseline.

## Firewall Validation

- [ ] UFW is installed.
- [ ] UFW has been reset or reviewed from a known state.
- [ ] Default inbound policy is set to `deny`.
- [ ] Default outbound policy is set to `allow`.
- [ ] SSH is allowed only from the trusted administrative source.
- [ ] UFW logging is enabled.
- [ ] UFW is active.
- [ ] `sudo ufw status verbose` confirms the intended rules.
- [ ] `sudo ufw status numbered` is captured for rollback reference.

## SSH Validation

- [ ] ED25519 SSH key pair has been created.
- [ ] Public key has been copied to the Linux host.
- [ ] SSH daemon configuration has been backed up.
- [ ] `PasswordAuthentication no` is configured.
- [ ] `ChallengeResponseAuthentication no` is configured.
- [ ] `PubkeyAuthentication yes` is configured.
- [ ] `PermitRootLogin no` is configured.
- [ ] Optional `AllowUsers` restriction has been validated if used.
- [ ] SSH service restarts without errors.
- [ ] Key-based login succeeds from a second session.
- [ ] Existing active session remains open until new access is confirmed.

## Rollback Readiness

- [ ] UFW rule numbers are documented.
- [ ] SSH configuration backup path is documented.
- [ ] Recovery commands are available offline or in a separate terminal.
- [ ] Console/snapshot/out-of-band recovery method is available if this is not a disposable lab system.

## Evidence to Capture

- [ ] UFW verbose status screenshot or output.
- [ ] UFW numbered status screenshot or output.
- [ ] SSH daemon configuration snippet with sensitive values redacted.
- [ ] Successful key-based SSH login evidence.
- [ ] Rollback plan saved with the project documentation.
