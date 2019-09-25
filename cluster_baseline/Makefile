default:
	echo "Please run a specific target as this first one will do nothing."

all: configure setup install


configure: configure_storage_classes

configure_storage_classes:
	kubectl apply -f ./misc/storage-classes.k8s.yml


install: install_dashboard install_prometheus install_grafana install_metricsserver install_x-ray install_misc

install_dashboard:
	kubectl apply -n kube-system -f https://raw.githubusercontent.com/kubernetes/dashboard/v1.10.1/src/deploy/recommended/kubernetes-dashboard.yaml
	kubectl apply -n kube-system -f ./rbacconfigs/dashboard.rbac.yml
	read -p "Get the secret for the dashboard..." blank
	kubectl -n kube-system describe secret/$$(kubectl -n kube-system get secret --output=custom-columns=NAME:.metadata.name | grep --color=never eks-admin)
	read -p "Press enter when you're happy to move on." blank

install_prometheus:
	## https://github.com/kubernetes/charts/tree/master/stable/prometheus
	helm install stable/prometheus -n prometheus --namespace kube-system -f ./configs/chartconfigs/prometheus.chartconfig.yml
	kubectl apply -f ./configs/alertmanager.yml

install_grafana:
	## https://github.com/kubernetes/charts/tree/master/stable/grafana
	helm install stable/grafana -n grafana --namespace kube-system -f ./configs/chartconfigs/grafana.chartconfig.yml
	kubectl apply -f ./configs/grafana_dashboards

install_metricsserver:
	kubectl apply -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/resource-reader.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-server-service.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-server-deployment.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/metrics-apiservice.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/auth-reader.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/auth-delegator.yaml -f https://raw.githubusercontent.com/kubernetes-incubator/metrics-server/master/deploy/1.8%2B/aggregated-metrics-reader.yaml

install_x-ray:
	helm install ../charts/x-ray -n x-ray --namespace x-ray --set image.image=$(shell read -p "Enter the image to be used for the daemon: " image && echo $$image) -f ./configs/chartconfigs/x-ray.chartconfig.yml

install_misc:
	kubectl apply -f ./misc/cni_metrics.k8s.yml
	kubectl apply -f ./misc/externaldns.k8s.yml

setup: setup_helm

setup_helm:
	read -p "Install helm locally as described here: https://docs.helm.sh/using_helm/#installing-helm Press enter when complete." blank
	kubectl apply -f ./rbacconfigs/helm.rbac.yml
	helm init --service-account tiller
