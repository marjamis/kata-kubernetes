# cluster_setup

The separate directories within cluster_setup demonstrate how to create Kubernetes clusters in a variety of different ways and configurations and while these aren't production ready methodologies to create a custom cluster they can be adapted to be made into a more automated fashion.

Even though there are Makefile's this is meant to be an outline the process of how it works with manual step rather than anything automated. At least for now.

Types of cluster setups:
* [kubeadm - Single Master](./singlemaster/)
* [eksctl](./eksctl/)
* [minikube](./minikube/)
