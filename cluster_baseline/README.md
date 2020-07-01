# cluster_baseline

A collection of manifests/charts/etc that will create a good starting point for a variety of tasks. Such as:
> Monitoring of the cluster, which will try to follow best practices within k8s.
> Using Deployments and Services in the one config for easy deployment.

This will also be modular for individual use or in-conjunction with each other, where it makes sense.

**Note:** Some steps maybe rough duplicates of functionality built into cluster creators/providers, such as the AWS EKS, and therefore are probably better served being configured via that mechanism but will remain here for testing implementations.
