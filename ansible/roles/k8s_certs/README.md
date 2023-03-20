# k8s_certs

This role provisions a PKI infrastructure, bootstraps the Certificate Authority and generates TLS certificates for the following Kubernetes components:

- etcd
- kube-apiserver
- kube-controller-manager
- kube-scheduler
- kubelet
- kube-proxy

## Requirements

This role uses Cloudflare SSL toolkit (`cfssl` and `cfssljson`) and `netaddr` Python package. The role should be run on Ansible host (see example playbook).

## Role Variables

- `cfssl_config_dir`: path for CFSSL configuration files to be created in (default: `{{ playbook_dir }}/artifacts/cfssl-config`)
- `certs_output_dir`: path where TLS certificates will be saved (default: `{{ playbook_dir }}/artifacts/certs`)
- `cert_algo`: algorithm for TLS certificates (default: `rsa`)
- `cert_keysize`: key length for TLS certificates (default: `2048`)
- `cert_names_c`: sets 'Country (C)' field in certificate properties (default: `BY`)
- `cert_names_l`: sets 'Location (L)' field in certificate properties (default: `Minsk`)
- `cert_names_st`: sets 'State (ST)' field in certificate properties (default: `Minsk Capital`)
- `cert_names_ou`: sets 'Organizational Unit (OU)' field in certificate properties (default: `Kubernetes on Vagrant`)

### Variables that should be left unchanged

- `k8s_cluster_services_ip`: uses `k8s_cluster_services_network` group variable to obtain an IP address needed for Kubernetes cluster services
- `k8s_hostnames`: list of internal hostanames used by Kubernetes

## Example Playbook

```yaml
- hosts: localhost # This line is very importnant!
  roles:
    - role: k8s_certs
```

## License

CC-BY-4.0
