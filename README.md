# Terraform-Complete-Automation-Project

# TERRAFORM-TO-COMPLETE-AUTOMATION-PROJECT

Automated VPC, EC2, ELB, and CloudWatch Infrastructure with Autoscaling
Description

This project leverages Terraform modules to create and manage a robust AWS infrastructure setup that includes a Virtual Private Cloud (VPC), Elastic Compute Cloud (EC2) instances, an Elastic Load Balancer (ELB), and CloudWatch alarms for autoscaling based on CPU utilization metrics. By using this infrastructure-as-code (IAC) approach, you can easily deploy, update, and manage your AWS resources with efficiency and consistency.
Table of Contents

    * Features
    * Prerequisites
    * Getting Started
    * Usage
    * Customization
    * Terraform Modules
    * Contributing
    * Acknowledgments
  
# Features

    VPC Creation: Automated setup of a secure Virtual Private Cloud with customizable subnets, route tables, and security groups.
    EC2 Instances: Provision EC2 instances within the VPC with the desired configuration.
    ELB Configuration: Automatically create an Elastic Load Balancer to distribute traffic to your EC2 instances.
    CloudWatch Metrics: Set up CloudWatch alarms to monitor CPU utilization, triggering autoscaling when necessary.
    Autoscaling: Automatically add or remove EC2 instances based on CloudWatch alarms, ensuring your application can handle varying loads.
    Modularity: Use Terraform modules for easy customization and extension of the infrastructure.

# Prerequisites

Before you begin, ensure you have the following prerequisites:

    Terraform installed on your local machine.
    AWS account credentials configured with appropriate IAM permissions.
    Basic understanding of AWS services and Terraform concepts.

Getting Started

To get started with this project, follow these steps:

    Clone this repository to your local machine:

    bash
    git clone https://github.com/MUTHUMMK/TERRAFORM-TO-COMPLETE-AUTOMATION-PROJECT.git
    cd TERRAFORM-TO-COMPLETE-AUTOMATION-PROJECT
    cd TF_Automation_Project

* Customize the Terraform variables in the variables.tf file to match your desired infrastructure configuration.

Initialize the Terraform configuration &  VPC - EC2 create the infrastructure:

    terraform init
    cd create_infra
    terraform apply
    
    Confirm the changes by typing yes when prompted.

* Customize the Terraform variables in the variables.tf file to match your desired infrastructure configuration.

Initialize the Terraform configuration & ELB - AUTOSCALING create the infrastructure:

    terraform init    
    cd load_balancer
    terraform apply
    
    Confirm the changes by typing yes when prompted.

# Usage

Once your infrastructure is deployed, you can access your EC2 instances through the ELB's DNS name. You can also monitor CPU utilization in the AWS CloudWatch console and observe autoscaling in action as your application traffic fluctuates.
Customization

You can customize this project by modifying the Terraform variables, adjusting the module configurations, or adding additional AWS resources as needed. Be sure to review the documentation for each module used to understand the available options and best practices.
Terraform Modules

    Module 1: VPC Configuration
    Module 2: EC2 Instances
    Module 3: Elastic Load Balancer
    Module 4: CloudWatch Alarms

# Contributing

Contributions to this project are welcome! If you have improvements or additional features to suggest, please open an issue or submit a pull request. Be sure to follow the code of conduct.

# Acknowledgments

Special thanks to the Terraform community and AWS for providing powerful tools and services that make infrastructure automation possible.
