
# Global Config
variable "overwrite" {
  type        = bool
  default     = false
  description = "**DANGEROUS** Overwrites parameter if exists, use carefully"
}

variable "prefix" {
  type        = string
  default     = ""
  description = "Set a prefix to all variables, for example: `/myapp/dev/`"
}

# SecureString Config
variable "key_id" {
  type        = string
  default     = "alias/aws/ssm"
  description = "When using SecureString, use a specific KMS key"
}

# Tiers
variable "securestring_tier" {
  type        = string
  default     = "Standard"
  description = "Valid values: `Standard`, `Advanced` and `Intelligent-Tiering`"
}

# Parameters
variable "securestring_parameters" {
  type        = list(string)
  default     = []
  description = "List of SecureString(s)"
}

# Initial Value
variable "securestring_initial_value" {
  type        = string
  default     = "empty"
  description = "Initial value for SecureString(s)"
}

# Locals - all variables are fetched as locals to allow manipulation of values in future versions

locals {
  # Global Config
  prefix    = var.prefix != "" ? var.prefix : ""
  overwrite = var.overwrite

  # SecureString Config
  key_id = var.key_id

  # Tier
  securestring_tier = var.securestring_tier

  # Parameters
  securestring_parameters = var.securestring_parameters

  # Initial Value
  securestring_initial_value = var.securestring_initial_value
}
