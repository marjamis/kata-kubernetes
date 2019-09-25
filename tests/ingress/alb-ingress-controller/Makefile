default:
	echo "Please run a specific target as this first one will do nothing."

install:
	# https://docs.aws.amazon.com/eks/latest/userguide/alb-ingress.html
	# Ensure permissions are available to the Pods
	kubectl apply \
	  -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/rbac-role.yaml \
		-f <(curl -L https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/alb-ingress-controller.yaml | sed "s:# - --cluster-name=devCluster:- --cluster-name=general-1dot14:g")

test:
	kubectl apply -f ./example.k8s.yml

cleantest:
	kubectl delete -f ./example.k8s.yml

clean: cleantest
	kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/alb-ingress-controller.yaml  \
	-f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/rbac-role.yaml
	kubectl delete -f ./example.k8s.yml
