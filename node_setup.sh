#!/usr/bin/env bash
set -eu

hostnamectl set-hostname host${NODE_NUMBER}
kubeadm join --discovery-token-unsafe-skip-ca-verification --token ${CLUSTER_TOKEN} ${MASTER_ADDRESS}:8001