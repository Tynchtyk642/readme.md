# Terraform GCP Network

## **This codes will create:**

1. ### VPC with 3 Subnetwork:
    - _Presentation Subnetwork (public)_
    - _Application Subnetwork (private)_
    - _Database Subnetwork (private)_
2. ### Route to IGW (egress to internet from resource tagged ***"public"***)
3. ### 3 Firewall Rules:
    - Public Subnet open to all externall traffic (for ***"public"*** tagged resource)
    - Application Subnet receive traffic from private IPs originating from the Public Subnet (to resource tagged ***"application"***)
    - Database Subnet receive traffic from private IPs originating from the application subnet (to resource tagged ***"database"***)
    
## **Usage**
```terraform
module "network" {
  source                          = "./network"
  delete_default_routes_on_create = true

  subnets = [
    {
      subnet_name     = "presentation-subnet"
      subnet_ip_range = "10.0.0.0/24"
      subnet_region   = "us-central1"
    },
    {
      subnet_name           = "application-subnet"
      subnet_ip_range       = "10.0.1.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = true
    },
    {
      subnet_name           = "database-subnet"
      subnet_ip_range       = "10.0.2.0/24"
      subnet_region         = "us-central1"
      subnet_private_access = true
    },
  ]

  routes = [
    {
      name              = "igw-route"
      destination_range = "0.0.0.0/0"
      tags              = "public"
      next_hop_internet = "true"
    }
  ]

  firewall_rules = [
  {
    name        = "presentation-firewall-rule"
    direction   = "INGRESS"
    ranges      = ["10.0.1.0/24"]
    target_tags = ["public"]
    source_tags = null

    allow = [ {
      protocol = "all"
      ports    = null
    }]
    deny = []
  },
  {
    name        = "application-firewall-rule"
    direction   = "INGRESS"
    ranges      = ["10.0.2.0/24"]
    target_tags = ["application"]
    source_tags = null

    allow = [{
      protocol = "all"
      ports    = null
    }]
    deny = []
    
  },
  {
    name        = "database-firewall-rule"
    direction   = "INGRESS"
    ranges      = ["10.0.3.0/24"]
    source_tags = null
    target_tags = ["database"]

    allow = [{
      protocol = "all"
      ports    = null
    }]
    deny = []
  },
]
}

```

Then perform the following commands on the root folder:
- `terraform init`
- `terraform plan` to see the infrastructure plan
- `therraform apply` to apply infastructure build
- `terraform destroy` to destroy the build infastructure

## **VPC Inputs**

| Name | Description |  Type  |
| ---- | :---------: | ------ | 
| gcp_vpc_name | The name of created VPC | `string` |
|auto_create_subnetworks| It will create a subnet for each region automatically accross the CIDR-block range, if it is "true" | `bool` |
|routing_mode| The network routing mode | `string` |
|delete_default_routes_on_create | If set "true", default routes (0.0.0.0/0) will be deleted immediately after network creation. | `bool` |

## **Subnet Inputs**
| Name | Description |  Type  |
| ---- | :---------: | ------ | 
| subnet_name | The name of the subnet being created | `string` |
| subnet_ip_range | The IP and CIDR range of the subnet being created | `string` |
| subnet_region | The region where the subnet will be created | `string` |
| subnet_private_access | Whether this subnet will have private Google access enabled | `string` |

## **Routes Inputs**
| Name | Description |  Type  |
| ---- | :---------: | ------ | 
