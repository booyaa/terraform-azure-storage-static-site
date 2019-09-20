.PHONY: setup build deploy clean 

azure.tfvars:
	@echo 'owner=YOUR_NAME' > azure.tfvars
	@echo 'location=AZURE_LOCATION' >> azure.tfvars

setup: azure.tfvars

build:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	terraform init
	terraform plan -var-file azure.tfvars

deploy:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	terraform apply -var-file azure.tfvars

clean:
	@test -f azure.tfvars || (echo 'run `make setup` and update values in azure.tfvars' && exit -1)
	terraform destroy

