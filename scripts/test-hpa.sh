#!/bin/bash

set -u

GATEWAY_IP=$(kubectl get gateway devops-gateway \
  -n devops-project \
  -o jsonpath='{.status.addresses[0].value}')

URL="http://${GATEWAY_IP}/api/health"
WORKERS=50

echo "======================================"
echo "HPA Load Test"
echo "======================================"
echo "Target: $URL"
echo "Workers: $WORKERS"
echo "Press Ctrl+C to stop"
echo

cleanup() {
  echo
  echo "Stopping load..."
  jobs -p | xargs -r kill 2>/dev/null
  echo "Load stopped."
}

trap cleanup INT TERM EXIT

for i in $(seq 1 "$WORKERS"); do
  (
    while true; do
      curl -s -o /dev/null "$URL"
    done
  ) &
done

while true; do
  echo
  echo "------ $(date '+%H:%M:%S') ------"

  kubectl get hpa backend-hpa -n devops-project

  echo
  kubectl get pods -n devops-project -l app=backend

  sleep 10
done