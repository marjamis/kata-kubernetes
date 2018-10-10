default:
	echo "Please run a specific target as this first one will do nothing."


all: configure setup install


configure: configure_storage_classes

configure_storage_classes:
	kubectl apply -f ./storage-classes.k8s.yml


install: install_dashboard install_prometheus install_grafana install_heapster install_x-ray install_ingress install_misc

install_dashboard:
	kubectl apply -n kube-system -f https://raw.githubusercontent.com/kubernetes/dashboard/master/src/deploy/recommended/kubernetes-dashboard.yaml
	kubectl apply -n kube-system -f ./rbacconfigs/dashboard.rbac.yml
	read -p "Get the secret for the dashboard..."
	kubectl -n kube-system describe secret/$$(kubectl -n kube-system get secret --output=custom-columns=NAME:.metadata.name | grep --color=never eks-admin)
	read -p "Press enter when you're happy to move on."

install_prometheus:
	## https://github.com/kubernetes/charts/tree/master/stable/prometheus
	## TODO * configure alert manager to my slack channel WITHOUT putting creds into any config/makefile/ such as with a read in the makefile and passing that one in with --set
	## TODO * add custom alerts to my cluster_baseline for prom
	helm install stable/prometheus -n prometheus --namespace kube-system -f ./chartconfigs/prometheus.chartconfig.yml

install_grafana:
	## https://github.com/kubernetes/charts/tree/master/stable/grafana
	helm install stable/grafana -n grafana --namespace kube-system -f ./chartconfigs/grafana.chartconfig.yml

install_heapster:
	# For HPA(Horizontal Pod Autoscaler) but fix this to the new system TODO
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/heapster.yaml
	# Database to be used by heapster
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/influxdb/influxdb.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/heapster/master/deploy/kube-config/rbac/heapster-rbac.yaml

install_x-ray:
	helm install ../charts/x-ray -n x-ray --namespace x-ray --set image.image=$(shell read -p "Enter the image to be used for the daemon: " image && echo $$image) -f ./chartconfigs/x-ray.chartconfig.yml

install_ingress-nginx:
	# This will install a layer 4 ingress controller. Layer 7 is also possible with a different set of configurations.
	# Installation details: https://kubernetes.github.io/ingress-nginx/deploy/
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/mandatory.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/service-l4.yaml
	kubectl apply -f https://raw.githubusercontent.com/kubernetes/ingress-nginx/master/deploy/provider/aws/patch-configmap-l4.yaml
	# TODO Migrate to the helm chart after the bug where it doesn't like $escaped_request_uri is fixed
	# helm install stable/nginx-ingress -n ingress-nginx --namespace kube-system

# install_ingress-alb:
# 	helm registry install quay.io/coreos/alb-ingress-controller-helm

install_misc:
	kubectl apply -f ./cni_metrics.k8s.yml
	kubectl apply -f ./externaldns.k8s.yml


setup: setup_helm

setup_helm:
	read -p "Install helm locally as described here: https://docs.helm.sh/using_helm/#installing-helm Press enter when complete."
	kubectl apply -f ./rbacconfigs/helm.rbac.yml
	helm init --service-account tiller

flip_dns:
	# TODO make -e dns=<coredns|kube-dns> flip_dns
	if [ "$(dns)" == "coredns" ] ; then \
		echo "setting to coredns - https://github.com/coredns/deployment/tree/master/kubernetes" \
	elif [ "$(dns)" == "kube-dns" ] ; then \
		echo "setting to kube-dns" \
	else \
		echo "no changes to dns" \
	fi
