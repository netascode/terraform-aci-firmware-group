module "aci_firmware_group" {
  source  = "netascode/firmware-group/aci"
  version = ">= 0.0.1"

  name     = "UG1"
  node_ids = [101, 103]
}
