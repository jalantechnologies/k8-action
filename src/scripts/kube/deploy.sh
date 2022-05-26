#!/bin/bash

# requires - kubectl, doppler
# requires - KUBE_NS, KUBE_APP, KUBE_ENV, KUBE_DEPLOYMENT_IMAGE, KUBE_INGRESS_HOSTNAME
# requires - DOPPLER_TOKEN, DOPPLER_PROJECT, DOPPLER_CONFIG

echo "deploying to k8"
echo "kube namespace - $KUBE_NS"
echo "kube app - $KUBE_APP"
echo "kube env - $KUBE_ENV"
echo "kube deployment image - $KUBE_DEPLOYMENT_IMAGE"
echo "kube ingress hostname - $KUBE_INGRESS_HOSTNAME"

# setup kube namespace for the preview app
kubectl get namespace $KUBE_NS || kubectl create namespace $KUBE_NS

# create secrets which will be consumed by the deployment using environment variables
kubectl -n $KUBE_NS delete secret $KUBE_APP-env-vars || true
kubectl -n $KUBE_NS create secret generic $KUBE_APP-env-vars --from-env-file <(doppler secrets download --no-file --format docker --project $DOPPLER_PROJECT --config $DOPPLER_CONFIG)

envsubst <lib/kube/$KUBE_ENV/deployment.yaml | kubectl -n "$KUBE_NS" apply -f -
envsubst <lib/kube/$KUBE_ENV/service.yaml | kubectl -n "$KUBE_NS" apply -f -
envsubst <lib/kube/$KUBE_ENV/ingress.yaml | kubectl -n "$KUBE_NS" apply -f -

echo "deployed to - https://$KUBE_INGRESS_HOSTNAME"
