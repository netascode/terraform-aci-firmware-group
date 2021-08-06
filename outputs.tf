output "dn" {
  value       = aci_rest.firmwareFwGrp.id
  description = "Distinguished name of `firmwareFwGrp` object."
}

output "name" {
  value       = aci_rest.firmwareFwGrp.content.name
  description = "Firmware group name."
}
