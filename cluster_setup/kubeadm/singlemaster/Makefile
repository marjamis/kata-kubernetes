export KUBECONFIG=/etc/kubernetes/admin.conf
export PATH=$PATH:/opt/bin/

default:

# move Initialising to master only?
prereqs:
		# Using a AML2 instance
		yum update -y && yum install -y docker && systemctl start docker && systemctl enable docker

    # Installing kubeadm
		read -p "Refer to https://kubernetes.io/docs/setup/independent/install-kubeadm/ for installing kubeadm using Container Linux details"

		# Initialising the AWS IAM Authenticator
		mkdir local_keys /var/aws-iam-authenticator/ /etc/kubernetes/aws-iam-authenticator/
		aws ecr get-login --registry 894847497797 --region us-west-2 --no-include-email | bash
		docker run -it --rm -v $PWD/local_keys:/tmp/ -w /tmp --user root 894847497797.dkr.ecr.us-west-2.amazonaws.com/aws-iam-authenticator:0.4.0-alpha.1-alpine-3.7 init -i kc
		mv local_keys/*.pem  /var/aws-iam-authenticator/
		mv local_keys/aws-iam-authenticator.kubeconfig  /etc/kubernetes/aws-iam-authenticator/kubeconfig.yaml

master: prereqs
	# kubeadm - This will be with calico hence specifying the --pod-network-cidr
	/opt/bin/kubeadm init --pod-network-cidr=192.168.0.0/16 && chmod 755 /etc/kubernetes/admin.conf

  # This is definitely hacky but until I have a good simple way to do this this will do
	sed -i '/- kube-apiserver/ a\    - --authentication-token-webhook-config-file=/etc/kubernetes/aws-iam-authenticator/kubeconfig.yaml' /etc/kubernetes/manifests/kube-apiserver.yaml
	sed -i '/volumeMounts:/ a\    - mountPath: /etc/kubernetes/aws-iam-authenticator/\n      name: certs\n      readOnly: true' /etc/kubernetes/manifests/kube-apiserver.yaml
	sed -i '/volumes:/ a\  - hostPath:\n      path: /etc/kubernetes/aws-iam-authenticator\n      type: Directory\n    name: certs' /etc/kubernetes/manifests/kube-apiserver.yaml

  # Cloud Controller Manager for AWS Setup
	# TODO check if this should be set elsewhere or just kube-controller-manager
	# TODO make idompotent?
	# This is definitely hacky but until I have a good simple way to do this this will do
	# add link to the docs/code for this
	mkdir -p /opt/kubernetes/aws.config
	printf "[Global]\nVPC={{VPC_Id}}\nKubernetesClusterID={{ClusterId}}" > /opt/kubernetes/aws.config
	sed -i '/- kube-controller-manager/ a\    - --cloud-provider=aws\n    - --cloud-config=/opt/kubernetes/aws.config' /etc/kubernetes/manifests/kube-controller-manager.yaml
	sed '/volumeMounts:/ a\    - mountPath: /opt/kubernetes/aws.config/\n      name: aws\n      readOnly: true' /etc/kubernetes/manifests/kube-controller-manager.yaml
	sed '/volumes:/ a\  - hostPath:\n      path: /opt/kubernetes/aws.config\n      type: File\n    name: aws' /etc/kubernetes/manifests/kube-controller-manager.yaml

  # Tag the Instances, VPC's, Routes, Subnets as required TODO automate this as well

  # Start the kubelet to start the kublet and the static? manifests
  systemctl start kubelet && systemctl enable kubelet
	kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/aws-iam-authenticator/master/example.yaml

	# Installing calico requirements that have worked for me though need to dig a bit into
	kubectl apply -f https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/etcd.yaml -f https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/rbac.yaml -f https://docs.projectcalico.org/v3.2/getting-started/kubernetes/installation/hosted/calico.yaml
  kubectl get pods --all-namespaces -w
	kubectl get nodes
	kubectl get componentstatuses

  # Issues with IAM authenticator for this
  # As this is a test environment remove the master label from the master nodes to allow it to be a back-end for an LB
	# kubectl label no --all node-role.kubernetes.io/master-

	# Note: certification authentication will override the iam authenticator in the server authentication

nodes: prereqs
	# Setup tmux over the number of nodes you want and have the inputs cloned to run once against each node
	# migrate to eks optimised ami
  # kubeadm join ...
	# kubeadm join 172.31.30.42:6443 --token yfxcvo.9eten1fy2rge1i12 --discovery-token-ca-cert-hash sha256:263fa117f8ab2276017a3d7e5d1bf8dcf6b17e6b318945a2d2a565a33a31d9bc
	# cat /var/lib/kubelet/kubeconfig
# kind: Config
# clusters:
# - cluster:
#     certificate-authority: /etc/kubernetes/pki/ca.crt
#     server: https://172.31.30.42:6443
#   name: kubernetes
# contexts:
# - context:
#     cluster: kubernetes
#     user: kubelet
#   name: kubelet
# current-context: kubelet
# users:
# - name: kubelet
#   user:
#     exec:
#       apiVersion: client.authentication.k8s.io/v1alpha1
#       command: /home/ubuntu/aws-iam-authenticator
#       args:
#         - "token"
#         - "-i"
#         - "my-dev-cluster.example.com"
# cat | base64 -d > /etc/kubernetes/pki/ca.crt
	# /usr/bin/kubelet   --address=0.0.0.0   --authentication-token-webhook   --authorization-mode=Webhook   --allow-privileged=true   --cloud-provider=aws   --cluster-dns=10.100.0.10   --cluster-domain=cluster.local   --cni-bin-dir=/opt/cni/bin   --cni-conf-dir=/etc/cni/net.d   --container-runtime=docker   --max-pods=29   --node-ip=172.31.18.80   --network-plugin=cni   --pod-infra-container-image=602401143452.dkr.ecr.us-west-2.amazonaws.com/eks/pause-amd64:3.1   --cgroup-driver=cgroupfs   --register-node=true   --kubeconfig=/var/lib/kubelet/kubeconfig   --feature-gates=RotateKubeletServerCertificate=true   --anonymous-auth=false   --client-ca-file=/etc/kubernetes/pki/ca.crt
	# example to merge into kubeadm if possible and if not kubelet direct
	# kubedns ip configuration
	# TODO ensure that nodes are added to LB and that all works
