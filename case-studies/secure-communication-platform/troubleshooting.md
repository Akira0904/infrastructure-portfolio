# Troubleshooting Methodology

Infrastructure incidents are investigated from lower layers upward rather than assuming the application itself is at fault.

## Workflow

1. Interface / addressing
2. Routing
3. VPN state
4. Firewall / NAT
5. Linux listener / service state
6. Reverse proxy
7. Database
8. Application
9. Client behavior

## Useful Commands

```bash
ip link
ip addr
ip route
ip route get <destination>
wg show
ss -tulpn
systemctl --failed
nginx -t
journalctl -u nginx
```

## Verification

A fix is not complete until service reachability is restored, monitoring returns to normal, failover/recovery works where applicable, logs are reviewed and user-facing behavior is confirmed.
