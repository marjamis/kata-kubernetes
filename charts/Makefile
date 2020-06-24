default:

package:
	helm package $(create) && helm repo index .

packages:
	for i in $(shell ls -d ./*/); do helm package $$i; done && helm repo index .
