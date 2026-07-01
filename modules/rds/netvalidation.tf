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

data "aws_vpc_security_group_rule" "input" {
  for_each = toset(data.aws_vpc_security_group_rule.input.ids)
  security_group_rule_id = each.value

  lifecycle {
    postcondition {
      condition = (
        self.is_egress
        ? true
        : self.cidr_ipv4 == null
        && self.cidr_ipv6 == null
        && self.referenced_security_group_id != null
      )
      error_message = <<-EOT
      invalid inbound rule

      ID = ${self.security_group_id}

      rules must only allow traffic from other SG as references 
      EOT
    }
  }
}

