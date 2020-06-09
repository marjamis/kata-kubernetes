.IGNORE: clean
.DEFAULT_GOAL := helper

CLUSTER := "cluster"
IAM_POLICY_ARN := "arn:aws:iam::aws:policy/AmazonS3ReadOnlyAccess"

helper: # Adapted from: https://marmelab.com/blog/2016/02/29/auto-documented-makefile.html
	@echo "Available targets..." # @ will not output shell command part to stdout that Makefiles normally do but will execute and display the output.
	@grep -hE '^[a-zA-Z_-]+:.*?## .*$$' $(MAKEFILE_LIST) | sort | awk 'BEGIN {FS = ":.*?## "}; {printf "\033[36m%-30s\033[0m %s\n", $$1, $$2}'

eksctl: ## Creates the requirements for a IRSA using eksctl
	eksctl utils associate-iam-oidc-provider --cluster ${CLUSTER} --approve
	eksctl create iamserviceaccount \
	--name irsa-eksctl \
	--namespace testing \
	--cluster ${CLUSTER} \
	--attach-policy-arn ${IAM_POLICY_ARN} \
	--approve \
	--override-existing-serviceaccounts

	kubectl apply -f ./irsa-eksctl.eks.yml

manual: ## Creates the requirements for a IRSA using direct AWS API calls
	$(eval AWS_ACCOUNT_ID=$(shell aws sts get-caller-identity --query "Account" --output text))
	$(eval OIDC_PROVIDER=$(shell aws eks describe-cluster --name ${CLUSTER} --query "cluster.identity.oidc.issuer" --output text | sed -e "s/^https:\/\///"))
	aws iam create-role --role-name irsa-manual \
	--assume-role-policy-document '$(shell cat trust_policy.json | sed "s:{AWS_ACCOUNT_ID}:${AWS_ACCOUNT_ID}:g" | sed "s:{OIDC_PROVIDER}:${OIDC_PROVIDER}:g" | jq -c .)' \
	--description "irsa-manual testing role"
	aws iam attach-role-policy --role-name irsa-manual --policy-arn=${IAM_POLICY_ARN}

	cat irsa-manual.eks.yml | sed "s\{ROLE_ARN}\arn:aws:iam::${AWS_ACCOUNT_ID}:role/irsa-manual\g" | kubectl apply -f -

clean: ## Cleans up any old/unneeded items
	kubectl delete -n testing pod/irsa-eksctl pod/irsa-manual
	eksctl delete iamserviceaccount --cluster ${CLUSTER} --name irsa-eksctl
	aws iam detach-role-policy --role-name irsa-manual --policy-arn ${IAM_POLICY_ARN} && 	aws iam delete-role --role-name irsa-manual
