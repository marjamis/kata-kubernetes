default:

setup:
	# TODO make this runnable via the Makefile
	kubectl apply -f <(curl -L https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/alb-ingress-controller.yaml | sed "s:--cluster-name=devCluster:--cluster-name=eks:g") -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/rbac-role.yaml
  kubectl apply -f ./example.k8s.yml

clean:
	kubectl delete -f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/alb-ingress-controller.yaml  \
	-f https://raw.githubusercontent.com/kubernetes-sigs/aws-alb-ingress-controller/master/docs/examples/rbac-role.yaml
	kubectl delete -f ./example.k8s.yml
