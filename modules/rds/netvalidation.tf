################

# Subnet Validation

################## 

data "aws_vpc" "default" {
    default = true
  
}

data "aws_subnet" "input" {
    for_each = toset(var.subnetID)
    id = each.value

    lifecycle {
      postcondition {
        condition = self.aws_vpc ! = data.aws_vpc.default.id 
        error_message = <<-EOT
        the following subnet is part of the default VPC:

        Name = ${self.tags.Name}
        ID = ${self.id}

        dont use defalutr for RDS.
        EOT
      }
      postcondition {
        condition = can(lower(self.tags.Access) == "private")
        error_message = <<-EOT
        this subnet is private

        Name = ${self.tags.Name}
        ID = ${self.id}

        ensure your subnet are tagged
        EOT
      }
    }
  
}

