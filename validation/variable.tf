variable "instanceType" {
  type    = string
  default = "t2.nano"

  validation {
    condition     = can(regex("^[Tt][2-3].(micro|small)", var.instanceType))
    error_message = "Invalid Instance type. You can only choose - t2.micro, t2.small"
  }
}
