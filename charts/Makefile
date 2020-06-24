default:

index:
	helm repo index . --url https://marjamis.github.io/k8s_manifests/charts/

package:
	helm package $(create) 
	$(MAKE) index

packages:
	for i in $(shell ls -d ./*/); do helm package $$i; done 
	$(MAKE) index
