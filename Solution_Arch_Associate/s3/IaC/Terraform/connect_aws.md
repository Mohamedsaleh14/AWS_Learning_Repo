## Connect Terraform to AWS

Search google for `terraform registry aws` and copy the code under button `USE PROVIDER` into terraform file. As in this example in `main.tf`

## 1. Initialization
Go to the terraform folder where terraform files locates 
```bash
terraform init
```
## 2. To see the plan of what Terraform is going to do
```bash
terraform plan
```
## 3. To apply the plan
```bash
terraform apply
```
## 4. Don't commit terraform.tfstate
After applying, terraform will create a file `terraform.tfstate`. It will contain senstive information. That's why you shouldn't commit it.
## 5. To detroy this plan
```bash
terraform destroy
```
