# =============================================================================
# Example: Provisioning the OIDC Connector with Terraform
#
# This shows how to use the DataRecs Terraform provider to create the OIDC
# connector that enables the GitHub Actions workflow in this repo.
#
# This is the "infrastructure" half — the workflow itself is in
# .github/workflows/oidc-demo.yml
# =============================================================================

terraform {
  required_providers {
    datarecs = {
      source = "registry.terraform.io/datarecs/datarecs"
    }
  }
}

provider "datarecs" {
  host    = var.datarecs_host
  api_key = var.datarecs_api_key
}

# The OIDC Connector — trust GitHub Actions for this specific repo
resource "datarecs_oidc_connector" "github_actions" {
  name       = "GitHub Actions - Demo"
  issuer_url = "https://token.actions.githubusercontent.com"
  audience   = "${var.datarecs_host}/${var.datarecs_tenant_slug}"

  claim_conditions {
    claim_name     = "repository"
    operator       = "equals"
    expected_value = "datarecs/demo-github-actions-auth"
  }

  permissions = ["list_jobs", "list_connections"]
}

output "connector_id" {
  value       = datarecs_oidc_connector.github_actions.id
  description = "The OIDC connector ID (used for auditing/debugging)"
}
