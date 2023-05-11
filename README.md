# kata-kubernetes

A collection of Kubernetes manifests to deploy some samples/basic objects. This also include some custom [charts](./charts) and a ["baseline"](./cluster_baseline) of what I will run on new clusters to simplify any setups.

## Products to keep in mind

| Category of product | Name / URL | Description |
| ------------------- | ---- | ----------------- |
| DNS | [ExternalDNS](https://github.com/kubernetes-incubator/external-dns) | Configure external DNS servers (AWS Route53, Google CloudDNS and others) for Kubernetes Ingresses and Services |
| Operator Tools | [kubectx](https://github.com/ahmetb/kubectx) | Fast way to switch between clusters and namespaces in kubectl!  |
| Operator Tools | [kcn](https://github.com/marjamis/kubectl-kcn) | A tool to list nodes and simplifies having to ssh to them, especially in EKS. Self promotion WOOO!!! |
| Operator Tools | [krew](https://github.com/kubernetes-sigs/krew/) | Find and install kubectl plugins  |
| Operator Tools | [k9s](https://github.com/derailed/k9s) | Kubernetes CLI To Manage Your Clusters In Style!  |
