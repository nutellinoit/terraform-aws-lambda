resource "aws_iam_role" "iam_role_for_lambda" {
  name = "${var.name}_iam_for_lambda"

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": "sts:AssumeRole",
      "Principal": {
        "Service": "lambda.amazonaws.com"
      },
      "Effect": "Allow",
      "Sid": ""
    }
  ]
}
EOF
}

resource "aws_iam_policy" "iam_policy_for_lambda" {
  name_prefix = "${var.name}_iam_policy_for_lambda"

  policy = <<EOF
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": [
                "logs:CreateLogGroup",
                "logs:CreateLogStream",
                "logs:PutLogEvents"
            ],
            "Resource": "arn:aws:logs:*:*:*"
        }
    ]
}
EOF
}

resource "aws_iam_role_policy_attachment" "iam_lambda_main_policy" {
  role       = "${aws_iam_role.iam_role_for_lambda.name}"
  policy_arn = "${aws_iam_policy.iam_policy_for_lambda.arn}"
}

resource "null_resource" "prepare_lambda" {
  provisioner "local-exec" {
    command = "cd ${path.module}/source/ && zip -q -r ${var.name}${var.lambda_version}.zip ."
  }

  triggers {
    lambda_version = "${var.lambda_version}"
  }
}

resource "aws_lambda_function" "lambda" {
  filename      = "${path.module}/source/${var.name}${var.lambda_version}.zip"
  function_name = "${var.name}"
  role          = "${aws_iam_role.iam_role_for_lambda.arn}"

  handler = "index.handler"
  runtime = "nodejs6.10"
  timeout = 20

  tags = "${merge(map("Name", ${var.name}), map("Version", var.lambda_version) ,var.tags_as_map)}"

  environment {
    variables = {
      environment_1 = "${var.environment_1}"
      environment_2 = "${var.environment_2}"
      environment_3 = "${var.environment_3}"
    }
  }

  lifecycle {
    ignore_changes = ["last_modified"]
  }

  depends_on = ["null_resource.prepare_lambda"]
}
