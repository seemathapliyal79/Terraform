terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "5.17.0"
    }
  }
}

provider "github" {
  # Configuration options
  token = "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" # or `GITHUB_TOKEN`
}

resource "github_repository" "create_repo" {
  name        = "tfdemo_seema"
  description = "created by terraform"

  visibility = "private"
}