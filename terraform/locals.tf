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

  tf_instance_type = {
    sit = "t3.xlarge"
    uat = "t3.xlarge"
    lt = "t3.xlarge"
    prod = "t3.xlarge"
  }
  instance_type = local.tf_instance_type[local.env]

  tf_worker-keypair = {
    sit = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQC7ro+mNHphqACjCPzodkeUBvjWDqeveAo8vKCWwbjCpqesrEcbFPxxBdh4c3V8bihQ+BTHqTRiuMxYQOSlGpD7IsXoIO6AUb1Huji5NhniQnPPsquhJrN7tHoIvEtsSttmoB34dHkNK9WpdyLU/3NKQDBrNLAqG1xmm9FHTGxElBqKBOcRXYkpso7H+YCtclCympBSrO1Y78n+rwjnb42tLuhn3zEmGBngkz5tJYdNkWwuoIE5k5LSZQD3T2WuAIf4IZyKLtP2zZDHjtq08P+n1fXH8Jzfj+gaeRcywgHncjBAmsm7gxFC5E/RU+G8CUe0E+6q40ddaZ+dgg1dhknx"
    uat = ""
    prod = ""
    lt = ""
  }
  worker-keypair = local.tf_worker-keypair[local.env]

  tf_eks-worker-node-userdata = {
    sit = ""
    uat = <<USERDATA
#!/bin/bash
mkdir -p /var/lib/docker/containers/{status,onboarding,authentication,datamanager,riskmanager,cps,balance,reporting,admin-portal,profile,qr-code,notification,event-stream}
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks-cluster.eks_endpoint}' --b64-cluster-ca '${module.eks-cluster.eks_certificate_authority[0].data}' '${module.eks-cluster.cluster_name}'
USERDATA
    prod = <<USERDATA
#!/bin/bash
mkdir -p /var/lib/docker/containers/{status,onboarding,authentication,datamanager,riskmanager,cps,balance,reporting,admin-portal,profile,qr-code,notification,event-stream}
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks-cluster.eks_endpoint}' --b64-cluster-ca '${module.eks-cluster.eks_certificate_authority[0].data}' '${module.eks-cluster.cluster_name}'
USERDATA
    lt = <<USERDATA
#!/bin/bash
mkdir -p /var/lib/docker/containers/{status,onboarding,authentication,datamanager,riskmanager,cps,balance,reporting,admin-portal,profile,qr-code,notification,event-stream}
set -o xtrace
/etc/eks/bootstrap.sh --apiserver-endpoint '${module.eks-cluster.eks_endpoint}' --b64-cluster-ca '${module.eks-cluster.eks_certificate_authority[0].data}' '${module.eks-cluster.cluster_name}'
USERDATA
  }
  eks-worker-node-userdata = local.tf_eks-worker-node-userdata[local.env]

}