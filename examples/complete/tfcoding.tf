
module "app_params" {
  source = "../../../src" # For local development
  # source  = "unfor19/ssm-parameters/aws"
  # version = "0.0.2"

  prefix    = "/myapp/dev/"
  overwrite = true # Use with caution
  key_id    = "alias/aws/ssm"

  securestring_tier = "Standard"

  securestring_parameters = [
    "GOOGLE_CLIENT_ID",
    "GOOGLE_CLIENT_SECRET"
  ]

  securestring_initial_value = "wonka"
}


locals {
  securestring_arns  = module.app_params.securestring_arns
  securestring_names = module.app_params.securestring_names
}
