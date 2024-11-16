# S3 버킷 생성
resource "aws_s3_bucket" "istory-deploy-bucket" {
  bucket = "istory-deploy-bucket-${data.aws_caller_identity.current.account_id}"  # 고유한 버킷 이름 필요
}

# S3 버킷 버전 관리 설정
resource "aws_s3_bucket_versioning" "deploy_bucket_versioning" {
  bucket = aws_s3_bucket.istory-deploy-bucket.id
  versioning_configuration {
    status = "Enabled"
  }
}

# S3 버킷 이름 출력
output "istory-deploy-bucket_name" {
  value       = aws_s3_bucket.istory-deploy-bucket.id
  description = "Name of the S3 bucket for deployments"
}