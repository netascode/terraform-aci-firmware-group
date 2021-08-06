module "aci_firmware_group" {
  source = "netascode/firmware-group/aci"

  name     = "UG1"
  node_ids = [101, 103]
}
