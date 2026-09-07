# Incident Case Study: Cloud VPN Gateway Migration

## Overview

A cloud-hosted WireGuard gateway providing secure connectivity between external/cloud infrastructure and an internal production environment was migrated from **Microsoft Azure to DigitalOcean**.

The objective was to move the VPN entry point to the new cloud provider while preserving:

- VPN connectivity
- Routing behavior
- Firewall policies
- Application availability
- Monitoring and notifications

> **Note:** This case study is sanitized. Public IP addresses, domains, internal networks, credentials and organizational identifiers have been removed or replaced.

---

## Environment

### Simplified Traffic Flow

```text
External Clients / Services
          |
          v
   Cloud VPN Gateway
          |
          v
     WireGuard Tunnel
          |
          v
   OPNsense Firewall
          |
          v
     Internal Services
```

### Technologies

- Microsoft Azure
- DigitalOcean
- Linux
- WireGuard
- OPNsense
- Routing
- NAT
- Firewall policies
- Infrastructure monitoring

---

## Problem

After migrating the cloud-side VPN gateway to the new provider, end-to-end connectivity had to be restored and validated across the complete infrastructure path.

During troubleshooting, it became clear that a successful WireGuard handshake alone was not sufficient to confirm that production traffic was functioning correctly.

The migration affected several infrastructure layers:

- VPN endpoint configuration
- Public endpoint dependencies
- Firewall rules
- Routing
- NAT
- Return paths
- Application connectivity
- Monitoring and notification logic

---

## Symptoms

During different stages of the migration, the following behavior was investigated:

- WireGuard handshake initially unavailable or inconsistent
- Tunnel later showing a valid handshake while routed traffic still required verification
- Internal services not reachable through the expected path
- Routing behavior differing from the previous cloud environment
- Firewall configuration requiring validation after the endpoint change
- Monitoring and notifications requiring post-migration verification

---

## Investigation

The issue was troubleshot layer by layer.

### 1. Cloud Gateway

The cloud-side Linux gateway was checked first.

Verified:

- Network interfaces
- Public connectivity
- WireGuard service state
- UDP listener
- Cloud firewall rules
- Local Linux firewall rules

Example commands:

```bash
ip addr
ip route
ss -lunp
systemctl status wg-quick@wg0
wg show
```

---

### 2. WireGuard Tunnel

The WireGuard configuration and tunnel state were validated.

Checked:

- Peer public keys
- Endpoint configuration
- `AllowedIPs`
- Tunnel interface addressing
- Latest handshake
- Transmitted and received traffic

Example commands:

```bash
wg show
ip addr show wg0
```

A valid handshake confirmed that the WireGuard peers could communicate.

However, it **did not prove that routed application traffic was working end-to-end**.

---

### 3. Routing

Routing was validated on both sides of the tunnel.

Example commands:

```bash
ip route
ip route get <destination>
```

The following questions were checked:

- Is the destination network routed through WireGuard?
- Is the correct gateway selected?
- Is policy routing involved?
- Does the remote side have a valid return route?
- Does any route still depend on the previous cloud environment?

---

### 4. Firewall and NAT

After confirming tunnel connectivity, firewall and NAT behavior were reviewed.

Checked:

- Cloud firewall rules
- Linux firewall configuration
- OPNsense firewall rules
- NAT behavior
- Forwarding between VPN and internal networks
- Connection states
- Return traffic

The troubleshooting process was divided into three stages:

```text
Can the packet reach the VPN gateway?
                |
                v
Can the packet cross the WireGuard tunnel?
                |
                v
Can the packet reach the internal service
and successfully return?
```

This helped separate VPN problems from routing, firewall and return-path issues.

---

### 5. Application Connectivity

Once the network path was validated, application services were tested independently.

Validation included:

- Service reachability
- Client connectivity
- Reverse proxy access
- Required TCP/UDP service paths

This prevented application-layer problems from being incorrectly attributed to WireGuard.

---

### 6. Monitoring

After connectivity was restored, monitoring was validated.

Checked:

- WireGuard tunnel state
- Handshake freshness
- Tunnel traffic
- Service availability
- Monitoring targets
- Alert delivery
- Operational notifications

---

## Resolution

The cloud VPN gateway was successfully migrated from Microsoft Azure to DigitalOcean.

Configuration dependent on the previous cloud environment was reviewed and adjusted where required, including:

- VPN endpoint configuration
- Routing
- Firewall policies
- NAT behavior
- Connectivity between the VPN and internal networks

The complete traffic path was then validated instead of relying only on WireGuard tunnel status.

---

## Verification

The migration was considered successful only after all infrastructure layers were confirmed.

### VPN

- WireGuard service running
- Stable peer handshake
- Bidirectional tunnel traffic

### Network

- Correct routes installed
- Internal networks reachable
- Return routing working
- Firewall rules matching expected traffic
- NAT behavior validated

### Application

- Production services reachable through the new path
- Client connectivity operating normally

### Monitoring

- VPN state visible in monitoring
- Traffic metrics available
- Service monitoring healthy
- Notifications operating as expected

---

## Key Lessons

### A VPN handshake is not end-to-end validation

A valid WireGuard handshake confirms connectivity between VPN peers, but it does not prove that services behind those peers are reachable.

### Cloud migration affects more than the VM

Moving a gateway between cloud providers can affect:

- Public addressing
- Firewall behavior
- Routing assumptions
- NAT
- Monitoring
- Dependencies on the previous endpoint

### Always validate the return path

A valid forward route with an incorrect or missing return route can create confusing partial-connectivity symptoms.

### Troubleshoot in layers

A structured troubleshooting process reduces guesswork:

```text
Cloud Connectivity
        |
        v
WireGuard Handshake
        |
        v
Tunnel Routing
        |
        v
Firewall / NAT
        |
        v
Return Routing
        |
        v
Application
        |
        v
Monitoring
```

---

## Technologies

`Microsoft Azure` · `DigitalOcean` · `Linux` · `WireGuard` · `OPNsense` · `Routing` · `NAT` · `Firewall Policies` · `Infrastructure Monitoring`