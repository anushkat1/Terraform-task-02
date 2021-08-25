provider "aws" {
  region     = "ap-south-1"
  access_key = "AKIAW75OPNA5SQ3QHBZW"
  secret_key = "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"
}

resource "aws_key_pair" "kp2" {
  key_name   = "key2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQD3F6tyPEFEzV0LX3X8BsXdMsQz1x2cEikKDEY0aIj41qgxMCP/iteneqXSIFZBp5vizPvaoIR3Um9xK7PGoW8giupGn+EPuxIA4cDM4vzOqOkiMPhz5XK0whEjkVzTo4+S0puvDZuwIsdiW9mxhJc7tgBNL0cYlWSYVkz4G/fslNfRPW5mYAM49f4fhtxPb5ok4Q2Lg9dPKVHO/Bgeu5woMc7RY0p1ej6D4CKFE6lymSDJpW0YHX/wqE9+cfEauh7xZcG0q9t2ta6F6fmX0agvpFyZo8aFbXeUBr7osSCJNgvavWbM/06niWrOvYX2xwWdhXmXSrbX8ZbabVohBK41 email@example.com"
}

resource "aws_security_group" "firewall" {
  

  ingress {
    from_port        = 443
    to_port          = 443
    protocol         = "tcp"
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
  }

  tags = {
    Name = "sgf"
  }
}

resource "aws_instance" "task2" {
  ami           = "ami-00bf4ae5a7909786c"
  instance_type = "t2.micro"
  key_name = aws_key_pair.kp2.key_name
  security_groups= ["${aws_security_group.firewall.name}"]
  tags= {
    Name = "AT OS"
  }
}


resource "aws_ebs_volume" "st12" {
 availability_zone = aws_instance.task2.availability_zone
 size = 1
 tags= {
    Name = "My volume"
  }
}

resource "aws_volume_attachment" "ebs12" {
 device_name = "/dev/sdh"
 volume_id = aws_ebs_volume.st12.id
 instance_id = aws_instance.task2.id 
}
