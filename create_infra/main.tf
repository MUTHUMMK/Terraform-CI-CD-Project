module "vpc_tf" {
  source               = "./modules/vpc"
  vpc_cidr             = var.vpc_cidr
  vpc_tags             = var.vpc_tags
  vpc_instance_tenancy = var.vpc_instance_tenancy
  public_subnet_cidrs  = var.public_subnet_cidrs
  igw_tag              = var.igw_tag
  public_rt_tag        = var.public_rt_tag
}

module "sg_tf" {
  source      = "./modules/sg"
  vpc_id      = module.vpc_tf.vpc_id
  first_port  = var.first_port
  second_port = var.second_port
  third_port  = var.third_port
  sg_tag      = var.sg_tag

}

module "ec2_tf" {
  source        = "./modules/ec2"
  ami_id        = var.ami_id
  instance_type = var.instance_type
  subnet_ids    = module.vpc_tf.subnet_ids[0]
  sg_id         = module.sg_tf.sg_id
  key_name      = var.key_name
  ec2_tag       = var.ec2_tag
  public_ip     = var.public_ip
}

