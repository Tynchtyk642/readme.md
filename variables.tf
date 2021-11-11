
// Write to "default" the project name where the resource will created
variable "project_id" {
  type    = string
  default = ""
}

// Write to "default" the path to your credentials file
variable "credentials_file" {
  type    = string
  default = "credentials.json"
}

// Write to "default" the region where by default your resource will created
variable "region" {
  type    = string
  default = "us-central1"
}

// Write to "default" the zone where by default your resource will will created
variable "zone" {
  type    = string
  default = "us-central1-b"
}

#====================================== VPC ============================================
variable "delete_default_routes_on_create" {
  description = "If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false."
  type        = bool
  default     = true
}



#============================= SUBNETWORKS VARIABLES ===================================

#--------------------------------- PRESENTATION ----------------------------------------
variable "presentation_ip_range" {
  description = "IP range of Presentation subnetwork"
  type        = string
  default     = "10.0.1.0/24"
}

#--------------------------------- APPLICATION -----------------------------------------
variable "application_ip_range" {
  description = "IP range of Application subnetwork"
  type        = string
  default     = "10.0.2.0/24"
}
#----------------------------------- DATABASE ------------------------------------------
variable "database_ip_range" {
  description = "IP range of Database subnetwork"
  type        = string
  default     = "10.0.3.0/24"
}


#================================== ROUTES VARIABLE ====================================
variable "igw_destination" {
  description = "The destination range of outgoing packets that this route applies to. Only IPv4 is supported"
  type        = string
  default     = "0.0.0.0/0"
}




#============================ FIREWALL RULES VARIABLES =================================

#------------------------------ PRESENTATION FIREWALL ----------------------------------
variable "presentation_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["0.0.0.0/0"]
}

#------------------------------ APPLICATION FIREWALL -----------------------------------
variable "application_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["10.0.1.0/24"]
}


#------------------------------ DATABASE FIREWALL --------------------------------------
variable "database_firewall_ranges" {
  description = "If direction <INGRESS> are specified, the firewall will apply only to traffic that has source IP address in these ranges. If direction <EGRESS>  are specified, the firewall will apply only to traffic that has destination IP address in these ranges."
  type        = list(string)
  default     = ["10.0.2.0/24"]
}