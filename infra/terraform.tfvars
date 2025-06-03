bucket_name = "techteam-help"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC2Dgoq0tJf6WUBVOQv17/5U/AaxSaULVBmAjuIW9OzwR9NQWhTgqE+N7RYTRRcAQf6px5bWS093FaU9SjAftz3DfJzi9YgqpqvxWlhRwVKUPuFXNGjjwIFMJCBKXfwLOnNTnwAifmzFt9xZICB834C9KpYNwcxAbLASTx/atnw091/V78hK8UY7yyVjA3ikowNG8Px6jhMWs6ApKCjzLhJrtZM+zfkHejTgBU7b+w0hjWu8/YYMt5gBw9FISWW47Q7m5Qhz2VJHiDDMudacpnRBhTQ5ur49rbSBj36Ze8CJuQzloBE+kkt0D4NCkP5npP+HO7r5UxRuXBlOzIIvPef" #Replace with your public key
ec2_ami_id     = "ami-03250b0e01c28d196"

ec2_user_data_install_apache = ""

domain_name = "techteam.help"
