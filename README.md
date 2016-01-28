# vagrant_k8

The purpose of this repo is to create a vagrant file that creates a working
kubernetes cluster using docker with an overlay network backed by consul.

## Bringing up the cluster

You must successfully bring up the controller server first

```vagrant up controller```

Once that is done you can bring up the worker servers

```vagrant up /workers*/```
