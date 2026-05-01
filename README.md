# Temporal OSS — Local Install (Helm + minikube + PostgreSQL)

A step-by-step guide and scripts for running a local Temporal OSS cluster using Helm charts, minikube, and PostgreSQL. Built as a practical reference for understanding the self-hosted Temporal installation experience.

## What's included

| File | Purpose |
|------|---------|
| `install-notes.md` | Full installation guide — prerequisites, PostgreSQL setup, Temporal helm install, Promethus & Grafana install, and connecting your local machine to the cluster |
| `values.postgresql.yaml` | Helm values file configured for PostgreSQL persistence and visibility stores |
| `servicemonitor.yaml` | ServiceMonitor deployment to scrape Temporal service metrics |
| `start-temporal.sh` | Starts minikube and all port-forwards in one command |
| `stop-temporal.sh` | Stops port-forwards and minikube cleanly |

## Stack

- **macOS** with Docker
- **minikube** — local Kubernetes cluster using the Docker driver
- **PostgreSQL** — deployed in-cluster via Bitnami Helm chart, used for both persistence and visibility stores
- **Temporal** — installed via the [temporalio/helm-charts](https://github.com/temporalio/helm-charts) Helm chart
- **Prometheus & Grafana** - installed via the [prometheus-community](https://prometheus-community.github.io/helm-charts) Helm chart

## Prerequisites

- Docker (running)
- `kubectl`, `helm`, and `minikube` installed via Homebrew
- See `install-notes.md` Phase 1 for setup details

## Quick Start

Once the initial install is complete:

```bash
./start-temporal.sh   # bring the cluster up
./stop-temporal.sh    # bring it down
```

| Endpoint | Address |
|----------|---------|
| Web UI | http://localhost:8080 |
| SDK / CLI | localhost:7233 |
| Promethus | http://localhost:9090 |
| Grafana | http://localhost:3000 |

## First Time Setup

Follow `install-notes.md` in order. It covers:

1. Installing prerequisites (kubectl, helm, minikube)
2. Starting a local Kubernetes cluster
3. Deploying PostgreSQL into the cluster
4. Installing Temporal via Helm
5. Installing Promethus and Grafana
6. Connecting your local machine to the cluster

The guide intentionally stops short of reproducing what is already in the [Temporal helm chart README](https://github.com/temporalio/helm-charts/tree/main) — it focuses on the preparation steps and the non-obvious details that aren't covered there.
