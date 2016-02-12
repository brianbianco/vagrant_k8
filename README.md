# vagrant_k8

The purpose of this repo is to create a vagrant file that creates a working
kubernetes cluster.

## Bringing up the cluster

First bring up the controller.

```vagrant up controller```

Once that is done you can bring up the worker servers

```vagrant up /workers*/```

## Running the example service

First load up the replication controller

```kubectl create -f kube_examples/nginx-rc.yaml```

Go ahead and create a kubernetes service for your pods and replication controller

```kubectl create -f kube_examples/nginx-service.yaml```

## Viewing information about your pods, services and controllers

```kubectl get pods```
```kubectl get svc```
```kubectl get rc```

