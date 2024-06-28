### aws/06_s3.tf ###

# 버킷
resource "aws_s3_bucket" "www_bk" {

  bucket = var.bucket[0]

  tags = {
    Name = "${var.bucket[0]}"
  }
}

resource "aws_s3_bucket_ownership_controls" "www_bk_oc" {

  bucket = aws_s3_bucket.www_bk.id
  rule {
    object_ownership = "BucketOwnerPreferred"
  }
}

resource "aws_s3_bucket_public_access_block" "www_bk_ab" {

  bucket = aws_s3_bucket.www_bk.id

  block_public_acls       = var.boolean_list[0]
  block_public_policy     = var.boolean_list[0]
  ignore_public_acls      = var.boolean_list[0]
  restrict_public_buckets = var.boolean_list[0]
}

resource "aws_s3_bucket_acl" "www_bk_acl" {

  bucket = aws_s3_bucket.www_bk.id
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_ownership_controls.www_bk_oc,
    aws_s3_bucket_public_access_block.www_bk_ab,
  ]
}

# 객체
resource "aws_s3_object" "img_file" {

  bucket = aws_s3_bucket.www_bk.bucket
  key    = var.s3[0]
  source = "${var.s3_path}${var.s3[0]}"
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_acl.www_bk_acl
  ]
}

resource "aws_s3_object" "index_file" {

  bucket = aws_s3_bucket.www_bk.bucket
  key    = "index.html"
  source = "${var.s3_path}${var.s3[1]}"
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_acl.www_bk_acl
  ]
}

resource "aws_s3_object" "error_file" {

  bucket = aws_s3_bucket.www_bk.bucket
  key    = "error.html"
  source = "${var.s3_path}${var.s3[2]}"
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_acl.www_bk_acl
  ]
}

resource "aws_s3_object" "style_file" {

  bucket = aws_s3_bucket.www_bk.bucket
  key    = "styles.css"
  source = "${var.s3_path}${var.s3[3]}"
  acl    = "public-read"

  depends_on = [
    aws_s3_bucket_acl.www_bk_acl
  ]
}

# 동적 웹 호스팅
resource "aws_s3_bucket_website_configuration" "ogurim_website" {

  bucket = aws_s3_bucket.www_bk.id

  index_document {
    suffix = var.s3[1]
  }

  error_document {
    key = var.s3[2]
  }
}
