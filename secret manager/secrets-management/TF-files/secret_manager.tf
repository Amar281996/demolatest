resource "aws_secretsmanager_secret" "datasecrets_manager" {
  name = "data-secret"
}
variable "events" {
  default = {
    events_service_mysql_user_id = "amar"
    events_service_mysql_password = "Amar123"
  }

  type = map(string)
}
variable "email" {
  default = {
    email_service_mysql_user_id = "chowdary"
    email_service_mysql_password = "chowdary123"
  }

  type = map(string)
}

resource "aws_secretsmanager_secret_version" "secret-events" {
  secret_id     = aws_secretsmanager_secret.datasecrets_manager.id
  secret_string = jsonencode(var.events)
}
resource "aws_secretsmanager_secret_version" "secret-email" {
  secret_id     = aws_secretsmanager_secret.datasecrets_manager.id
  secret_string = jsonencode(var.email)
}


#policy for secret manager
resource "aws_iam_policy" "secret_policy" {
  name = "webidentity_policy"
  policy = jsonencode({

    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "VisualEditor0",
            "Effect": "Allow",
            "Action": [
                "secretsmanager:GetResourcePolicy",
                "secretsmanager:GetSecretValue",
                "secretsmanager:DescribeSecret",
                "secretsmanager:ListSecretVersionIds"
            ],
            "Resource": "${var.policy_arn}"
        },
        
        {
            "Sid": "VisualEditor1",
            "Effect": "Allow",
            "Action": "secretsmanager:GetRandomPassword",
            "Resource": "*"
        }
    ]
})

}


resource "aws_iam_role" "secret_role" {
  name = "webidentity_role"
  assume_role_policy = jsonencode({

    "Version": "2012-10-17",
    "Statement": [
        {
            "Effect": "Allow",
            "Action": "sts:AssumeRoleWithWebIdentity",
            "Principal": {
                "Federated": "${var.role_arn}"
            },
            "Condition": {
                "StringEquals": {
                    "oidc.eks.var.region.amazonaws.com/id/4C22906E92E231FFD3077D2247F8C4D5:aud": [
                        "sts.amazonaws.com"
                    ]
                }
            }
        }
    ]
  })
}
resource "aws_iam_role_policy_attachment" "test-attach" {
  role       = aws_iam_role.secret_role.name
  policy_arn = aws_iam_policy.secret_policy.arn
}

output "ASCP_installation" {
  value = "${aws_secretsmanager_secret_version.secret-events.arn}"
}
output "secret_arn" {
  value = "${aws_secretsmanager_secret_version.secret-events.arn}"
}
output "csi-driver" {
  value = "${null_resource.csi_installation}"
}
output "csi_driver_status" {
  value = "${null_resource.csi_installation}"
}

output "pod_logs" {
  value = "${null_resource.file_verfication}"
}
output "pod_file" {
  value = "${null_resource.file_verfication}"
}





