# A K8S troubleshooting pod
## Inception 
- Create a image and its build process which will include 
    - All required network troubleshooting tools
    - Few custom scripts embedded in the image to troubleshoot network issues
    - Some custom OpenShift SDN troubleshooting tools
    - Some network tracing tools

## Deploy
A single yaml file which deploys this in the current namespace context; using 
```
kubectl apply -f ./config/deploy.yaml
```
This should do the required configuration and bring the pod up.

Once done everthing can be cleaned up

```
kubectl delete -f ./config/deploy.yamls