resource "aws_iam_user" "devops_user" {
  name          = "devops_trainer"
  path          = "/"
  force_destroy = true
}

resource "aws_iam_user_login_profile" "user_console" {
  user    = aws_iam_user.devops_user.name
}

output "passwd" {
  value = aws_iam_user_login_profile.user_console.password
}


resource "aws_iam_policy" "region_policy" {
  name        = "region_policy"
  path        = "/"
  description = "My region policy"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = file("C:\\Users\\muddu\\Desktop\\Terraform\\region-policy.json")
}

resource "aws_iam_policy_attachment" "region-policy-attach" {
  name       = "attach-policy"
  users      = [aws_iam_user.devops_user.name]
  policy_arn = aws_iam_policy.region_policy.arn

  depends_on = [ aws_iam_policy.region_policy ]
}