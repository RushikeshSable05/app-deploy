variable "deployment" {
  description = "Inputs for compute (vm, nic, public ip) - expects foundation resources already present"
  type = object({
    rg_name            = string
    location           = string
    vnet_name          = string
    subnet_name        = string
    vm_name            = string
    vm_size            = string
    admin_username     = string
    admin_ssh_key_path = string
    create_public_ip   = optional(bool, true)
    tags               = map(string)
  })
}
