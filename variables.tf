variable "name" {}

variable "rg" {
  type = object({
    name     = string
    location = string
  })
}

variable "virtual_hubs" {
  type = map(object({
    address_prefix = string
    connections    = optional(map(string))
    vpn_server_configurations = optional(map(object({
      authentication_types    = set(string)
      client_root_certificate = optional(map(string), {})
      aad_authentication = optional(object({
        audience = string
        issuer   = string
        tenant   = string
      }))
      policy_groups = optional(map(object({
        policies = list(object({
          name  = string
          type  = string
          value = string
        }))
      })))
    })))
    point_to_site_vpn_gateways = optional(map(object({
      vpn_server_configuration = string
      scale_unit               = optional(number, 1)
      address_prefixes         = set(string)
    })))
  }))
  default = {}
  nullable = false
}
