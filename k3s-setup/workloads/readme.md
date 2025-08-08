

```bash
# test-deployment.yaml
# cd to yaml path 
kubectl apply -f test-deployment.yaml 
# service created 
# deployment 
kubectl get service 
kubectl get pod 
kubectl logs pod-name

kubectl port-forward service/reactjs-earthdx-service 8080:80
```