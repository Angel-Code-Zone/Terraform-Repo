resource "aws_iam_role" "ec2_role" {
  name = "website-health-ec2-role"

  assume_role_policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Principal = {
          Service = "ec2.amazonaws.com"
        }

        Action = "sts:AssumeRole"
      }
    ]
  })
}

resource "aws_iam_role_policy" "ec2_policy" {
  name = "website-health-ec2-policy"
  role = aws_iam_role.ec2_role.id

  policy = jsonencode({
    Version = "2012-10-17"

    Statement = [
      {
        Effect = "Allow"

        Action = [
          "s3:PutObject"
        ]

        Resource = [
          "arn:aws:s3:::${var.s3_bucket_name}/logs/server-health/*",
          "arn:aws:s3:::${var.s3_bucket_name}/logs/website-health/*"
        ]
      }
    ]
  })
}

resource "aws_iam_instance_profile" "ec2_profile" {
  name = "website-health-ec2-profile"
  role = aws_iam_role.ec2_role.name
}