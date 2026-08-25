# Troubleshooting Notes

## WireGuard

Check interface:

```bash
sudo wg show
ip addr show wg0
ip route
```

Check UDP listener:

```bash
sudo ss -lunp
```

Check firewall and routing:

```bash
sudo nft list ruleset
ip route get <destination>
```

## Nginx

```bash
sudo nginx -t
sudo systemctl status nginx
sudo journalctl -u nginx --since "30 min ago"
```

## Prometheus

```bash
systemctl status prometheus
curl http://localhost:9090/-/healthy
```

Check target state in Prometheus under **Status → Targets**.

## node_exporter

```bash
systemctl status node_exporter
curl http://localhost:9100/metrics
```

## General Linux

```bash
systemctl --failed
journalctl -p warning --since today
df -h
free -h
ss -tulpn
ip addr
ip route
```
