bucket_name = "techteam-help"
name        = "environment"
environment = "dev-1"

vpc_cidr             = "10.0.0.0/16"
vpc_name             = "dev-proj-eu-central-vpc-1"
cidr_public_subnet   = ["10.0.1.0/24", "10.0.2.0/24"]
cidr_private_subnet  = ["10.0.3.0/24", "10.0.4.0/24"]
eu_availability_zone = ["eu-central-1a", "eu-central-1b"]

public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDCvLRaX/+PEDv3zaq3+SfJBNcv8JH5gqniUzhDTJis++Bu0C27pcCVwC687nJoiptr6IM5zZ+3tRjSgr0p3crkeLQb3RWNhVPsZFpySAXIEGcvTDbLk7bhv+jtBTJ5/F3nTWXdw+XG2abWscuAgA0E4lhcApWtk6QX7ICJlmC70SaruLa6boz/YTLRnK+ib2xC3qu1k/5BcmkHD0E22Y5kBFumFfz5QCiFP5I7tJodJdOEcjU0tPNFB6Xzy2JJQw9k9pENEGx7mOzg3KAlV4CAuuC5GhKINPZT7/nDb0AFqt15Go2yldR2J4isO9eDeEYaqrEHedcoG6r2wLV5d7fP" #Replace with your public key
ec2_ami_id     = "ami-03250b0e01c28d196"

ec2_user_data_install_apache = ""

domain_name = "techteam.help"
