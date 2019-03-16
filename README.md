# Generic AWS Lambda Terraform Module  

Use this repository as lambda module skeleton.

Modifiy null resource `prepare_lambda` for your language of choice and packaging procedure.

Use like this:

```
module "lambda-skeleton"{
  source = "git::https://github.com/nutellinoit/terraform-aws-lambda-skeleton.git?ref=master"
  lambda_version = "1" # change this value to trigger another deploy
  name = "CoolLambda"
  environment_1 = "1"
  environment_2 = "2"
  environment_3 = "3"
}
```