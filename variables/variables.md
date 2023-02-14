'''
variables can be declared in 3 different ways in terraform.
Accessing Child Module Outputs
In a parent module, outputs of child modules are available in
expressions as
module.<MODULE NAME>.<OUTPUT NAME>
1 way.. directly by giving value.
'''

output "student_name" {
        value = "Seema"
}

'''
2 way: by using a keyword locals. In a parent module, outputs of child modules are available in
expressions as
module.<MODULE NAME>.<OUTPUT NAME>
'''

locals {
    student = "seema thapliyal"
}

output "student_name" {
    value = local.student
}

'''
3. by using variable keyword and The label after the variable keyword is the name for the variable.

variable "image_id" {
type = string
}
variable "availability_zone_names" {
type = list(string)
default = ["us
west 1a"]
}