resource "aws_iam_role" "iam_role_for_pricing" {
  name               = "pricing"
  assume_role_policy = file("${path.module}/policies/LambdaAssume.pol")
}

resource "aws_iam_role_policy" "iam_role_policy_for_pricing" {
  name   = "pricing"
  role   = aws_iam_role.iam_role_for_pricing.id
  policy = file("${path.module}/policies/Lambda.pol")
}