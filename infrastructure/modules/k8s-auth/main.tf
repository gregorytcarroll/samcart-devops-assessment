data "aws_iam_policy_document" "kube-admin-policy-document" {
  statement {
    sid       = "AllowAllEKScommands"
    effect    = "Allow"
    resources = ["*"]
    actions   = ["eks:*"]
  }
}

resource "aws_iam_policy" "kube-admin-policy" {
  name   = "kube-admin-policy"
  policy = data.aws_iam_policy_document.kube-admin-policy-document.json
}

data "aws_iam_policy_document" "kube-admin-role-assume-policy-document" {
   statement {
    effect  = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      identifiers = [var.iam_user_arn_root]
      type        = "AWS"
    }
  }
}

resource "aws_iam_role_policy_attachment" "kube-admin-role-eks-fullaccess-policy-attach" {
  policy_arn = aws_iam_policy.kube-admin-policy.arn
  role       = aws_iam_role.kube-admin-iam-role.name
}

resource "aws_iam_role" "kube-admin-iam-role" {
  name               = "kube-admin-role"
  assume_role_policy = data.aws_iam_policy_document.kube-admin-role-assume-policy-document.json
  max_session_duration = 43200
}
