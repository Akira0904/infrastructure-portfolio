# Incident Case Study: Cloud VPN Gateway Migration

## Overview

A cloud-hosted WireGuard gateway used to provide secure connectivity between external/cloud infrastructure and an internal production environment was migrated from Microsoft Azure to DigitalOcean.

The goal was to move the VPN entry point to the new cloud provider while preserving application connectivity, routing behavior, firewall policies and operational monitoring.

This case study is sanitized. Public IP addresses, domains, internal networks, credentials and organizational identifiers are intentionally omitted or replaced.

---

## Environment

The simplified traffic path was:

```text
External Clients / Services
          |
          v
   Cloud VPN Gateway
          |
     WireGuard Tunnel
          |
          v
   OPNsense Firewall
          |
     Internal Services

Technologies
Microsoft Azure
DigitalOcean
Linux
WireGuard
OPNsense
Routing
NAT
Firewall policies
Infrastructure monitoring

Problem

After migrating the cloud-side VPN gateway to the new provider, end-to-end connectivity had to be restored and validated across the complete path.

During troubleshooting, it became clear that a successful WireGuard handshake alone was not sufficient to confirm that production traffic was working correctly.

The migration affected several infrastructure layers:

VPN endpoint configuration
Public endpoint dependencies
Firewall rules
Routing
NAT
Return paths
Application connectivity
Monitoring and notification logic

Symptoms

During different stages of the migration, the following behavior was investigated:

WireGuard handshake initially unavailable or inconsistent
VPN tunnel later showing a valid handshake while routed traffic still required verification
Internal services not reachable through the expected path
Differences between the previous and new cloud networking environments
Firewall and routing configuration requiring validation after the public endpoint changed
Monitoring behavior requiring post-migration verification
Investigation

The migration was troubleshot layer by layer.

1. Cloud Gateway

The following components were verified:

Linux network interfaces
Public connectivity
WireGuard service state
UDP listener
Cloud firewall rules
Local Linux firewall rules

Example commands:

ip addr
ip route
ss -lunp
systemctl status wg-quick@wg0
wg show
2. WireGuard Tunnel

The following parameters were checked:

Peer public keys
Endpoint configuration
AllowedIPs
Latest handshake
Transmitted and received traffic
Tunnel interface addressing

Example commands:

wg show
ip addr show wg0

A successful handshake was treated only as confirmation that the WireGuard peers could communicate.

It was not considered proof that application traffic was correctly routed.

3. Routing

Routing was validated on both sides of the tunnel.

Example commands:

ip route
ip route get <destination>

The following questions were checked:

Is the destination network routed through WireGuard?
Is the correct gateway selected?
Is policy routing involved?
Does the remote side have a valid return route?
Does any route still depend on the previous cloud environment?
4. Firewall and NAT

The following areas were reviewed:

Cloud firewall rules
Linux firewall configuration
OPNsense firewall rules
NAT behavior
Forwarding between VPN and internal networks
Connection states

The troubleshooting process separated the problem into three stages:

Can the packet reach the VPN gateway?
            |
            v
Can the packet cross the WireGuard tunnel?
            |
            v
Can the packet reach the internal service and return?

This helped distinguish tunnel problems from routing, firewall and return-path issues.

5. Application Connectivity

After the network path was validated, application services were tested independently.

This prevented application-layer failures from being incorrectly attributed to WireGuard.

Validation included:

Service reachability
Client connectivity
Reverse proxy access
Required TCP/UDP service paths
6. Monitoring

Post-migration checks included:

WireGuard tunnel status
Handshake freshness
Tunnel traffic
Service availability
Monitoring target state
Alert delivery
Operational notifications
Resolution

The cloud VPN endpoint was successfully migrated to DigitalOcean and the infrastructure configuration was updated for the new environment.

Endpoint-dependent configuration, firewall behavior and routing paths were reviewed and adjusted where required.

The complete end-to-end traffic path was then validated instead of relying only on WireGuard tunnel status.

Verification

The migration was considered successful only after all of the following were confirmed.

VPN
WireGuard service running
Stable peer handshake
Bidirectional tunnel traffic
Network
Correct routes installed
Internal networks reachable
Return routing working
Firewall rules matching expected traffic
NAT behavior validated
Application
Production services reachable through the new path
Client connectivity operating normally
Monitoring
VPN state visible in monitoring
Traffic metrics available
Service monitoring healthy
Notifications operating as expected
Key Lessons
A VPN handshake is not end-to-end validation

A valid WireGuard handshake confirms connectivity between VPN peers, but it does not prove that traffic can reach services behind those peers.

Cloud migration affects more than the virtual machine

Moving a gateway between cloud providers can affect:

Public addressing
Firewall behavior
Routing assumptions
NAT
Monitoring
Dependencies on the previous endpoint
Validate the return path

A working forward route with an incorrect or missing return route can create confusing partial-connectivity symptoms.

Troubleshoot in layers

A structured troubleshooting sequence reduces guesswork:

Cloud connectivity
       |
       v
WireGuard handshake
       |
       v
Tunnel routing
       |
       v
Firewall / NAT
       |
       v
Return routing
       |
       v
Application
       |
       v
Monitoring
Technologies
Microsoft Azure
DigitalOcean
Linux
WireGuard
OPNsense
Routing
NAT
Firewall policies
Infrastructure monitoring