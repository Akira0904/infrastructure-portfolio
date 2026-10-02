# Ansible Linux Baseline Automation

A practical Ansible project demonstrating remote Linux server configuration over SSH.

The automation was tested against an Ubuntu Server 22.04 virtual machine using a dedicated Ansible control node.

## Architecture

```text
Ansible Control Node
       |
       | SSH / ED25519 key
       |
       v
Ubuntu Target Server
```

## What This Project Demonstrates

- Ansible inventory management
- SSH key-based authentication
- Privilege escalation with `become`
- Ansible variables and `group_vars`
- Package management with the `apt` module
- Ansible facts
- Configuration file management
- Check mode
- Syntax validation
- Idempotent infrastructure automation

## Project Structure

```text
automation/ansible/
├── ansible.cfg
├── inventory/
│   ├── hosts.example.yml
│   └── group_vars/
│       └── all.yml
├── playbooks/
│   └── linux-baseline.yml
└── README.md
```

The real inventory file is intentionally excluded from Git because it contains environment-specific addressing.

## Inventory

Example sanitized inventory:

```yaml
all:
  children:
    linux_servers:
      hosts:
        ubuntu-target01:
          ansible_host: 192.0.2.10
          ansible_user: ansible
```

## Linux Baseline Playbook

The `linux-baseline.yml` playbook performs the following tasks:

- Updates the APT package cache
- Installs baseline administration packages
- Collects Linux system facts
- Creates an Ansible management marker
- Displays target operating system information

Baseline packages include:

- curl
- wget
- vim
- htop
- unzip
- ca-certificates
- net-tools

## Connectivity Test

Ansible connectivity can be verified with:

```bash
ansible all -m ping
```

Expected result:

```text
ubuntu-target01 | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

## Privilege Escalation Test

```bash
ansible all -b -m command -a "whoami" --ask-become-pass
```

Expected result:

```text
root
```

## Syntax Validation

Before running the playbook:

```bash
ansible-playbook playbooks/linux-baseline.yml --syntax-check
```

## Check Mode

Changes can be previewed using:

```bash
ansible-playbook playbooks/linux-baseline.yml --check --ask-become-pass
```

## Deployment

The playbook is executed with:

```bash
ansible-playbook playbooks/linux-baseline.yml --ask-become-pass
```

## Idempotency

The playbook was executed twice against the same Ubuntu target.

After the first run configured the system, the second run completed with:

```text
changed=0
unreachable=0
failed=0
```

This demonstrates idempotent behavior: Ansible detects that the target system is already in the desired state and does not apply unnecessary changes.

## Security Notes

- SSH key authentication is used between the control node and managed host.
- Private SSH keys are never stored in this repository.
- The real inventory is excluded from version control.
- Passwords and become credentials are not stored in configuration files.
- Public examples use documentation-only addressing.

## Next Steps

Planned extensions:

- node_exporter deployment
- systemd service management
- Nginx deployment
- Ansible roles
- handlers
- templates
- multiple managed hosts
