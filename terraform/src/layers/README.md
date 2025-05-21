# How to create Layers

1. Create a directory of your new layer.
2. Write a `requirements.txt` in your directory.
3. run below command to create zip file of your layer.

```
cd terraform/src/layers/{YOUR DIRECTORY}
mkdir python
pip install -r requirements.txt -t python/
zip -r layer.zip python/
```

4. Create an Layer resource in `lambda_layers.tf`
5. Delete python packages in `python/`.

```
rm -r python/
```

# Example

This example explains how to create layers for **Database connection**.

1. Create a directory for layer.

```
cd terraform/src/layers
mkdir mysql_conn

```

2. Write `requirements.txt`.

```
# requirements.txt
PyMySQL==1.1.1
```

3. Create `layer.zip` file in your layer's directory.

```
mkdir python
pip install -r requirements.txt -t python/
zip -r layer.zip python/
```

4. Create an Layer resource in `lambda_layers.tf`

```
resource "aws_lambda_layer_version" "example" {
  layer_name       = "test_lambda_layer"
  description      = "This is test lambda layer."
  filename         = "${path.module}/src/layers/db_conn/layer.zip"
  source_code_hash = filebase64sha256("${path.module}/src/layers/db/conn/layer.zip")
}
```

5. Delete raw python package in `python/`. We only need zip file.

```
rm -rf python/
```
