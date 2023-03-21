# fw_rules

This role installs `iptables-persistent` package and sets up the following firewall rules for Kubernetes instances:

- Set default IPv4 INPUT policy to DROP and block IPv6 access
- Allow incoming TCP, UDP and ICMP connections from Kubernetes instances network and Kubernetes pod CIDR range
- Allow incoming SSH connections from Virtualbox host
- Allow incoming ICMP and HTTPS connections (port 6443) from external addresses

## Role Variables

The role uses group variables `k8s_instances_network` and `k8s_pod_cidr_range` to generate a set of firewall rules.

## Example Playbook

```yaml
- hosts: all
  become: true
  roles:
    - role: fw_rules
```

## License

CC-BY-4.0
