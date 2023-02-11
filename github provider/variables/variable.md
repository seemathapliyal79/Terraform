1Demo

output "student_name" {
    value = "reem"
}
2Demo - Locals and Output block and using variables in output block

# using local variable block 
locals {
  student="reem"
}

#refrencing or using variable 
output "student_name" {
    value = local.student
}


3Demo a List and ouput list values

locals {
  students=["reem","guy","pari"]
}

output "student_names" {
    value = local.students
}
4Demo Output element in a list

locals {
  students=["reem","guy","pari"]
}

output "student_names" {
    value = local.students[1]
}
5 Demo Introduction to null resource

locals {
  students=["reem","guy","pari"]
}

resource "null_resource" "students" {
}
output "student_names" {
    value = local.students[1]
}

6 Demo Loopong construct count

locals {
  students=["reem","guy","pari"]
}

resource "null_resource" "students" {
  count = 3

}
8Demo - Understand trigger and count index

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