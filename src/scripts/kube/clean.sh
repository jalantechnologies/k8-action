#!/bin/bash

# requires - KUBE_ROOT, KUBE_NS, KUBE_APP, KUBE_ENV

kube_shared_dir="$KUBE_ROOT/shared"
kube_env_dir="$KUBE_ROOT/$KUBE_ENV"

if [ -d "$kube_shared_dir" ]; then
    for file in "$kube_shared_dir"/*; do
        envsubst <"$file" | kubectl delete -f -
    done
fi

if [ -d "$kube_env_dir" ]; then
    for file in "$kube_env_dir"/*; do
        envsubst <"$file" | kubectl delete -f -
    done
fi
