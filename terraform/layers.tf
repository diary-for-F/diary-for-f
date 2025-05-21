# NOTE: Before creating Lambda Layer, Please read `terraform/src/layers/README.md` first.
# Creating zip file is needed before creating Lambda Layer resource.

resource "aws_lambda_layer_version" "mysql_connection" {
  layer_name       = "mysql_connection"
  description      = "Layer to connect MySQL. (Including PyMySQL)"
  filename         = "${path.module}/src/layers/mysql_conn/layer.zip"
  source_code_hash = filebase64sha256("${path.module}/src/layers/mysql_conn/layer.zip")
}
