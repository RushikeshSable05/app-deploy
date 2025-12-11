variable "deployment" {
  description = "Inputs required for foundation. Fields are optional to support partial deployments."
  type = object({
    rg_name            = optional(string)
    location           = optional(string)
    vnet_name          = optional(string)
    vnet_address_space = optional(list(string))
    subnet_name        = optional(string)
    subnet_prefix      = optional(string)
    tags               = optional(map(string), {})
  })
}
