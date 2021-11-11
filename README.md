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
  source = "./network"
  delete_default_routes_on_create = true

  subnets = [
    {
      subnet_name = "presentation-subnet"
      subnet_ip_range = "10.0.0.0/24"
      subnet_region = "us-central1"
    },
    {
      subnet_name = "application-subnet"
      subnet_ip_range = "10.0.1.0/24"
      subnet_region = "us-central1"
      subnet_private_access = true
    },
    {
      subnet_name = "database-subnet"
      subnet_ip_range = "10.0.2.0/24"
      subnet_region = "us-central1"
      subnet_private_access = true
    },
  ]

  routes = [
    {
      name = "igw-route"
      destination_range = "0.0.0.0/0"
      tags = "public"
      next_hop_internet = "true"
    }
  ]

  firewall_rules = [
  {
    name = "presentation-firewall-rule"
    direction = "INGRESS"
    ranges = ["10.0.1.0/24"]
    target_tags = ["public"]
    source_tags = null

    allow = [ {
      protocol = "all"
      ports = null
    }]
    deny = []
  },
  {
    name = "application-firewall-rule"
    direction = "INGRESS"
    ranges = ["10.0.2.0/24"]
    target_tags = ["application"]
    source_tags = null

    allow = [{
      protocol = "all"
      ports = null
    }]
    deny = []
    
  },
  {
    name = "database-firewall-rule"
    direction = "INGRESS"
    ranges = ["10.0.3.0/24"]
    source_tags = null
    target_tags = ["database"]

    allow = [{
      protocol = "all"
      ports = null
    }]
    deny = []
  },
]
}

```

## **Inputs**

| Name | Description |  Type  | Default |
|  |
| dfjldfj |
| ------- |