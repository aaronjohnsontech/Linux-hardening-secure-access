# Interview Talking Points

## 30-Second Version

I built a Linux hardening lab that reduced SSH exposure by combining UFW default-deny rules, SSH access restricted to a trusted admin host, key-based authentication, disabled password login, disabled root login, firewall logging, validation checks, and a documented rollback plan.

## 2-Minute Version

The goal was to practice a security change the way I would want to see it handled in a real environment. I started by reducing the network attack surface with UFW: default deny inbound, allow outbound, and permit SSH only from a trusted admin source. Then I moved SSH away from passwords by generating an ED25519 key, copying the public key to the Linux host, backing up `sshd_config`, disabling password and challenge-response authentication, enabling public key authentication, and disabling root login.

I validated the firewall state, confirmed key-based access from a separate session, and documented rollback steps for both UFW and SSH. The key point is that the project was not just hardening — it included validation and recovery planning so the change would be operationally safe.

## What This Shows

- I understand least privilege and secure remote administration.
- I can document implementation, validation, and rollback.
- I think about security controls and availability together.
- I can turn a lab into a repeatable operational process.

## Possible Interview Questions

### Why use a default-deny firewall policy?

It reduces unintended exposure. Instead of allowing inbound access by default, every permitted service has to be intentional and documented.

### Why keep outbound traffic allowed?

For this baseline, the goal was to reduce inbound exposure without breaking normal package updates, DNS lookups, or basic system operations. Outbound filtering could be added later with more testing.

### Why disable password authentication?

It reduces exposure to brute-force and credential-stuffing attempts. Key-based authentication also supports stronger admin access control when keys are protected properly.

### What was the biggest operational risk?

Locking myself out. That is why I tested key access before disabling passwords, kept the active session open, and documented rollback procedures.
