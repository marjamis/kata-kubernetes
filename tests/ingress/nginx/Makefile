default:
	echo "Please run a specific target as this first one will do nothing."

install:
	# This will install a layer 4 ingress controller. Layer 7 is also possible with a different set of configurations.
	# Installation details: https://kubernetes.github.io/ingress-nginx/deploy/
	kubectl apply \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/service-l4.yaml \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/patch-configmap-l4.yaml
	# Note: Migrate to the helm chart after the bug where it doesn't like $escaped_request_uri is fixed
	# helm install stable/nginx-ingress -n ingress-nginx --namespace kube-system

test:
	kubectl apply -f ./basic_test.yml

cleantest:
	kubectl delete -f ./basic_test.yml

clean: cleantest
	kubectl delete \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/service-l4.yaml \
	  -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/patch-configmap-l4.yaml
