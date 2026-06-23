# kube-ex

Infrastructure-as-Code and Kubernetes manifests for provisioning and experimenting with an Amazon EKS cluster.

## Overview

This project sets up an EKS cluster on AWS using Terraform and deploys workloads with Kustomize. It's geared toward testing node scaling, scheduling, and resource usage in an experimental (`exp`) environment.

## Structure

- **`terraform/`** — Provisions AWS infrastructure (EKS cluster, node groups, IAM roles, security groups, and EKS add-ons) via reusable modules and per-environment configs.
- **`k8s/`** — Kubernetes manifests managed with Kustomize, including a `base` layer and environment `overlays` (e.g. node-selector patches).

## Getting Started

### 1. Provision infrastructure

```bash
cd terraform/environments/exp
terraform init
terraform plan
terraform apply
```


### 2. Connect to the cluster

```shell script
aws eks update-kubeconfig --name <cluster-name> --region <region>
aws eks update-kubeconfig --name hey_cluster --region eu-west-1
kubectl get nodes
```


### 3. Deploy workloads

```shell script
kubectl apply -k k8s/overlays/exp
```


## Useful Commands

```shell script
# Inspect nodes and pods
kubectl get nodes
kubectl get pods -n dummy-load -w
kubectl describe node <node-name>

# Resource usage (requires metrics-server)
kubectl top node
kubectl top pods -n dummy-load

# Scale a deployment
kubectl scale deployment <name> --replicas=2 -n <namespace>
```