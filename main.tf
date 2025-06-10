
locals {
  deploy_repo_name = "${var.repo_name}-deploy"
}


module "github_repo_iac" {
  count = var.use_tf ? 1 : 0

  source = "git::https://github.com/cloudwalksolutions/terraform-github-repo.git?ref=0.0.1"

  app_code             = var.app_code
  label                = "v3"
  repo_name            = local.deploy_repo_name
  workspace_name       = var.repo_name
  repo_template        = var.iac_repo_template
  protect_branches     = var.protect_branches
  source_branch        = var.source_branch
  new_branches         = var.deploy_new_branches
  create_tf_workspaces = var.create_tf_workspaces
  auto_apply           = var.auto_apply

  single_workspace = var.single_workspace
  domain           = var.domain
  gcp_project_id   = var.gcp_project_id
  gke_project_id   = var.gke_project_id
  db_project_id    = var.db_project_id
  service_account  = var.service_account

}


module "github_repo" {
  source = "git::https://github.com/cloudwalksolutions/terraform-github-repo.git?ref=0.0.1"

  app_code             = var.app_code
  repo_name            = var.repo_name
  repo_template        = var.repo_template
  source_branch        = var.source_branch
  new_branches         = var.new_branches
  protect_branches     = var.protect_branches
  create_tf_workspaces = false

  domain         = var.domain
  gcp_project_id = var.gcp_project_id
  gke_project_id = var.gke_project_id
  db_project_id  = var.db_project_id

}


resource "github_team" "team" {
  name           = var.app_code
  parent_team_id = var.parent_team_id
  privacy        = "closed"
}


resource "github_team_repository" "team_repo" {
  team_id    = github_team.team.id
  repository = var.repo_name
  permission = var.permission

  depends_on = [
    github_team.team,
    module.github_repo,
  ]
}


resource "github_team_repository" "team_repo_iac" {
  count = var.use_tf ? 1 : 0

  team_id    = github_team.team.id
  repository = local.deploy_repo_name
  permission = var.permission

  depends_on = [
    github_team.team,
    module.github_repo,
  ]
}


resource "github_team_membership" "team_admins" {
  for_each = toset(var.admins)

  team_id  = github_team.team.id
  username = each.key
  role     = "maintainer"

  depends_on = [
    github_team.team,
  ]
}


resource "github_team_membership" "team_members" {
  for_each = toset(var.members)

  team_id  = github_team.team.id
  username = each.key
  role     = "member"

  depends_on = [
    github_team.team,
  ]
}



