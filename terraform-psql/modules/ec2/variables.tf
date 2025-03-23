variable "ami_id-g" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "ami_id-psql" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  type        = string
}



variable "public_subnet1_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet1_id" {
  description = "ID of the first private subnet"
  type        = string
}

variable "private_subnet2_id" {
  description = "ID of the second private subnet"
  type        = string
}

variable "jumphost_sg_id" {
  description = "ID of the psql security group"
  type        = string
}


variable "psql_sg_id" {
  description = "ID of the psql security group"
  type        = string
}

variable "g_sg_id" {
  description = "ID of the grafana security group"
  type        = string
}




variable "key_name" {
  default = "project-psql-key"
}
variable "key_file_path" {
  default = "/var/lib/jenkins/workspace/project-psql-key.pem"
}