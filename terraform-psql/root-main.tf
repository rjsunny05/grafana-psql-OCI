module "vpc" {
  source   = "./modules/vpc"
  vpc_cidr = "192.168.0.0/16"
  vpc_name = "project-vpc"
}

module "subnet" {
  source   = "./modules/subnet"
  vpc_id   = module.vpc.vpc_id
  vpc_cidr = "192.168.0.0/16"
  az1      = "us-east-1a"
  az2      = "us-east-1b"
}

module "internet_gateway" {
  source  = "./modules/internet_gateway"
  vpc_id  = module.vpc.vpc_id
  igw_name = "project-igw"
}

module "nat_gateway" {
  source           = "./modules/nat_gateway"
  public_subnet1_id = module.subnet.public_subnet1_id
  nat_gateway_name = "project-natgw"
}

module "route_table" {
  source            = "./modules/route_table"
  vpc_id            = module.vpc.vpc_id
  igw_id            = module.internet_gateway.project_igw_id
  nat_gateway_id    = module.nat_gateway.project_natgw_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
}


module "nacl" {
  source           = "./modules/nacl"
  vpc_id           = module.vpc.vpc_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
}

module "security_groups" {
  source = "./modules/security_groups"
  vpc_id = module.vpc.vpc_id
}

module "ec2" {
  source            = "./modules/ec2"
  ami_id-g            = "ami-0f9de6e2d2f067fca"
  ami_id-psql            = "ami-0f9de6e2d2f067fca" # Ubuntu 22.04 LTS
  instance_type     = "t2.micro"
  
  public_subnet1_id = module.subnet.public_subnet1_id
  private_subnet1_id = module.subnet.private_subnet1_id
  private_subnet2_id = module.subnet.private_subnet2_id
  jumphost_sg_id     = module.security_groups.jumphost_sg_id
  psql_sg_id     = module.security_groups.psql_sg_id
  g_sg_id           = module.security_groups.g_sg_id
}

module "alb" {
  source           = "./modules/alb"
  alb_name         = "project-lb"
  lb_sg_id         = module.security_groups.lb_sg_id
  public_subnet1_id = module.subnet.public_subnet1_id
  public_subnet2_id = module.subnet.public_subnet2_id
  vpc_id           = module.vpc.vpc_id
  psql1_id = module.ec2.psql1_id
  psql2_id = module.ec2.psql2_id
  psql3_id = module.ec2.psql3_id
  psql4_id = module.ec2.psql4_id
  grafana1_id       = module.ec2.grafana1_id
  grafana2_id       = module.ec2.grafana2_id
}
