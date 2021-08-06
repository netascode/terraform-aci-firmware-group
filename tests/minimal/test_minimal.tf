terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name = "UG1"
}

data "aci_rest" "firmwareFwGrp" {
  dn = "uni/fabric/fwgrp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "firmwareFwGrp" {
  component = "firmwareFwGrp"

  equal "name" {
    description = "name"
    got         = data.aci_rest.firmwareFwGrp.content.name
    want        = module.main.name
  }

  equal "type" {
    description = "type"
    got         = data.aci_rest.firmwareFwGrp.content.type
    want        = "range"
  }
}

data "aci_rest" "firmwareFwP" {
  dn = "uni/fabric/fwpol-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "firmwareFwP" {
  component = "firmwareFwP"

  equal "name" {
    description = "name"
    got         = data.aci_rest.firmwareFwP.content.name
    want        = module.main.name
  }
}
