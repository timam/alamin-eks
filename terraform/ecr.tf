module "ecr-photo-filter" {
  source = "../modules/ecr"
  name = "${local.env}-${local.project}-photo-filter"
  tags = merge(map("Name",join("-",[local.env,local.project,"status"])),map("ResourceType","ecr"),local.common_tags)
}

module "ecr-photo-storage" {
  source = "../modules/ecr"
  name = "${local.env}-${local.project}-photo-storage"
  tags = merge(map("Name",join("-",[local.env,local.project,"status"])),map("ResourceType","ecr"),local.common_tags)
}

module "ecr-web-client" {
  source = "../modules/ecr"
  name = "${local.env}-${local.project}-web-client"
  tags = merge(map("Name",join("-",[local.env,local.project,"status"])),map("ResourceType","ecr"),local.common_tags)
}
