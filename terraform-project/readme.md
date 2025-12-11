Project layout (exact)

terraform-project/
│
├─ terraform-azurerm-foundation/        # ONE foundation module
│   ├─ rg.tf
│   ├─ vnet.tf
│   ├─ subnet.tf
│   ├─ variables.tf       ← uses optional() so resources deploy individually
│   ├─ outputs.tf
│   └─ versions.tf
│
├─ terraform-azurerm-compute/           # VM module
│   ├─ vm.tf
│   ├─ nic.tf
│   ├─ public_ip.tf
│   ├─ data_lookup.tf
│   ├─ variables.tf
│   ├─ outputs.tf
│   └─ versions.tf
│
├─ resource-deployment/                 # Deploy resources independently
│   ├─ resource_groups/
│   │   └─ app/
│   │       ├─ main.tf
│   │       └─ terraform.tfvars.json
│   │
│   ├─ virtual_networks/
│   │   └─ app/
│   │       ├─ main.tf
│   │       └─ terraform.tfvars.json
│   │
│   └─ subnets/
│       └─ app/
│           ├─ main.tf
│           └─ terraform.tfvars.json
│
├─ vm-deployment/
│   └─ <vm-name>/
│       └─ app/
│           ├─ main.tf
│           └─ terraform.tfvars.json
│
└─ README.md
