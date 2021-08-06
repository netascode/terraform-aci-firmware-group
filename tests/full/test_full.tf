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

  name     = "UG1"
  node_ids = [101]
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

data "aci_rest" "firmwareRsFwgrpp" {
  dn = "${data.aci_rest.firmwareFwGrp.id}/rsfwgrpp"

  depends_on = [module.main]
}

resource "test_assertions" "firmwareRsFwgrpp" {
  component = "firmwareRsFwgrpp"

  equal "tnFirmwareFwPName" {
    description = "tnFirmwareFwPName"
    got         = data.aci_rest.firmwareRsFwgrpp.content.tnFirmwareFwPName
    want        = module.main.name
  }
}

data "aci_rest" "fabricNodeBlk" {
  dn = "${data.aci_rest.firmwareFwGrp.id}/nodeblk-101"

  depends_on = [module.main]
}

resource "test_assertions" "fabricNodeBlk" {
  component = "fabricNodeBlk"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricNodeBlk.content.name
    want        = "101"
  }

  equal "from_" {
    description = "from_"
    got         = data.aci_rest.fabricNodeBlk.content.from_
    want        = "101"
  }

  equal "to_" {
    description = "to_"
    got         = data.aci_rest.fabricNodeBlk.content.to_
    want        = "101"
  }
}
