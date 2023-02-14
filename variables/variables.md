variables can be declared in 3 different ways in terraform.
1 way.. directly by giving value.

output "student_name" {
        value = "Seema"
}

'''
2 way: by using a keyword locals.
'''

locals {
    student = "seema thapliyal"
}

output "student_name" {
    value = local.student
}
