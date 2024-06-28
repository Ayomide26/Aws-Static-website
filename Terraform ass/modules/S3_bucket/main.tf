resource "aws_s3_bucket" "vicky-bucket-try" {
  bucket = "vicky-bucket-try"
}
resource "aws_s3_bucket_public_access_block" "access" {
  bucket = "vicky-bucket-try"

  block_public_acls = false
  block_public_policy = false
  ignore_public_acls = false
  restrict_public_buckets = false
}
resource "aws_s3_bucket_policy" "bucket_policy" {
  bucket = aws_s3_bucket.vicky-bucket-try.id

  policy = jsonencode({
    "Version" = "2012-10-17"
    "Statement" = [
      {
        "Sid": "PublicReadGetObject",
        "Effect"    = "Allow"
        "Principal" = "*"
        "Action"    = ["s3:GetObject" 
        ],
        "Resource"  = "arn:aws:s3:::vicky-bucket-try/*"
      }
    ]
  })
}

resource "aws_s3_object" "upload" {
  bucket = aws_s3_bucket.vicky-bucket-try.id
  key = "index.html"
  source = "./modules/S3_bucket/index.html"
}
# resource "aws_s3_bucket_policy" "bucket_policy" {
#   bucket = aws_s3_bucket.vicky_aws_bucket.bucket
#   policy = jsonencode({
#     version = "2012-10-17"
#     statement = [
#       {
#         Effect = "Allow"
#         principal = "*"
#         Action = [
#               "s3:GetObject"
#            ]
#            Resource = [
#            "${aws_s3_bucket.vicky_aws_bucket.arn}/*" ]
#       },
#     ]
#   }

#   )
# }
resource "aws_s3_bucket_website_configuration" "website" {
  bucket = aws_s3_bucket.vicky-bucket-try.bucket

  index_document{
     suffix = "index.html"


  }
  error_document {
    key ="error.html"
  }
}
