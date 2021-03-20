  
terraform {
  required_version = "~> 0.14"
  
  required_providers {
    vault = {
      source = "hashicorp/vault"
      version = "~> 2.19"
    }
  }
}

locals {
  name = var.name
  path = format("%s/%s", var.path_prefix, var.name)
  description = coalesce(var.description, format("%s Certificate Authority", var.name))
  urls_prefix = var.urls_prefix
}

module "root" {
  count = var.parent_ca = "" ? 1 : 0
  
  source = "github.com/Terraform-Modules-Lib/terraform-vault-pki_root_ca"
  
  name = local.name
  path = local.path
  description = local.description
  urls_prefix = local.urls_prefix
}
  
module "intermediate" {
  count = var.parent_ca = "" ? 0 : 1
  
  source = "github.com/Terraform-Modules-Lib/terraform-vault-pki_intermediate_ca"
  
  name = local.name
  path = local.path
  description = local.description
  urls_prefix = local.urls_prefix
  
  parent_ca = var.parent_ca
}
  
locals {
  authority = try(module.root[0].authority, module.intermediate[0].authority)
}