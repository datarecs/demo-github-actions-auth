variable "datarecs_host" {
  description = "DataRecs API URL"
  type        = string
  default     = "https://api.dev.datarecs.io"
}

variable "datarecs_api_key" {
  description = "DataRecs API key with create_oidc_connector permission"
  type        = string
  sensitive   = true
}

variable "datarecs_tenant_slug" {
  description = "DataRecs tenant slug (used to construct the OIDC audience)"
  type        = string
}
