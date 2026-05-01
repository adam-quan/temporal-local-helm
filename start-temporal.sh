#!/bin/bash
set -e

echo "==> Checking for Temporal Dev Server on port 7233..."
if lsof -i :7233 2>/dev/null | grep -q "temporal"; then
  echo "ERROR: Temporal Dev Server is running on port 7233."
  echo "       Stop it before running this script."
  exit 1
fi

echo "==> Starting minikube..."
if minikube status 2>/dev/null | grep -q "Running"; then
  echo "    Already running, skipping."
else
  minikube start --driver=docker
fi

echo "==> Waiting for Temporal frontend to be ready..."
kubectl rollout status deployment/temporal-frontend -n temporal --timeout=120s

echo "==> Clearing any stale port-forwards..."
pkill -f "kubectl port-forward services/temporal-frontend-headless" 2>/dev/null || true
pkill -f "kubectl port-forward services/temporal-web" 2>/dev/null || true
pkill -f "kubectl port-forward services/prometheus-kube-prometheus-prometheus" 2>/dev/null || true
pkill -f "kubectl port-forward deployment/prometheus-grafana" 2>/dev/null || true
sleep 1

echo "==> Starting port-forwards in background..."
kubectl port-forward services/temporal-frontend-headless 7233:7233 -n temporal > /dev/null 2>&1 &
kubectl port-forward services/temporal-web 8080:8080 -n temporal > /dev/null 2>&1 &
kubectl port-forward services/prometheus-kube-prometheus-prometheus 9090:9090 -n temporal > /dev/null 2>&1 &
kubectl port-forward deployment/prometheus-grafana 3000:3000 -n temporal > /dev/null 2>&1 &

echo ""
echo "Temporal cluster ready"
echo "  SDK / CLI : localhost:7233"
echo "  Web UI    : http://localhost:8080"
echo "  Prometheus : http://localhost:9090"
echo "  Grafana    : http://localhost:3000 (admin/...)"