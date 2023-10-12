provider "aws" {
  region = "ap-south-1"
  # Replace with your desired AWS region
}


resource "aws_instance" "my_instance" {
  ami           = "ami-0f5ee92e2d63afc18"
  # Replace with your desired AMI ID
  instance_type = "t2.micro"
  # Replace with your desired instance type
  subnet_id     = aws_subnet.my_subnet.id
  # Reference the subnet ID created in Project2
  tags = {
    Name = "SDM-TestTfStateinS3-2"
  }
}


terraform {
  backend "s3" {
    bucket         = "sdm-terraform-state-bucket-2"
    # Use the same bucket name from Step 1
    key            = "ec2_instance/terraform.tfstate"
    # Specify a unique key for this state file
    region         = "ap-south-1"
    # Use the same region as the bucket
    encrypt        = true
    dynamodb_table = "SDM-terraform-lock"
    # Optional: Enables state locking
  }
}


# Need to remove 'backend' configuration block if we already have it in any other .tf files in this same directory such as I have it  # already in vpc_subnet.tf file, but it is in the separate directory Project2. Otherwise we get "duplicate backend" configuration erro#r

