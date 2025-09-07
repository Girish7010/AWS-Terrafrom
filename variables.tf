# ==============================
# AWS REGION
# ==============================
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

# ==============================
# VPC CIDR
# ==============================
variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

# ==============================
# EC2 INSTANCE SETTINGS
# ==============================
variable "ec2_ami" {
  description = "AMI ID for EC2 instance (Ubuntu 24.04 LTS in us-east-1)"
  type        = string
  default     = "ami-0360c520857e3138f"
}

variable "ec2_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "key_pair" {
  description = "EC2 key pair name (must already exist in AWS)"
  type        = string
  # ✅ we fixed the error by using your existing AWS key
  default     = "neo-key"
}

# ==============================
# RDS SETTINGS
# ==============================
variable "db_name" {
  description = "Database name"
  type        = string
  default     = "appdb"
}

variable "db_user" {
  description = "Database master username"
  type        = string
  default     = "admin"
}

variable "db_password" {
  description = "Database master password"
  type        = string
  default     = "ChangeMe123!"   # 🔥 Replace with your own strong password
  sensitive   = true
}
