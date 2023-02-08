# Contributing

## Install Dependencies

1. Install the Terraform pre commits from https://github.com/antonbabenko/pre-commit-terraform.

    Example MacOs:
    ```
    brew install pre-commit terraform-docs tflint tfsec coreutils checkov terrascan infracost jq fugue/regula/regula
    ```
1. Install pre commits.
    ```
    pre-commit install
    ```
1. Run pre commits.
    ```
    pre-commit run --all-files
    ```
1. Run Terraform security checks.
    ```
    checkov --directory . --skip-check CKV_AWS_18,CKV_AWS_21,CKV_AWS_144,CKV_AWS_145
    regula run --exclude FG_R00101 --exclude FG_R00274 --exclude FG_R00275
    terrascan scan
    ```

## Pull Request Process

1. Run pre-commit hooks `pre-commit run -a`.
1. Create a pull request.
1. Address comments and checklist items.
1. When you are ready to merge your PR, ensure that the commit message is the PR title.

## Pull Request Title Format

`<type>: [<jira ticket ID>] short description`

See below for a list of Conventional Commit types.

Example.

`infra: [DEV-XXX] add this feature`

To generate changelog, pull requests or commits must start with a [conventional commit] type

- `build:` for CI purpose
- `chore:` for chores stuff
- `docs:` for documentation and examples
- `feat:` for new features
- `fix:` for bug fixes
- `infra:` for infrastructure changes
- `refactor:` for code refactoring, neither fixes a bug or adds a feature
- `style:` for white-space, formatting, missing semi-colons, etc
- `test:` for tests

[conventional commit]: https://www.conventionalcommits.org/en/v1.0.0/

## Template GitHub Repository

Add the template repository as a remote repository.
```
git remote add template git@github.com:springlabs/tf-template.git
```

When you want to pull the latest changes from the template repository, checkout
a new branch.
```
git checkout -b build/JIRA-123-template-updates
```
Pull the changes.
```
git pull template main --allow-unrelated-histories
```
Push the branch to your remote repository and open a PR.
