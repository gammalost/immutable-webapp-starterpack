provider "aws" {
  version = "~> 2.0"
  region = "eu-north-1"
}


resource "aws_s3_bucket" "bucket_asset" {
  bucket = "dev-tf-bucket-asset"
  acl    = "private"

  tags = {
      Managed = "Terraform"
  }
}

resource "aws_s3_bucket" "bucket_host" {
  bucket = "dev-tf-bucket-host"
  acl    = "private"

  tags = {
    Managed = "Terraform"
  }
}

resource "aws_s3_bucket_policy" "bucket_asset" {
  bucket = "${aws_s3_bucket.bucket_asset.id}"
  policy = templatefile("policy/public_bucket.json.tpl", {bucket_arn = aws_s3_bucket.bucket_asset.arn})
}

resource "aws_s3_bucket_policy" "bucket_host" {
  bucket = "${aws_s3_bucket.bucket_host.id}"
  policy = templatefile("policy/public_bucket.json.tpl", {bucket_arn = aws_s3_bucket.bucket_host.arn})
}