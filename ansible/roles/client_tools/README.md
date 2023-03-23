# client_tools

Install client tools (cfssl, cfssljson and kubectl) needed for Kubernetes cluster.

## Requirements

This role should be run on Ansible host (see example playbook).

## Role Variables

- `cf_version` - sets version of Cloudflare SSL tools to be installed (default `1.6.3`)
- `kubectl_version` - sets version of `kubectl` to be installed (default `1.26.2`)
- `platform` - sets platform (`linux` or `darwin`)
- `arch` - sets architecture (`amd64` or `arm64`)

## Example Playbook

Install the tools on Linux amd64 machine

```yaml
- hosts: localhost
  roles:
    - role: client_tools
      cf_version: "1.6.3"
      kubectl_version: "1.26.2"
      platform: linux
      arch: amd64
```

## License

CC-BY 4.0
