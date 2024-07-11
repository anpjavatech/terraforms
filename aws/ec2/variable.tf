//string
variable "instanceType" {
  type        = string
  default     = "t2.nano"
  description = "Instance type of the resource."
}

//number
variable "instanceCount" {
  type        = number
  default     = 1
  description = "No:of instance need to create."
}

//boolean
variable "enable_public_ip" {
  type        = bool
  default     = true
  description = "Enable public IP for the new resource."
}

variable "accesskey" {
  type        = string
  description = "Access key to aws provider"
}

variable "secretkey" {
  type        = string
  description = "Secret key to aws provider"
}
