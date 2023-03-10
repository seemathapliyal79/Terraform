'''
# 1Demo
'''

output "student_name" {
    value = "reem"
}

'''
# 2Demo - Locals and Output block and using variables in output block
''''

# using local variable block 
locals {
  student="reem"
}

#refrencing or using variable 
output "student_name" {
    value = local.student
}

'''
# 3Demo a List and ouput list values
'''

locals {
  students=["reem","guy","pari"]
}

output "student_names" {
    value = local.students
}

'''
# 4Demo Output element in a list
'''

locals {
  students=["reem","guy","pari"]
}

output "student_names" {
    value = local.students[1]
}

'''
# 5 Demo Introduction to null resource
'''

locals {
  students=["reem","guy","pari"]
}

resource "null_resource" "students" {
}
output "student_names" {
    value = local.students[1]
}

'''
# 6 Demo Loopong construct count
'''
locals {
  students=["reem","guy","pari"]
}

resource "null_resource" "students" {
  count = 3

}

'''
# 7 Demo for each
will be re visited 
8Demo - Understand trigger and count index
'''
#understand trigger and count index 
locals {
  students=["Reem","Siva","Pari"]

}

resource "null_resource" "name" {
    count = 3
    triggers = {
        grade=local.students[count.index]
    }
  
}

'''
# 9 Demo Loop-for function-upper
'''

variable "students" {
  default = ["reem","guy","pari"] 
}

output "students_names" {
    value = var.students
  
}

output "students_names_caps" {
    value = [for name in var.students : upper(name)]
  
}
'''
# 9 Demi B Simple example where count value is taken from out put of function lenght
'''
locals {
  actors=["amar","akbar","anthony"]
}

resource "null_resource" "act" {
  count = length(local.actors)
}
'''
# 9 Demo c Count Vaule taken from out put of function-lenght
'''

locals {
  names = ["bob", "kevin", "stewart","reem"]
}
resource "null_resource" "names" {
  count = length(local.names)
  triggers = {
    name = local.names[count.index]
  }
}

output "name" {
  value = null_resource.names
}

''''
# 10 Demo Provisoner local-exec
''''

resource "null_resource" "sanddevboxa" {
  provisioner "local-exec" {
    command = "echo all is well"
  }
}

'''
# 10 Demo A out put something in a file from localmachine without actually executing a remote resource
'''
resource "null_resource" "sanddevboxa" {
  provisioner "local-exec" {
    command = "echo all is well >> temp.txt"
  }
}

'''
Test - break the following tf script into two have variables in seperate file and see if it works
create variables.tf include only variables here
create a main.tf include only output block
'''

variable "greet" {
  default = "ALl IS WELL"
}

locals {
  greeting = "SURPRISE"
}
output "Surprise" {
    value= local.greeting
}

output "greetings" {
  value = var.greet
}

'''
challenge - use localexec to execute a ansible playbook on localmachine
'''
resource "null_resource" "sandbox2" {
  provisioner "local-exec" {
    command = "ansible-playbook playbook.yaml"
  }
}
# simplest play
---
- hosts: localhost
  tasks:
  - name: just do it
    command: date

'''
Using dynamic block to create multiple security group in VPC
'''
provider "aws" {
	
	region     = "us-east-1"

	access_key = " your_aws_access_key_here 2"

	secret_key = "your_aws_secret_key_here"
	token = “your_aws_token_here”
}

locals {
	ingress_rules = [{
		port        = 443
		description = "Port 443"
	},
	{
		port        = 80
		description = "Port 80"
	}]
}

resource "aws_security_group" "main" {
	name   = "foo"
	vpc_id = “your_aws_vpc_id here”

	dynamic "ingress" {
		for_each = local.ingress_rules

		content {
			description = ingress.value.description
			from_port   = ingress.value.port
			to_port     = ingress.value.port
			protocol    = "tcp"
			cidr_blocks = ["0.0.0.0/0"]
		}
	}
	/*
	ingress {
		description = "ajsec bar"
		from_port   = 443
		to_port     = 443
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
	*/

	tags = {
		Name = "one security group"
	}
}

'''
## Using remote exec provisioners following

##Please note and be careful to replace security token, access key, secret key, vpc
''''

locals {
  ami_id = "ami-09e67e426f25ce0d7"
  vpc_id = "vpc-0bcddf970df6059d7"
  ssh_user = "ubuntu"
  key_name = "demokey"
  private_key_path = "demokey.pem"
}

provider "aws" {
region     = "us-east-1" 
 
access_key = "ASIAWBWEOWFPY7OR3MPW" 
 
secret_key = "0kLmrT1a+aWCQv57AuUovak5eUnTfGY7+SytvU9E" 
token = "FwoGZXIvYXdzEFkaDDy0qZqmAuRHx6rrlSK8AUGCQsOfMC6pe9XtdEB4/q10sfeDzHWbT6+nxAzAq3mvpAzVF6w6MbM8K2ogRw8oyoCqUYp8eS73KEccd4oNpMt5TX2o5w/7anW0TTRexaflrw39cie2YupZMCgV7zBfNT2O+8oG698mlb0l5aV3I+ZkexF/PsFDmqoTgBk/hHf2MrL8PStASmqXlv0RDWeasUwFqqmQqsaicNw+drJWKU/SiTu/75klyxIaxF1klzFTwHdXD/U+UybbmWlEKIykop8GMi22n/CzucooHEyIXUmMtWlCsZAfxQ0LgO7w+A612n8+G7L7UotL6m5F1wxl9ds="

}
resource "aws_security_group" "demoaccess" {
	name   = "demoaccess"
	vpc_id = local.vpc_id

  ingress {
		from_port   = 22
		to_port     = 22
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  ingress {
		from_port   = 80
		to_port     = 80
		protocol    = "tcp"
		cidr_blocks = ["0.0.0.0/0"]
	}
  egress {
		from_port   = 0
		to_port     = 0
		protocol    = "-1"
		cidr_blocks = ["0.0.0.0/0"]
	}
}

resource "aws_instance" "web" {
  ami = local.ami_id
  instance_type = "t2.micro"
  associate_public_ip_address = "true"
  vpc_security_group_ids =[aws_security_group.demoaccess.id]
  key_name = local.key_name

  tags = {
    Name = "Demo ec2"
  }

  connection {
    type = "ssh"
    host = self.public_ip
    user = local.ssh_user
    private_key = file(local.private_key_path)
    timeout = "4m"
  }

  provisioner "remote-exec" {
    inline = [
      "touch /home/ubuntu/demo-file-from-terraform.txt"
    ]
  }
}
