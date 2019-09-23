.PHONY: setup build deploy clean upload terraform_apply

azure.tfvars:
	@echo 'owner=YOUR_NAME' > azure.tfvars
	@echo 'location=AZURE_LOCATION' >> azure.tfvars

setup: azure.tfvars

build:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	@terraform init
	@terraform plan -var-file azure.tfvars

deploy: terraform_apply upload

terraform_apply:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	@terraform apply -var-file azure.tfvars

ACCOUNT_NAME := $(shell terraform output static_site_account_name)
upload:
	@az storage blob upload-batch --account-name $(ACCOUNT_NAME) -s assets -d '$$web'
	@echo your new static site is on $(shell terraform output static_site_url)

clean:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	terraform destroy

