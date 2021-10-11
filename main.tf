resource "aci_rest" "firmwareFwP" {
  dn         = "uni/fabric/fwpol-${var.name}"
  class_name = "firmwareFwP"
  content = {
    name = var.name
  }
}

resource "aci_rest" "firmwareFwGrp" {
  dn         = "uni/fabric/fwgrp-${var.name}"
  class_name = "firmwareFwGrp"
  content = {
    name = var.name
    type = "range"
  }
}

resource "aci_rest" "firmwareRsFwgrpp" {
  dn         = "${aci_rest.firmwareFwGrp.dn}/rsfwgrpp"
  class_name = "firmwareRsFwgrpp"
  content = {
    tnFirmwareFwPName = var.name
  }
}

resource "aci_rest" "fabricNodeBlk" {
  for_each   = toset([for id in var.node_ids : tostring(id)])
  dn         = "${aci_rest.firmwareFwGrp.dn}/nodeblk-${each.value}"
  class_name = "fabricNodeBlk"
  content = {
    name  = each.value
    from_ = each.value
    to_   = each.value
  }
}
