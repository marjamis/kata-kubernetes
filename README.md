# k8s_manifests
A collection of Kubernetes manifests to deploy some samples/basic objects. This also include some custom [charts](./charts) and a ["baseline"](./cluster_baseline) of what I will run on new clusters to simplify any setups.

## Products to keep in mind
| Category of product | Name | Description | URL |
| ------------------- | ---- | ----------------- | --- |
| Diagnostic | sonobuoy | Heptio Sonobuoy is a diagnostic tool that makes it easier to understand the state of a Kubernetes cluster by running a set of Kubernetes conformance tests in an accessible and non-destructive manner. | https://github.com/heptio/sonobuoy |
| Operator Tools | kubectx | Fast way to switch between clusters and namespaces in kubectl!  | https://github.com/ahmetb/kubectx |
| DNS | ExternalDNS | Configure external DNS servers (AWS Route53, Google CloudDNS and others) for Kubernetes Ingresses and Services | https://github.com/kubernetes-incubator/external-dns |
| Operator Tools | kcn | A tool to list nodes and simplifies having to ssh to them, especially in EKS. Self promotion WOOO!!! | https://github.com/marjamis/kubectl-kcn |
