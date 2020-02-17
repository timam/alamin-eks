locals {
  env = terraform.workspace

  owner_team = {
    sit = "SE"
    uat = "SE"
    lt = "SE"
    prod = "SE"
  }
  owner = local.owner_team[local.env]

  costs = {
    sit = "devops"
    uat = "devops"
    lt = "devops"
    prod = "devops"
  }
  cost-center = local.costs[local.env]

  project_name = {
    sit = "alamin"
    uat = "alamin"
    lt = "alamin"
    prod = "alamin"
  }
  project = local.project_name[local.env]

  common_tags = {
    Environment = local.env
    Owner = local.owner
    Cost-Center = local.cost-center
    Project = local.project
  }

}