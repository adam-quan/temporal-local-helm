#!/bin/bash

echo "==> Stopping port-forwards..."
pkill -f "kubectl port-forward services/temporal-frontend-headless" 2>/dev/null || true
pkill -f "kubectl port-forward services/temporal-web" 2>/dev/null || true

echo "==> Stopping minikube..."
minikube stop

echo ""
echo "Temporal cluster stopped. Your data is preserved for next start."
