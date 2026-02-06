# Module VPC
module "vpc" {
  source = "./modules/vpc"

  vpc_cidr                   = var.vpc_cidr
  public_subnet_cidr         = var.public_subnet_cidr
  private_subnet_redis_cidr  = var.private_subnet_redis_cidr
  private_subnet_db_cidr     = var.private_subnet_db_cidr
  availability_zone          = var.availability_zone
  project_name               = var.project_name
}

# Module Security Groups
module "security_groups" {
  source = "./modules/security-groups"

  vpc_id       = module.vpc.vpc_id
  allowed_ssh_ips         = var.allowed_ssh_ips
  project_name = var.project_name
}

# Data source para obtener la AMI de Ubuntu más reciente
data "aws_ami" "ubuntu" {
  most_recent = true
  owners      = ["099720109477"] # Canonical (Ubuntu)

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

# Module Compute
module "compute" {
  source = "./modules/compute"

  ami_id                   = data.aws_ami.ubuntu.id
  instance_type            = var.instance_type
  key_name                 = var.key_name
  public_subnet_id         = module.vpc.public_subnet_id
  private_subnet_redis_id  = module.vpc.private_subnet_redis_id
  private_subnet_db_id     = module.vpc.private_subnet_db_id
  vote_result_sg_id        = module.security_groups.vote_result_sg_id
  redis_worker_sg_id       = module.security_groups.redis_worker_sg_id
  postgres_sg_id           = module.security_groups.postgres_sg_id
  project_name             = var.project_name
}