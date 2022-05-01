# Call our Custom Terraform Module which we built earlier

module "website_s3_bucket" {
  source  = "app.terraform.io/iac-hcta/s3-website/aws"
  version = "1.0.1"
  # insert required variables here
  bucket_name = var.my_s3_bucket
  tags        = var.my_s3_tags
}

resource "aws_s3_bucket_object" "upload_file" {
  key          = "index.html"
  acl          = "public-read"
  content_type = "text/html"
  source       = "${path.module}/files/index.html"
  bucket       = module.website_s3_bucket.name
}