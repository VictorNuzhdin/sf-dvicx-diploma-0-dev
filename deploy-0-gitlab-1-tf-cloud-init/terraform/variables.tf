variable "my_example_var" {
  type        = string
  default     = "This is an example Terraform variable"
  description = "(optional) Sets some example variable"
}

variable "yc_token" {
  type        = string
  default     = ""
  description = "(required) Sets Yandex Cloud IAM auth token"
  sensitive = true
}

variable "yc_cloud_id" {
  type        = string
  default     = ""
  description = "(required) Sets Yandex Cloud Cloud ID"
  sensitive = true
}

variable "yc_folder_id" {
  type        = string
  default     = ""
  description = "(required) Sets Yandex Cloud Folder ID"
  sensitive = true
}
