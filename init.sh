#!/bin/bash

k3d cluster delete fran
# Flagger does not support traefik
k3d cluster create fran

helm repo add fluxcd https://charts.fluxcd.io

kubectl create ns flux

# Working without helm releases
fluxctl install \
  --namespace flux \
  --git-url "git@github.com:franroa/gitops-skaffold.git" \
  --git-user franroa \
  --git-email "franroa@users.noreply.github.com" | kubectl apply -f -

# TODO -> Sign commits with GPG

kubectl apply -f https://raw.githubusercontent.com/fluxcd/helm-operator/1.2.0/deploy/crds.yaml

helm repo add fluxcd https://charts.fluxcd.io

helm install helm-operator fluxcd/helm-operator \
    -n flux \
    --set helm.versions=v3 \
    --set git.ssh.secretName=flux-git-deploy

# TODO -> helm repo vs git repo


fluxctl identity --k8s-fwd-ns flux







#curl -s 172.22.0.2.nip.io | grep Version
#cat <<EOF >> helm/nginxhello-hr.yaml
#  values:
#    image:
#      tag: 1.19.1
#    ingress:
#      host: 172.22.0.2.nip.io
#EOF

#while true; do curl -s -o /dev/null http://172.22.0.2.nip.io; done &
