
# Create AMI for launch template & auto-scaling

resource "aws_ami_from_instance" "My_ami" {
  name               = "terraform-ami"
  source_instance_id = var.instance_id
  #snapshot_without_reboot = "true"
  tags               = var.template_tag
}

#create template
resource "aws_launch_template" "new-template" {
  name_prefix   = "new-template"
  image_id      = aws_ami_from_instance.My_ami.id
  instance_type = var.template_instance_type
  key_name      = var.template_key_name
  user_data = filebase64("${path.module}/ec2-init.sh")
  /*user_data = <<-EOF
              #!bin/bash
              sudo systemctl restart docker
              sudo docker restart $(sudo docker ps -aq) 
              EOF   */         
             
  network_interfaces {
    associate_public_ip_address = true
    security_groups             = [var.alb_sg]
  }
}

# create autoscaling group
resource "aws_autoscaling_group" "autoscaling" {
  name = "autoscaling-mmk"
  #count             = length(var.public_subnet_cidrs)
  #cidr_block        = var.public_subnet_cidrs[count.index]
  #availability_zones = data.aws_availability_zones.az.names[count.index]
  desired_capacity   = var.as_capacity
  max_size           = var.as_max_size
  min_size           = var.as_min_size
  health_check_grace_period = 300
  #health_check_type = var.as_health_check_type # health check type deault EC2 (or) ELB
  vpc_zone_identifier =  (var.public_subnet_cidrs)
  
  launch_template {
    id      = aws_launch_template.new-template.id
    version = "$Latest"
  }
}


# auto scaling up policy

resource "aws_autoscaling_policy" "scale_up" {
  name = "var.asscale_up_tag"
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "1"    # increase instance by 1
  cooldown = "300"
  policy_type = "SimpleScaling"
}

# scale up alarm

# alarm will trigger the ASG ploicy (scale/down) based on the metric (CPUUtilization)

resource "aws_cloudwatch_metric_alarm" "scale_up_alarm" {
  alarm_name = "var.asscale_up_alarm_tag"
  alarm_description = "asg-scale-up-CPU-alarm"
  comparison_operator = "GreaterThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "40"    # new instance will be created once CPU utilization is higher than 30 %
  dimensions = {
     "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scale_up.arn]

}


# auto scaling down policy

resource "aws_autoscaling_policy" "scale_down" {
  name = "var.asscale_down_tag"
  autoscaling_group_name = aws_autoscaling_group.autoscaling.name
  adjustment_type = "ChangeInCapacity"
  scaling_adjustment = "-1"    # decreasing instance by 1
  cooldown = "300"
  policy_type = "SimpleScaling"
}

# scale down alarm

resource "aws_cloudwatch_metric_alarm" "scale_down_alarm" {
  alarm_name = "var.asscale_down_alarm_tag"
  alarm_description = "asg-scale-down-CPU-alarm"
  comparison_operator = "LessThanOrEqualToThreshold"
  evaluation_periods = "2"
  metric_name = "CPUUtilization"
  namespace = "AWS/EC2"
  period = "120"
  statistic = "Average"
  threshold = "5"    # instance will be scaling down when CPU utilization is lower than 5 %
  dimensions = {
     "AutoScalingGroupName" = aws_autoscaling_group.autoscaling.name
  }
  actions_enabled = true
  alarm_actions = [aws_autoscaling_policy.scale_down.arn]

}

# create Target group
resource "aws_lb_target_group" "target_group" {
  name     = "tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  health_check {
    path                = "/"
    protocol            = "HTTP"
    interval            = 30
    timeout             = 5
    healthy_threshold   = 3
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

# target group attachment

resource "aws_lb_target_group_attachment" "tg_attachment" {
  target_group_arn = aws_lb_target_group.target_group.arn
  target_id        = var.instance_id
  port             = var.app_port # put the application run port number
}


# create Load balancer
resource "aws_lb" "load-balancer" {
  name               = "load-balancer"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [var.alb_sg]
  subnets            = var.subnet_ids
}

# listener rule
resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.load-balancer.arn
  port              = "80" # Our loadbalancer DNS will work under HTTP
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.target_group.arn
  }
}



resource "aws_autoscaling_attachment" "example" {	   # We create two auto-scaling attachment for the two instance - This is instance 1
  autoscaling_group_name = aws_autoscaling_group.autoscaling.id  # 1st autoscaling group id
  lb_target_group_arn    = aws_lb_target_group.target_group.arn
}