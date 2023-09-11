resource "aws_organizations_account" "dev" {
  # A friendly name for the member account
  name  = "test-account"
  email = "gregscarrolL@mgail.com"

  # Enables IAM users to access account billing information 
  # if they have the required permissions
  iam_user_access_to_billing = "ALLOW"

  tags = {
    Name  = "test-account"
    Owner = "Greg Carroll"
    Role  = "development"
  }

  parent_id = aws_organizations_organizational_unit.dev.id
}