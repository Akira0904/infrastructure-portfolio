# Deployment Guide

## Suggested Virtual Machines

### OPNsense
- 2 vCPU
- 2 GB RAM
- WAN, DMZ and MGMT interfaces

### App Server
- Ubuntu Server
- 2 vCPU
- 2 GB RAM
- Nginx
- node_exporter

### Monitoring Server
- Ubuntu Server
- 2 vCPU
- 4 GB RAM
- Prometheus
- Grafana

### Optional Database Server
- Ubuntu Server
- PostgreSQL
- postgres_exporter

## Deployment Order

1. Create Proxmox bridges / isolated lab networks.
2. Deploy OPNsense and assign interfaces.
3. Configure DMZ and MGMT gateways.
4. Add minimum required firewall rules.
5. Deploy Linux VMs.
6. Configure WireGuard.
7. Deploy Nginx.
8. Deploy Prometheus and Grafana.
9. Add exporters.
10. Validate routing, monitoring and alerts.
11. Document test results.
