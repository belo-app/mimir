# ops infra terraform

## Local development

1. Create a `.env` file with the following

```bash
#!/bin/bash

# Terraform Environment
export TERRAFORM_ENVIRONMENT="svc"

# AWS
export AWS_ACCESS_KEY_ID="<aws-access-key>"
export AWS_SECRET_ACCESS_KEY="<aws-secret-key>"
# or set profile if creds are in ~/.aws/credentials
export AWS_PROFILE="<aws-profile>"    


```

2. Export the variables

```bash
$ source .env
```

3. Initialize the terraform

```bash
$ make tf-init
```

4. Make and check your changes on the tf files

```bash
$ make tf-validate
$ make tf-fmt
$ make tf-plan
```

5. You can also manually `apply` and `destroy` the changes

```bash
$ make tf-apply
$ make tf-destroy
```

