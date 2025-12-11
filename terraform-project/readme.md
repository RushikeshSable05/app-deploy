Project layout (exact)

terraform-project/
├── terraform-azurerm-foundation/
│   ├── versions.tf
│   ├── variables.tf
│   ├── resource_groups.tf
│   ├── vnet.tf
│   ├── subnet.tf
│   └── outputs.tf
│
├── terraform-azurerm-compute/
│   ├── versions.tf
│   ├── variables.tf
│   ├── nic.tf
│   └── vm.tf
│
└── vm-deployment/
    └── app/
        ├── main.tf
        └── terraform.tfvars.json
