# Monitoring

Monitoring was implemented using Prometheus and Grafana with visibility across hosts, services, VPN connectivity and network infrastructure.

## Monitored Areas

### Linux
- CPU, memory and disk
- filesystem availability
- network traffic
- host availability

### PostgreSQL
- database availability
- connections
- exporter health

### VPN
- WireGuard interface state
- handshake freshness
- tunnel traffic
- tunnel availability

### Network Infrastructure
- WAN availability
- gateway state
- interface traffic
- firewall/router resource utilization
- failover state

### Application Services
- process availability
- HTTP endpoint availability
- reverse proxy availability
- selected application-specific metrics

## Tools

Prometheus · Grafana · node_exporter · postgres_exporter · custom textfile metrics · API-based appliance metrics

## Alerting Philosophy

Useful alerts should answer: **what failed, how critical it is, how long it has failed, and what to check first**.

See the sanitized examples in [`examples/monitoring`](../../examples/monitoring/).
