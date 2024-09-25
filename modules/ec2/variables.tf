variable "ec2_instance_number" {
  type = number
  description = "The number of EC2 instances to deploy"
}

variable "subnet_ids" {
  type = list(string)
  default = ["subnet-0be33d0a507d5f36f","subnet-0f7960c341e27e3aa"]
}

variable "profile" {
  type = string
}