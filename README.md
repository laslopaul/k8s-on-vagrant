# Kubernetes on Vagrant

## Description

Create Kubernetes cluster from scratch on Vagrant virtual machines using Ansible.

Inspired by [Kubernetes The Hard Way](https://github.com/kelseyhightower/kubernetes-the-hard-way).

## Work Plan

1. Build a custom Ubuntu image with Packer and use it to create 4 Vagrant machines.
2. Write Ansible playbook to create Kubernetes cluster from scratch on these machines.
3. Deploy Grafana and Prometheus to the cluster.
4. Deploy [Azure Voting App](https://github.com/Azure-Samples/azure-voting-app-redis) to the cluster.
