# WireGuard Examples

These configurations illustrate structure only. Never commit private keys.

Generate lab keys locally:

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

Validate with:

```bash
wg show
ip addr show wg0
ip route
```

A recent handshake is useful evidence of peer connectivity, but routed service traffic must still be tested independently.
