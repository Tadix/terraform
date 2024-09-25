# variable "instance_sg" {
#   type     = list(string)
# }

variable "rds_credential" {
  type = object({
    username:string,
    password:string
  })
}