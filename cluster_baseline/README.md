# cluster_baseline

A collection of manifests/charts/etc that will create a good starting point for a variety of tasks. Such as:
> Monitoring of the cluster, which will try to follow best practices within k8s.
> Using Deployments and Services in the one config for easy deployment.

This will also be modular for individual use or in-conjunction with each other, where it makes sense.

A [Makefile](./Makefile) is provided with several targets to make deploying all configurations, at once or independently, easier. This has the added benefit of being able to have comments as to what is occurring and why.

To deploy everything you can run:
```bash
make all
```
