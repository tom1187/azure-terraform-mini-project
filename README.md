# azure-terraform-mini-project

This mini terraform project is used to create the following resources in Azure cloud:

-Resourcegroup
-VirtualMachine
-IPAddress
-NSG
-NIC
-DiagnosticsService
-VirtualMachine

## prerequisite

1) Terraform CLI installed
2) Azure CLI installed
3) Azure subscription
4) Azure Service Principal's credential

## Installation
1) Git clone this repository.
2) edit the terraform.tfvars file. Set all missing values from your Service Principal's credential, and set the created VM's administrator username and password.
3) The project is using storage account as it's backend. You can use it as is (create the storage account and container), or replace it to a different backend. Required storage account details to run as is: resource_group_name = "tf-backend-resources" storage_account_name = "tftestbackend" container_name = "tfstate"

## Usage
run the following commands:

```
terraform init
terraform validate
terraform plan -out tfplan
```
Verify that all of the expected resource are created, and then apply using 
```terraform apply "tfplan"```
