default:

all:
	kubectl apply -f https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml \
    -f ./ambassador-fe.k8s.yml \
    -f ./sample_app.k8s.yml

clean:
	kubectl delete -f https://www.getambassador.io/yaml/ambassador/ambassador-rbac.yaml \
    -f ./ambassador-fe.k8s.yml \
    -f ./sample_app.k8s.yml
