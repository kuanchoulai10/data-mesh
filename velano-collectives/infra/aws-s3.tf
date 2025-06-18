# --8<-- [start:velano-collectives]
resource "random_string" "velano_collectives_suffix" {
  length  = 4
  special = false
  numeric = true
  lower   = true
  upper   = false
}

module "aws_s3_bucket_velano_collectives" {
  source  = "terraform-aws-modules/s3-bucket/aws"
  version = "~> 4.10.1"

  bucket = "velano-collectives-${random_string.velano_collectives_suffix.result}"
}

resource "aws_s3_object" "products" {
  bucket = module.aws_s3_bucket_velano_collectives.s3_bucket_id
  key    = "products.csv"
  source = "../data/products.csv"
}

# --8<-- [end:velano-collectives]