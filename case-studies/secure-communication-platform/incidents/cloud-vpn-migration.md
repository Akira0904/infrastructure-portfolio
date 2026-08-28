# Incident Case Study: Cloud VPN Migration

## Scenario

A cloud-hosted VPN gateway was migrated from one provider to another. After migration, unexpected connectivity behavior appeared even though the VPN tunnel itself could establish.

## Investigation

1. Verified public endpoint reachability
2. Verified WireGuard handshake
3. Checked peer configuration and AllowedIPs
4. Checked local and remote routing tables
5. Validated firewall rules and NAT behavior
6. Checked return routing
7. Tested application connectivity
8. Verified monitoring and notifications

```bash
wg show
ip addr
ip route
ip route get <destination>
ss -lunp
ping <peer>
traceroute <destination>
```

## Key Lesson

A successful VPN handshake proves peer connectivity, but **does not prove that routed application traffic is correct**.
