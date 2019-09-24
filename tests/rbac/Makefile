default:

test:
	kubectl create ns rbactesting || echo "Already Created"
	kubectl -n rbactesting apply -f ./rbac.k8s.yml

	## RoleBindings
	echo "Can Jane GET a list of pods in the rbactesting namespace?"
	kubectl --as jane auth can-i get pods --namespace=rbactesting
	echo "Can Jane GET a list of pods in the kube-system namespace?"
	kubectl --as jane auth can-i get pods --namespace=kube-system
	echo "Can Jane GET a list of deployments in the rbactesting namespace?"
	kubectl --as jane auth can-i get deployments --namespace=rbactesting

  ## ClusterRoleBindings
	echo "Can Jane GET a list of secrets in the rbactesting namespace?"
	kubectl --as jane auth can-i get secrets --namespace=rbactesting
	echo "Can Jane GET a list of secrets in all namespaces?"
	kubectl --as jane auth can-i get secrets --all-namespaces

clean:
	kubectl delete ns rbactesting
