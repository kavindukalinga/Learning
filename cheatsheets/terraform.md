# </ Terraform >

```bash

................................................................................
    # Initailize credintials
aws configure
................................................................................
    # Create main.tf
provider "aws"{
    region = "us-east-a"
}

resource "aws_instance" "example"{
    ami= "dcohiuhohdhoih"   #AMI Id for ubuntu/mac/windows
    instance_type="t2.micro"
}
................................................................................
terraform init
terraform plan  # forcasting
terraform apply

terraform destroy
................................................................................


```