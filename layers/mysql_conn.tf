resource "aws_lambda_layer_version" "mysql_connection" {
  filename   = "${path.module}/../../layers/mysql_conn.zip"
  layer_name = "mysql_connection"
  compatible_runtimes = ["python3.11"]
}
