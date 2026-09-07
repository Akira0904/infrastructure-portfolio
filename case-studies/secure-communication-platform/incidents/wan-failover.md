# Incident Case Study: Multi-WAN Failover

## Overview

A production firewall/router was configured with two Internet uplinks:

- Primary WAN — preferred path
- Secondary WAN — backup path

The objective was to keep critical services available during an upstream connectivity failure and automatically return traffic to the preferred WAN after recovery.

This case study is sanitized and contains no real addresses, provider information or internal identifiers.

## Problem

During a controlled failover test, the primary WAN connection was physically disconnected.

The expected behavior was:

1. Primary gateway becomes unavailable
2. Secondary WAN becomes active
3. Production traffic continues through the backup path
4. Monitoring generates a failover notification
5. Primary WAN is restored
6. Traffic automatically returns to the preferred path
7. Recovery notification is generated

During the initial test, loss of the primary physical connection did not immediately result in the expected traffic transition.

## Symptoms

Observed behavior included:

- Primary WAN physical connectivity was lost
- Expected automatic failover did not initially occur
- Service traffic did not immediately follow the backup route
- Gateway and monitoring state required additional validation
- Notification behavior also needed to be verified

## Investigation

The troubleshooting process focused on the complete forwarding path rather than only the physical interface state.

The following areas were checked:

### Gateway Monitoring

- Primary gateway state
- Secondary gateway state
- Monitoring targets
- Gateway priority
- Failover group behavior

### Routing

- Active default route
- Policy routing
- Gateway selection on firewall rules
- Expected backup path

### Firewall State

- Existing connection states
- Rule matching
- Gateway assignment
- Traffic behavior after link failure

### Monitoring and Notifications

- WAN state detection
- Failover monitoring logic
- Alert generation
- Recovery notification behavior

## Troubleshooting Method

The failover path was validated using a controlled test:

1. Confirm normal traffic flow through the primary WAN
2. Verify both gateway states
3. Record application/service reachability
4. Physically disconnect the primary WAN
5. Observe gateway state transition
6. Verify the active route
7. Generate external traffic
8. Confirm traffic is using the secondary WAN
9. Verify service availability
10. Confirm failover notification delivery
11. Restore the primary WAN
12. Verify gateway recovery
13. Confirm traffic returns to the preferred path
14. Verify recovery notification delivery

## Resolution

Gateway monitoring, routing behavior and failover-related configuration were reviewed and corrected until the firewall consistently selected the secondary WAN when the preferred path became unavailable.

The monitoring and notification logic was also validated so that WAN transitions generated the expected operational alerts.

## Verification

The final validation included both failure and recovery scenarios.

### Primary WAN Failure

- Primary WAN detected as unavailable
- Backup WAN became the active path
- Production traffic remained reachable
- Monitoring reflected the WAN transition
- Failover notification was successfully delivered

### Primary WAN Recovery

- Primary gateway returned to healthy state
- Preferred routing was restored
- Traffic returned to the primary WAN
- Recovery notification was successfully delivered

## Key Lessons

### Link state is not enough

A disconnected interface does not by itself prove that application traffic has successfully moved to another path.

### Test actual traffic

Failover validation must include real service or external traffic.

### Validate the return path

Successful outbound routing is only part of the test. Return traffic and existing connection states can also affect service availability.

### Monitoring is part of the solution

A failover mechanism is significantly more useful when operators are immediately informed that the active network path has changed.

## Technologies

- OPNsense
- Multi-WAN
- Gateway monitoring
- Policy routing
- Firewall rules
- NAT
- Linux
- WireGuard
- Infrastructure monitoring
- Automated notifications