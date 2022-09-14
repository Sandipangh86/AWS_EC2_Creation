variable "network_interface_id" {
  type = string
  default = "eni-0d4f43947b344f19d"
}

variable "ami" {
    type = string
    default = "ami-06489866022e12a14"
}

variable "instance_type" {
    type = string
    default = "t2.micro"
}
variable "keypair_name" {
    default = "key-terraform-key"
}
