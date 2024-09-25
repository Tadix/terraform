resource "random_password" "db_password" {
  length  = 16
  special = true
  override_special = "!#$%&*()-_=+[]"
}

resource "aws_secretsmanager_secret" "db_password_secret" {
  name = "db_secret_4"
}

resource "aws_secretsmanager_secret_version" "db_password_id" {
  secret_id = aws_secretsmanager_secret.db_password_secret.id
  secret_string = jsonencode(
    {
      "username" = "tadix",
      "password" = random_password.db_password.result
    }
  )
}

data "aws_secretsmanager_secret" "tadix_secret_key" {
  arn = aws_secretsmanager_secret.db_password_secret.arn
}
data "aws_secretsmanager_secret_version" "tadix_secret_id" {
  secret_id = data.aws_secretsmanager_secret.tadix_secret_key.id
}

output "db_password" {
  value = jsondecode(data.aws_secretsmanager_secret_version.tadix_secret_id.secret_string)
}