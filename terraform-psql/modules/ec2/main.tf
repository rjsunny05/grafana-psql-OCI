resource "aws_instance" "jumphost" {
  ami                    = var.ami_id-g
  instance_type          = var.instance_type
  key_name               = var.key_name
  subnet_id              = var.public_subnet1_id
  vpc_security_group_ids = [var.jumphost_sg_id]
  associate_public_ip_address = true

  tags = {
    Name = "Bastion Host"
  }

  provisioner "file" {
    source      = var.key_file_path
    destination = "/home/ubuntu/project-psql-key.pem"
  }

  provisioner "remote-exec" {
    inline = [
      "chmod 400 /home/ubuntu/project-psql-key.pem"
    ]
  }

  connection {
    type        = "ssh"
    user        = "ubuntu"
    private_key = file(var.key_file_path)
    host        = self.public_ip
  }
}

resource "aws_instance" "psql1" {
  ami           = var.ami_id-psql
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.psql_sg_id]
  tags = {
    Name = "psql1"
  }
}

resource "aws_instance" "psql2" {
  ami           = var.ami_id-psql
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.psql_sg_id]
  tags = {
    Name = "psql2"
  }
}

resource "aws_instance" "grafana1" {
  ami           = var.ami_id-g
  instance_type = var.instance_type
  subnet_id     = var.private_subnet1_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.g_sg_id]
  tags = {
    Name = "grafana1"
  }
}

resource "aws_instance" "psql3" {
  ami           = var.ami_id-psql
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.psql_sg_id]
  tags = {
    Name = "psql3"
  }
}

resource "aws_instance" "psql4" {
  ami           = var.ami_id-psql
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.psql_sg_id]
  tags = {
    Name = "psql4"
  }
}

resource "aws_instance" "grafana2" {
  ami           = var.ami_id-g
  instance_type = var.instance_type
  subnet_id     = var.private_subnet2_id
  key_name      = var.key_name
  vpc_security_group_ids = [var.g_sg_id]
  tags = {
    Name = "grafana2"
  }
}
