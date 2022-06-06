#!/bin/bash

# requires - KUBE_NS, KUBE_APP, KUBE_ENV

kube_shared_dir="lib/kube/shared"
kube_env_dir="lib/kube/$KUBE_ENV"

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
