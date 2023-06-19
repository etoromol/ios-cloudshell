# ios-cloudshell

Cisco IOS Cloud Shell repository is a cutting-edge [Infrastructure As Code (IaC)](https://www.cisco.com/c/en/us/solutions/cloud/what-is-iac.html) solution that will revolutionize the way you deploy Cisco Virtual Routers on the Cloud. 

This custom solution is written in [Hashicorp Configuration Language (HCL)](https://www.terraform.io/docs/language/index.html) and is designed for network developers who want to streamline the process for deploying either the latest [Catalyst 8000V](https://www.cisco.com/site/us/en/products/networking/sdwan-routers/catalyst-8000v-edge-software/index.html) or its predecessor, the [Cloud Services Router 1000V](https://www.cisco.com/c/en/us/products/routers/cloud-services-router-1000v-series/index.html), As A Service.

With this solution, you can say goodbye to manual configurations and hello to a fully automated and customizable deployment process. 


## ¿Why Terraform?

By using [Terraform](https://developer.hashicorp.com/terraform/intro), you can save time, reduce errors, and ensure consistency across your network infrastructure. With its powerful automation capabilities and flexibility, you'll be able to deploy Cisco Virtual Routers like never before.


## Prerequisites

To deploy this infrastructure you will need:
* [AWS account](https://aws.amazon.com/free/).
* [AWS CLI](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html) (2.10.4+) installed.
* [Terraform CLI](https://learn.hashicorp.com/tutorials/terraform/install-cli?in=terraform/aws-get-started) (0.14.9+) installed.
* [Git](https://git-scm.com) (2.37.1+) installed.


## Installation

1. Clone the solution repository to your local device:
```bash
git clone https://github.com/etoromol/ios-cloudshell.git
cd ios-cloudshell
```
2. Initialize the working directory with Terraform:
```bash
terraform init
```


## Configuration

3. (optional) If you haven't already authenticated your AWS account in AWS CLI, please complete the following steps:

* Create a new Access Key on [My security credentials](https://console.aws.amazon.com/iam/home?#/security_credentials).
* Enter your AWS Access Key ID and Secret Access Key for verification.
```bash
aws configure
```
*The configuration process stores your credentials in a file at ~/.aws/credentials on MacOS and Linux, or %UserProfile%\.aws\credentials on Windows.*

4. (optional) Navigate to the Variable Component ([variable.tf](variables.tf)) and customize the solution's details according to your requirements (description and tag).
```hcl
variable "project" {
  description = "Cisco IOS-XE Software As A Service" <<-
  type        = map(string)
  default = {
    tag = "ios-cloudshell" <<-
  }
}
```  


## Deployment

5. Initiate the deployment process:
```bash
terraform apply
```
*It is recommended that you review the deployment plan before with "terraform plan".*

6. Once your IOS Cloud Shell is ready, access it using the command below.:
```bash
ssh -i ios-cloudshell-key.pem \
-o PubkeyAcceptedKeyTypes=+ssh-rsa \
ec2-user@shell-ip
```
*You can obtain the value of shell-ip by running "terraform output"*

7. If the IOS Cloud Shell is no longer required, it should be destroyed.:

```bash
terraform destroy
```
*Terraform will present the deployment and destruction plans before and after initialization. Proceed with the destruction/deployment by typing 'yes'; otherwise, Terraform will not proceed any further.*

## License

Copyright (c) 2023 Eduardo Toro.

Licensed under the [MIT](LICENSE) license.