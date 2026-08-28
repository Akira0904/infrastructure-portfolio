# Networking

## Zones

- **WAN / External** — public-facing connectivity and upstream Internet access
- **DMZ** — application-facing services
- **MGMT** — management and monitoring services
- **VPN** — trusted connectivity between external/cloud systems and internal infrastructure

## Example Policy Model

| Source | Destination | Policy |
|---|---|---|
| Internet | MGMT | Deny |
| Internet | Published service | Allow only required ports |
| VPN | MGMT | Allow selected administrative access |
| DMZ | MGMT | Deny by default |
| MGMT | DMZ | Allow required administration / monitoring |
| DMZ | Internet | Allow only as required |

## Routing and NAT Troubleshooting

Typical validation questions:

1. Is the route correct?
2. Is the packet permitted?
3. Is NAT required?
4. Is the return path symmetric?
5. Is state tracking behaving as expected?

Useful Linux checks:

```bash
ip route
ip route get <destination>
traceroute <destination>
```

## Multi-WAN Validation

- monitor gateway status
- force primary-link failure
- verify traffic movement to backup connectivity
- confirm critical service reachability
- verify alert delivery
- restore primary path and validate failback
