resource "aws_s3_bucket" "fe-bucket-tf"{
    bucket = var.bucket_name

    force_destroy = true

    tags = {
        Name        = var.bucket_name
        Environment = var.environment
    }
}

resource "aws_s3_bucket_ownership_controls" "example" {
  bucket = aws_s3_bucket.fe-bucket-tf.id
  rule {
    object_ownership = "ObjectWriter"
  }
}

resource "aws_s3_bucket_public_access_block" "example" {
  bucket = aws_s3_bucket.fe-bucket-tf.id

  block_public_acls       = false
  block_public_policy     = false
  ignore_public_acls      = false
  restrict_public_buckets = false
}

resource "aws_s3_bucket_acl" "example" {
  depends_on = [
    aws_s3_bucket_ownership_controls.example,
    aws_s3_bucket_public_access_block.example,
  ]

  bucket = aws_s3_bucket.fe-bucket-tf.id
  acl    = "public-read"
}

resource "aws_s3_bucket_policy" "frontend_bucket_policy" {
  bucket = aws_s3_bucket.fe-bucket-tf.id

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Sid = "PublicReadGetObject",
        Effect = "Allow",
			  Principal = "*",
			  Action = [
			    "s3:PutObject",
          "s3:PutObjectAcl",
          "s3:GetObject",
          "s3:ListBucket"
        ],
        Resource = [
          "${aws_s3_bucket.fe-bucket-tf.arn}",
          "${aws_s3_bucket.fe-bucket-tf.arn}/*"
        ]
      }
    ]
  })

  depends_on = [ aws_s3_bucket_public_access_block.example ]
}

module "template_files" {
    source = "hashicorp/dir/template"
    base_dir = var.build_artifact_path
}

resource "aws_s3_bucket_website_configuration" "frontend_bucket_website_configuration" {
  bucket = aws_s3_bucket.fe-bucket-tf.id

  index_document {
    suffix = "index.html"
  }
}

resource "aws_s3_bucket_object" "bucket_web_files" {
  bucket = aws_s3_bucket.fe-bucket-tf.id

  for_each     = module.template_files.files
  key          = each.key
  content_type = each.value.content_type

  source  = each.value.source_path
  content = each.value.content

  etag = each.value.digests.md5
}