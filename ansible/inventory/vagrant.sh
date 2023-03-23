#!/bin/bash
# Vagrant inventory script for Ansible
# Requires jq for JSON output


get_host_details() {
    VAGRANT_SSH_CONFIG=$(vagrant ssh-config $1)
    ANSIBLE_HOST=$(echo $VAGRANT_SSH_CONFIG | grep -Eo "HostName.+$" | cut -f2 -d' ')
    ANSIBLE_PORT=$(echo $VAGRANT_SSH_CONFIG | grep -Eo "Port.+$" | cut -f2 -d' ')
    ANSIBLE_USER=$(echo $VAGRANT_SSH_CONFIG | grep -Eo "User.+$" | cut -f2 -d' ')
    ANSIBLE_PRIVATE_KEY=$(echo $VAGRANT_SSH_CONFIG | grep -Eo "IdentityFile.+$" | cut -f2 -d' ')

    jq -n \
        --arg ansible_host "$ANSIBLE_HOST" \
        --arg ansible_port "$ANSIBLE_PORT" \
        --arg ansible_user "$ANSIBLE_USER" \
        --arg ansible_private_key_file "$ANSIBLE_PRIVATE_KEY" '$ARGS.named'
}

list_hosts() {
    CONTROL_PLANE=$(
        vagrant status --machine-readable |
        grep "controller.*,state,running" | cut -f2 -d, |
        jq -Rsc 'split("\n") | del(.[-1])'
    )
    
    WORKERS=$(
        vagrant status --machine-readable | 
        grep "worker.*,state,running" | cut -f2 -d, |
        jq -Rsc 'split("\n") | del(.[-1])'
    )

    printf '{ "control_plane": { "hosts": %s }, "workers": { "hosts": %s } }' "$CONTROL_PLANE" "$WORKERS" | jq

}


case $1 in 

  --host)
    get_host_details $2
    ;;
  --list) 
    list_hosts
    ;;
  *)
    echo "Usage: $0 --list | --host <hostname>"
    exit 1
    ;;
    
esac
