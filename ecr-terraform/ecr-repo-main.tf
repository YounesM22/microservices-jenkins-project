provider "aws" {
  region = "us-east-1"
}

locals {
  services = [
    "frontend",
    "cartservice",
    "productcatalogservice",
    "paymentservice",
    "checkoutservice",
    "adservice",
    "currencyservice",
    "emailservice",
    "shippingservice",
    "recommendationservice",
    "loadgenerator"
  ]
}

resource "aws_ecr_repository" "services" {
  for_each = toset(local.services)

  name = each.value

  image_scanning_configuration {
    scan_on_push = true
  }

  encryption_configuration {
    encryption_type = "AES256"
  }

  force_delete = true

  tags = {
    Environment = "production"
    Service     = each.value
  }
}
