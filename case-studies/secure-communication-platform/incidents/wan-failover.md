# Incident Case Study: Multi-WAN Failover

## Scenario

A firewall/router used a preferred WAN path with a secondary WAN for failover. A controlled link-failure test initially did not produce the expected traffic transition.

## Investigation

Validation included gateway status, monitoring targets, active routes, policy routing, firewall gateway selection, state behavior, physical interface state and notification logic.

## Test Procedure

1. Confirm normal operation on the primary WAN
2. Record active gateway and service reachability
3. Disconnect or disable the primary path
4. Observe gateway state
5. Verify route transition
6. Verify external service reachability
7. Verify notification delivery
8. Restore the primary WAN
9. Validate failback
10. Confirm recovery notification

## Key Lesson

Failover should be validated by **actual traffic behavior**, not only by a dashboard status indicator.
