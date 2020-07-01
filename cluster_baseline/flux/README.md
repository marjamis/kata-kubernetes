# flux

## To manually install flux with existing repository and path, as readonly

```bash
helm upgrade -i flux \
--set helmOperator.create=true \
--set helmOperator.createCRD=true \
--set git.url=git@github.com:marjamis/k8s_manifests \
--set git.path=cluster_baseline/flux \
--set git.readonly=true \
--namespace fluxcd \
fluxcd/flux
```
