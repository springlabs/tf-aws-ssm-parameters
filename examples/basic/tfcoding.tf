
module "app_params" {
  source = "../../../src" # For local development
  # source  = "unfor19/ssm-parameters/aws"
  # version = "0.0.2"

  prefix = "/myapp/dev/"

  securestring_parameters = [
    "GOOGLE_CLIENT_ID",
    "GOOGLE_CLIENT_SECRET"
  ]
}


locals {
  securestring_arns  = module.app_params.securestring_arns
  securestring_names = module.app_params.securestring_names
}
