Static website on S3
=====================================
Terraform / AWS / BATS framework  [![Continuous Integration status](https://circleci.com/gh/mhakimov/wrth-app.svg?style=shield)](https://app.circleci.com/pipelines/github/mhakimov/w0rth-app)

The project publishes web content, and creates IAM users, groups and policies. It is deployed by [CircleCI pipeline](https://app.circleci.com/pipelines/github/mhakimov/w0rth-app) and verified by Bash automated tests.

## Configuration

To run and test the project one will need an AWS account and the following environment variables to be set:

ALICE_ACCESS_KEY	

ALICE_SECRET_KEY	

AWS_ACCESS_KEY_ID	

AWS_SECRET_ACCESS_KEY	

BOBBY_ACCESS_KEY	

BOBBY_SECRET_KEY	

BUCKET_NAME	

BUCKET_WEBSITE_ENDPOINT	

CHARLIE_ACCESS_KEY	

CHARLIE_SECRET_KEY	

DISTRIBUTION_DOMAIN_NAME	

TF_VAR_domain_name

## Launching tests
    ./tests/test/bats/bin/bats tests/test/marketing-tests.bats
    ./tests/test/bats/bin/bats tests/test/content-editor-tests.bats
    ./tests/test/bats/bin/bats tests/test/hr-tests.bats
    ./tests/test/bats/bin/bats tests/test/webpage-tests.bats

## Images

![website][screenshot1]
![terraform-initialisation][screenshot2]
![test-run][screenshot3]

[screenshot1]: https://raw.githubusercontent.com/mhakimov2/images/main/s3_hosted_website.png
[screenshot2]: https://raw.githubusercontent.com/mhakimov2/images/main/terraform-init.png
[screenshot3]: https://raw.githubusercontent.com/mhakimov2/images/main/test-run.png
     