# Debugger Helm Chart

This Helm chart deploys a debugging pod in a Kubernetes cluster. It's designed to help troubleshoot issues within your cluster by providing a container with common debugging tools.

## Description

The debugger chart creates a pod with tools useful for network diagnostics, log analysis, and general debugging of Kubernetes applications and infrastructure.

## Installation

To install the chart with the release name `debugger`:

```bash
helm install debugger ./charts/debugger
```

## Configuration

| Parameter | Description | Default |
|-----------|-------------|---------|
| `image.repository` | Image repository | `busybox` |
| `image.tag` | Image tag | `latest` |
| `image.pullPolicy` | Image pull policy | `IfNotPresent` |
| `resources` | Pod resource requests & limits | `{}` |
| `nodeSelector` | Node labels for pod assignment | `{}` |
| `tolerations` | Tolerations for pod assignment | `[]` |
| `affinity` | Affinity settings for pod assignment | `{}` |

## Usage

After deploying the debugger pod, you can exec into it to run diagnostic commands:

```bash
kubectl exec -it debugger-pod -- sh
```

## License

This Helm chart is available under the MIT license.