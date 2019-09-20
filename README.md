# terraform-azure-storage-static-site

The Azure Terraform provider doesn't provide a way to enable static site mode on Azure Storage Accounts. Various workarounds were provided as part of the GitHub issue raised [#1903][gh_issue] that used Terraform's [local-exec][tf_local_exec] provisioner.

I'm using this repo to play around with the suggested work arounds to get a better understanding of how [local-exec][tf_loca_exec] works.

If you want to just use the functionality, someone's turned a workaround into a Terraform [module][tf_module].

## Setup

It's assumed you've got the following settup and working:

- Terraform v0.12 CLI is installed
- An Azure account
- Azure CLI installed

Authentication is through the [CLI][tf_azure_login].

Tip: If you've got [tfenv][tfenv] (terraform version manager) and don't use Terraform v0.12 yet you can install it just for this project using `tfenv install`.

- clone the repo
- `make setup` - fill out required details in `azure.tfvars`

## Usage

```sh
make build
make deploy
```

WARNING: Applying this terraform plan may incurr a cost on your Azure billing!

### To tear down

```sh
make clean
```

## License

There's no license per se for GitHub issues so I've used the license attached to in provider.

<-- Linkies -->

[gh_issue]: https://github.com/terraform-providers/terraform-provider-azurerm/issues/1903
[tf_local_exec]: https://www.terraform.io/docs/provisioners/local-exec.html
[tf_module]: https://github.com/StefanSchoof/terraform-azurerm-static-website
[tf_azure_login]: https://www.terraform.io/docs/providers/azurerm/auth/azure_cli.html
[tfenv]: https://github.com/tfutils/tfenv
