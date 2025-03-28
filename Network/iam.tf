resource "aws_iam_instance_profile" "EC2-S3-Access" {
  name = "EC2-S3-Access"
  role = aws_iam_role.S3AccessRole.name
}

resource "aws_iam_role" "S3AccessRole" {
  name = "S3AccessRole"
    assume_role_policy = jsonencode(
    
    {
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "sts:AssumeRole"
            ],
            "Principal": {
                "Service": [
                    "ec2.amazonaws.com"
                ]
            }
        }
    ]
}

)

}

