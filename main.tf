terraform {
  required_providers {
    desec = {
      source  = "Valodim/desec"
      version = "0.5.0"
    }
  }
}

provider "desec" {
  api_token = var.desec_api_token
}
