# Security Approach

This lab follows simple production-oriented security principles:

- Separate management and service networks
- Deny-by-default where practical
- Restrict administrative access to VPN
- Use SSH keys rather than passwords
- Avoid exposing management interfaces publicly
- Use TLS for web services
- Store secrets outside Git
- Keep systems patched
- Log authentication and service failures
- Monitor availability and resource usage

## Public Repository Safety

Before every commit:

```bash
git diff --cached
```

Check that no credentials, private keys, internal addresses or sensitive hostnames are included.
