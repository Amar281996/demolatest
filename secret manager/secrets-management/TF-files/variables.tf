variable "region" {
    type = string
    default = "us-east-2"
}
variable "usergroups" {
    type = string
    default = "'arn:aws:iam::916547872461:group/Admin'"
}
variable "account_id" {
    type = string
    default = "eks.amazonaws.com/role-arn: arn:aws:iam::916547872461:role/api-token-access"
}
