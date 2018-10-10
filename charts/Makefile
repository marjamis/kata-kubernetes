default:

package:
	helm package $(create)

packages:
	for i in $(shell ls -d ./*/); do helm package $$i; done
