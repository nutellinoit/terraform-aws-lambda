variable "name" {
  description = "(Required) The name used for the lambda and other related resources"
}

variable "lambda_version" {
  description = "(Required) Lambda Version"
}

variable "tags_as_map" {
  default     = {}
  description = "(optional) A map of tags to apply to created resources."
}

variable "environment_1" {
  type = "string"
}

variable "environment_2" {
  type = "string"
}

variable "environment_3" {
  type = "string"
}
