#!/bin/bash

# requires - KUBE_NS, KUBE_APP

kubectl -n "$KUBE_NS" delete ingresses,services,deployments -l app="$KUBE_APP"
kubectl -n "$KUBE_NS" delete secret $KUBE_APP-env-vars || true
