resource "aws_iam_policy" "bigquery" {
  name = "bigquery-policy"

  policy = <<-EOF
            {
              "Version": "2012-10-17",
              "Statement": [
                  {
                      "Sid": "BucketLevelAccess",
                      "Effect": "Allow",
                      "Action": ["s3:ListBucket"],
                      "Resource": ["${module.aws_s3_bucket_velano_collectives.s3_bucket_arn}"]
                  },
                  {
                      "Sid": "ObjectLevelAccess",
                      "Effect": "Allow",
                      "Action": ["s3:GetObject","s3:PutObject"],
                      "Resource": [
                          "${module.aws_s3_bucket_velano_collectives.s3_bucket_arn}",
                          "${module.aws_s3_bucket_velano_collectives.s3_bucket_arn}/*"
                      ]
                  }
              ]
            }
            EOF
}

resource "aws_iam_role" "bigquery" {
  name                 = "bigquery-role"
  max_session_duration = 43200

  assume_role_policy = <<-EOF
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "Federated": "accounts.google.com"
          },
          "Action": "sts:AssumeRoleWithWebIdentity",
          "Condition": {
            "StringEquals": {
              "accounts.google.com:sub": "${google_bigquery_connection.aws.aws[0].access_role[0].identity}"
            }
          }
        }
      ]
    }
    EOF
}

resource "aws_iam_role_policy_attachment" "main" {
  role       = aws_iam_role.bigquery.name
  policy_arn = aws_iam_policy.bigquery.arn
}
