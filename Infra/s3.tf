resource "aws_s3_bucket" "myS3Bucket" {
  bucket = "islamsaifs3bucket1995"

  tags = {
    Name = "My bucket"
  }
}

resource "aws_s3_bucket_public_access_block" "public_access" {
  bucket = aws_s3_bucket.myS3Bucket.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_policy" "public_read_policy" {
  bucket = aws_s3_bucket.myS3Bucket.id
  policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": "*",
      "Action": [
        "s3:GetObject",
        "s3:PutObject",
        "s3:DeleteObject"
      ],
      
      "Resource": "arn:aws:s3:::islamsaifs3bucket1995/*"
    }
  ]
}
POLICY
}

