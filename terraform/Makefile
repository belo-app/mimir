SHELL := /bin/sh

placeholder:
	@echo "You didn't specify any target. For caution, default target just prints this message and exits"

tf-init:
	terraform init -backend-config="config/${TERRAFORM_ENVIRONMENT}.s3.tfbackend" -reconfigure

tf-plan:
	terraform plan -var-file=config/${TERRAFORM_ENVIRONMENT}.tfvars

tf-apply:
	terraform apply -var-file=config/${TERRAFORM_ENVIRONMENT}.tfvars
tf-destroy:
	terraform destroy -var-file=config/${TERRAFORM_ENVIRONMENT}.tfvars

tf-validate:
	terraform validate

tf-fmt:
	terraform fmt -check -recursive

tf-clean:
	rm -rf .terraform

.PHONY: placeholder tf-init tf-plan tf-apply tf-destroy tf-validate tf-fmt tf-clean
