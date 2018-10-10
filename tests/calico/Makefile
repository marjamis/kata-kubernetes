default:

star: star_setup star_walkthrough

star_setup:
	# Expected to be run on an EKS Cluster
	kubectl apply -f https://raw.githubusercontent.com/aws/amazon-vpc-cni-k8s/v1.0.0/config/v1.0/aws-k8s-cni-calico.yaml
	kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/manifests/00-namespace.yaml
	kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/manifests/01-management-ui.yaml
	kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/manifests/02-backend.yaml
	kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/manifests/03-frontend.yaml
	kubectl apply -f https://docs.projectcalico.org/v3.1/getting-started/kubernetes/tutorials/stars-policy/manifests/04-client.yaml
	sleep 30
	kubectl port-forward service/management-ui -n management-ui 9001

star_walkthrough:
	kubectl apply -n stars -f ./stars_policies/default-deny.yaml
	kubectl apply -n client -f ./stars_policies/default-deny.yaml
	read -p "When you've seen everything blocked via UI press enter."
	kubectl apply -f ./stars_policies/allow-ui.yaml
	kubectl apply -f ./stars_policies/allow-ui-client.yaml
	read -p "When you've seen the UI allowed press enter."
	kubectl apply -f ./stars_policies/backend-policy.yaml
	read -p "When you've seen frontend allowed via UI press enter."
	kubectl apply -f ./stars_policies/frontend-policy.yaml
	read -p "When you're ready to delete everything press enter."
	kubectl delete ns client stars management-ui
