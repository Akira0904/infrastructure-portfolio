# WireGuard Lab

These configurations are examples only.

Generate real lab keys locally:

```bash
wg genkey | tee privatekey | wg pubkey > publickey
```

Never commit private keys to Git.

## Verification

```bash
sudo wg show
ping <peer-tunnel-address>
ip route
```

For persistent NAT traversal from a client behind NAT, `PersistentKeepalive = 25` is commonly useful.
