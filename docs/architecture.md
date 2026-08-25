# Architecture

## Overview

The lab separates service traffic from administrative access.

- **WAN** — external connectivity
- **DMZ** — application-facing services
- **MGMT** — monitoring and administrative services
- **VPN** — secure remote administrative access

## Example Networks

The addresses below are reserved for documentation and are not real production networks.

| Zone | Example subnet | Purpose |
|---|---|---|
| DMZ | 192.0.2.0/24 | Application services |
| MGMT | 198.51.100.0/24 | Administration and monitoring |
| VPN | 203.0.113.0/24 | WireGuard lab addresses |

## Traffic Principles

1. Internet traffic reaches only explicitly published services.
2. Administrative interfaces are not exposed directly to the Internet.
3. Remote administration uses WireGuard.
4. MGMT access is restricted by firewall rules.
5. Monitoring may scrape approved targets across zones.
6. East-west traffic should follow least-privilege rules.
