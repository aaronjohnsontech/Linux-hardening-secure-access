# UFW Baseline Commands

> Replace `<ADMIN_IP>` with the trusted administrative source address for your authorized environment.

```bash
sudo apt-get update
sudo apt-get install -y ufw
sudo ufw --force reset
sudo ufw default deny incoming
sudo ufw default allow outgoing
sudo ufw allow proto tcp from <ADMIN_IP> to any port 22 comment 'SSH from trusted admin host only'
sudo ufw logging on
sudo ufw enable
sudo ufw status verbose
sudo ufw status numbered
```

## Notes

- Keep a working SSH session open while testing.
- Validate access from a second terminal before closing the original session.
- Capture numbered UFW status output for rollback.
