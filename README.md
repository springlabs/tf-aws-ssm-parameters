# terraform-aws-ssm-parameters

[![tests](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml/badge.svg)](https://github.com/unfor19/terraform-aws-ssm-parameters/actions/workflows/tests.yml) [![Terraform-Registry](https://img.shields.io/github/v/release/unfor19/terraform-aws-ssm-parameters?color=purple&label=terraform-registry&logo=terraform)](https://registry.terraform.io/modules/unfor19/ssm-parameters/aws/latest)

Create AWS SSM Parameter Store parameters with a Terraform module. The creation/deletion (schema) is managed with Terraform, and the values should be maintained via AWS Console.

To manage AWS SSM Parameters **values** programatically, use [unfor19/parzival](https://github.com/unfor19/parzival#parzival) - *"A CLI that can get/set more than 10 SSM Parameters by path in a single command."*

## Usage

```ruby
module "app_params" {
    source  = "git::https://github.com/springlabs/tf-aws-ssm-parameters.git?ref=0.0.2-c"

    prefix = "/myapp/dev/"

    securestring_parameters = [
        "GOOGLE_CLIENT_ID",
        "GOOGLE_CLIENT_SECRET"
    ]
}
```

<!-- terraform_docs_start -->

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12.31 |
| aws | >= 3.38 |

## Providers

| Name | Version |
|------|---------|
| aws | >= 3.38 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| key_id | When using SecureString, use a specific KMS key | `string` | `"alias/aws/ssm"` | no |
| overwrite | **DANGEROUS** Overwrites parameter if exists, use carefully | `bool` | `false` | no |
| prefix | Set a prefix to all variables, for example: `/myapp/dev/` | `string` | `""` | no |
| securestring_initial_value | Initial value for SecureString(s) | `string` | `"empty"` | no |
| securestring_parameters | List of SecureString(s) | `list(string)` | `[]` | no |
| securestring_tier | Valid values: `Standard`, `Advanced` and `Intelligent-Tiering` | `string` | `"Standard"` | no |

## Outputs

| Name | Description |
|------|-------------|
| securestring_arns | List of SecureString ARNs |
| securestring_names | List of SecureString names |

<!-- terraform_docs_end -->
## Troubleshooting

- **ParameterAlreadyExists** - to overcome this error, you'll have to pass the `overwrite = true` variable. This also means that the current values will be overwritten with the dummy initial value `empty`. This is very dangerous and should be used with cautious.

  ```
  Error: error updating SSM parameter (/myapp/dev/GOOGLE_CLIENT_ID): ParameterAlreadyExists: Parameter /myapp/dev/GOOGLE_CLIENT_ID already exists.
  ```


## Local Development

<details>

<summary>Expand/Collapse</summary>

For local development, we'll use the following services

- [localstack](https://github.com/localstack/localstack) - A fully functional local cloud (AWS) stack
- [unfor19/tfcoding](https://github.com/unfor19/tfcoding) - Triggers a whole terraform pipeline of `terraform init` and `terraform fmt` and `terraform apply` upon changing the file [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf)

### Requirements

- [Docker](https://docs.docker.com/get-docker/)
- [Docker Compose](https://docs.docker.com/compose/install/)

### Development Process

Run `tfcoding` and `localstack` locally with `docker-compose`

```bash
make up-localstack-aws
```

Make changes in [examples/basic/tfcoding.tf](./examples/basic/tfcoding.tf) and save the file

Check the logs of the `tfcoding` Docker container

```bash
# ... omitted for brevity
tfcoding-aws    | Outputs:
tfcoding-aws    |
tfcoding-aws    | securestring_arns = [
tfcoding-aws    |   "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_ID",
tfcoding-aws    |   "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_SECRET",
tfcoding-aws    | ]
tfcoding-aws    | securestring_names = [
tfcoding-aws    |   "/myapp/dev/GOOGLE_CLIENT_ID",
tfcoding-aws    |   "/myapp/dev/GOOGLE_CLIENT_SECRET",
tfcoding-aws    | ]
```

### Test Suite

Execute the script [scripts/tests.sh](./scripts/tests.sh)

```bash
make test
```

Examine the output

```bash
... # omitted for brevity
Outputs:

securestring_arns = [
  "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_ID",
  "arn:aws:ssm:us-east-1:000000000000:parameter/myapp/dev/GOOGLE_CLIENT_SECRET",
]
securestring_names = [
  "/myapp/dev/GOOGLE_CLIENT_ID",
  "/myapp/dev/GOOGLE_CLIENT_SECRET",
]

\e[92m[SUCCESS]\e[0m Test passed as expected
```

**NOTE**: `\e[92m]...\e[0m]` is colorizing the text in CI/CD services logs such as [GitHub Actions](https://github.com/features/actions)

</details>

## Contributing

Report issues/questions/feature requests on the [Issues](https://github.com/unfor19/terraform-aws-ssm-parameters/issues) section.

Pull requests are welcome! These are the steps:

1. Fork this repo
1. Create your feature branch from master (`git checkout -b my-new-feature`)
1. Add the code of your new feature; expand the above *Local Development* section to learn how
1. Run tests on your code, feel free to add more tests
   ```bash
   make test
   ... # All good? Move on to the next step
   ```
1. Commit your remarkable changes (`git commit -am 'Added new feature'`)
1. Push to the branch (`git push --set-up-stream origin my-new-feature`)
1. Create a new Pull Request and provide details about your changes

## Authors

Created and maintained by [Meir Gabay](https://github.com/unfor19)

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/unfor19/terraform-aws-ssm-parameters/blob/master/LICENSE) file for details
