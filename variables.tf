

variable "parent_team_id" {
  description = "Github parent team ID"
  type        = string
}


variable "app_code" {
  description = "Github app team name"
  type        = string
}


variable "repo_name" {
  description = "Github repo name"
  type        = string
}


variable "domain" {
  description = "DNS domain for application"
  type        = string
  default     = ""
}


variable "description" {
  description = "Github team description"
  type        = string
  default     = ""
}


variable "create_repos" {
  description = "Whether repos should get created along with being added to the team"
  type        = bool
  default     = true
}


variable "use_tf" {
  description = "Whether TF repo should get created with TFE workspaces"
  type        = bool
  default     = true
}


variable "single_workspace" {
  description = "Whether repos create only one TFE workspace"
  type        = bool
  default     = true
}


variable "super_admins" {
  description = "List of org super admins"
  type        = list(string)
  default     = []
}



variable "admins" {
  description = "List of team admins"
  type        = list(string)
  default     = []
}


variable "members" {
  description = "List of team members"
  type        = list(string)
  default     = []
}


variable "repo_template" {
  description = "Github repo template"
  type        = string
  default     = ""
}


variable "iac_repo_template" {
  description = "Github IaC app repo template"
  type        = string
  default     = "app-iac-template"
}


variable "permission" {
  description = "Github default member permissions"
  type        = string
  default     = "push"
}


variable "source_branch" {
  description = "Source branch for repo"
  type        = string
  default     = "main"
}


variable "new_branches" {
  description = "List of new branches"
  type        = list(string)
  default = [
    "dev",
    "stage",
  ]
}


variable "deploy_new_branches" {
  description = "List of new branches for deploy repo"
  type        = list(string)
  default = [
    "dev",
    "stage",
  ]
}


variable "create_tf_workspaces" {
  description = "Whether TF workspaces should get created for each lifecycle"
  type        = bool
  default     = true
}


variable "workspace_name" {
  description = "TFE workspace name"
  type        = string
  default     = ""
}


variable "gcp_project_id" {
  description = "GCP app project ID"
  type        = string
  default     = ""
}


variable "gke_project_id" {
  description = "GCP GKE project ID"
  type        = string
  default     = ""
}


variable "db_project_id" {
  description = "GCP database project ID"
  type        = string
  default     = ""
}


variable "service_account" {
  description = "Service account"
  type        = string
  default     = ""

}


variable "auto_apply" {
  description = "Whether to automatically apply changes when a Terraform plan is successful."
  default     = false
}


variable "external_workspace_triggers" {
  description = "List of external workspaces to trigger this one upon successful runs"
  default     = []
  type        = list(any)
}

variable "variables" {
  description = "Map of environment or Terraform variables to define in the workspace."
  default = {
  }
  type = map(map(string))
}

variable "working_directory" {
  description = "A relative path that Terraform will execute within. Defaults to the root of your repository."
  default     = null
}

variable "protect_branches" {
  description = "Whether repo should protect initial branches"
  type        = bool
  default     = true
}



