# Define the local for the policy name
locals {
  policy_name = var.name_prefix
}

resource "aws_secretsmanager_secret" "default" {
  name = "${var.name_prefix}-secrets"


  tags = {
    Microservice = "${var.name_prefix}"
    Cluster      = "${var.ecs_cluster_name}"
  }
}

resource "aws_secretsmanager_secret_version" "default" {
  secret_id     = aws_secretsmanager_secret.default.id
  secret_string = jsonencode(var.placeholder_secrets)

  lifecycle {
    ignore_changes = [secret_string]
  }
}

resource "aws_iam_policy" "secrets_access" {
  name = local.policy_name
  policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Action" : [
          "secretsmanager:GetResourcePolicy",
          "secretsmanager:GetSecretValue",
          "secretsmanager:DescribeSecret",
          "secretsmanager:ListSecretVersionIds"
        ],
        "Effect" : "Allow",
        "Resource" : [
          aws_secretsmanager_secret.default.arn
        ]
      }
    ]
  })

  lifecycle {
    prevent_destroy = false
  }

  tags = {
    Name = local.policy_name
  }
}


resource "aws_iam_role_policy_attachment" "secret_access" {
  role       = aws_iam_role.execution.name
  policy_arn = aws_iam_policy.secrets_access.arn
}
