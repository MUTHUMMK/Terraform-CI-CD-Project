variable "instance_id" {}
variable "template_tag" {}
variable "template_instance_type" {}
variable "template_key_name" {}
variable "alb_sg" {}

# auto scaling variables
variable "public_subnet_cidrs" {}
variable "as_capacity" {}
variable "as_max_size" {}
variable "as_min_size" {}
#variable "as_health_check_type" {}

# auto scaling up policy
variable "asscale_up_tag" {}

# scale up alarm
variable "asscale_up_alarm_tag" {}

# auto scaling down policy
variable "asscale_down_tag" {}

# scale down alarm
variable "asscale_down_alarm_tag" {}

# create Target group
variable "vpc_id" {}
variable "app_port" {}
variable "subnet_ids" {}




