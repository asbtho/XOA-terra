# provider.tf
terraform {
  required_providers {
    xenorchestra = {
      source = "terra-farm/xenorchestra"
    }
  }
}

# Configure the XenServer Provider
provider "xenorchestra" {
  # Must be ws or wss
  url      = "ws://192.16" # Or set XOA_URL environment variable
  username = ""              # Or set XOA_USER environment variable
  password = ""              # Or set XOA_PASSWORD environment variable

  # This is false by default and
  # will disable ssl verification if true.
  # This is useful if your deployment uses
  # a self signed certificate but should be
  # used sparingly!
  insecure = true                     # Or set XOA_INSECURE environment variable to any value
}