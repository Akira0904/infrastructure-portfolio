# Security

## Principles

- Separate management and service networks
- Restrict administrative access to trusted paths and VPN connectivity
- Expose only required service ports
- Use TLS for web-facing services where applicable
- Keep credentials, VPN keys and tokens outside Git
- Forward selected authentication, system and service events to centralized logging / SIEM

## Portfolio Sanitization

This repository does not expose production keys, credentials, real firewall objects, routing tables, internal hostnames, public addresses, production domains or identity data.
