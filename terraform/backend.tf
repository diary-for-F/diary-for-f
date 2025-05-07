resource "aws_s3_bucket" "tf_state" {
  bucket = "diary-for-f-tf-state-bucket"

  tags = {
    Name        = "diary-for-f-tf-state-bucket"
    Description = "Terraform state bucket for diary-for-f"
  }
}
