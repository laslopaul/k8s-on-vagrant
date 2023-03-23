# k8s_config_files

This role creates the following Kubernetes configuration files:

1.  Client authentication configs (`kubelet`, `kube-proxy`, `kube-controller-manager`, `kube-scheduler` and `kube-admin`)
2.  Kubernetes encryption config & encryption key

## Requirements

This role requires `kubectl` to be installed on Ansible host and shall be run on Ansible host itself.

## Role Variables

The role uses the following group variables:

- `k8s_cluster_name`
- `k8s_public_ip`
- `k8s_certs_dir`

## Example Playbook

```yaml
- name: Create Kubernetes config files
  hosts: localhost
  roles:
    - role: k8s_config_files
```

## License

CC-BY-4.0
