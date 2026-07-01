module "database" {
  source = "./modules/rds"

  project name = "project"
  security_group_ids = [
    aws_security_group.compliant.id
  ]
  subnetID = [
    aws_subnet.private1.id
    
  ]
  credentials = {
    username = "dbadmin"
    password = "abc1+_masu"
  }
}