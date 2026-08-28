# Disclosure Policy

This portfolio is based on real infrastructure engineering experience, but all public materials are sanitized.

## Never Publish

- real IP addresses or production domains
- credentials, API tokens or private keys
- internal user names or IDs
- organization identifiers
- SIEM destinations
- production firewall exports or configuration backups
- internal network diagrams
- confidential screenshots

## Allowed

- reconstructed architecture diagrams
- documentation-only IP ranges
- generic hostnames and placeholder keys
- configuration examples written specifically for this repository
- sanitized screenshots after manual review
- generic incident descriptions that preserve technical learning

## Before Publishing

1. Review `git diff --cached`
2. Search for secrets and real domains/IPs
3. Review screenshots manually
4. Confirm no organization-specific identifiers remain
