provider "aws" {
  region                  = "ap-south-1"
  profile                 = "default"
}


resource "aws_instance" "my_os" {
	ami           = "ami-011c99152163a87ae"
	instance_type = "t2.micro"
  subnet_id              = "subnet-4173180d"
	tags = {
		  "Name" = "My OS"
	  }
}

output "myos" {
  value = aws_instance.my_os.availability_zone
}


resource "aws_ebs_volume" "my_volume" {
   availability_zone = aws_instance.my_os.availability_zone 
   size              =  1

  tags = {
    Name = "my storage"
  }
}

resource "aws_volume_attachment" "vol_attached" {
  device_name = "/dev/sdh"
  volume_id   = aws_ebs_volume.my_volume.id
  instance_id = aws_instance.my_os.id
}