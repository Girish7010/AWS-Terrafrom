resource "aws_instance" "app" {
  ami           = var.ec2_ami
  instance_type = var.ec2_type
  subnet_id     = aws_subnet.private[0].id
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

  key_name = var.key_pair

  # Attach IAM role for SSM Session Manager
  iam_instance_profile = aws_iam_instance_profile.ec2_ssm_profile.name

  user_data = <<-EOF
              #!/bin/bash -xe
              exec > >(tee /var/log/user-data.log|logger -t user-data -s 2>/dev/console) 2>&1

              apt-get update -y
              apt-get install -y python3 python3-pip
              pip3 install flask pymysql

              mkdir -p /home/ubuntu/app

              cat <<EOT > /home/ubuntu/app/app.py
              from flask import Flask
              app = Flask(__name__)
              @app.route('/')
              def home():
                  return "🚀 Hello from Flask App behind ALB!"
              if __name__ == "__main__":
                  app.run(host="0.0.0.0", port=5000)
              EOT

              nohup python3 /home/ubuntu/app/app.py > /home/ubuntu/app/app.log 2>&1 &
              EOF

  tags = {
    Name = "Flask-App-EC2"
  }
}
