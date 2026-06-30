output "rds_instance_arn" {
    value = aws_db_instance.this.arn 
    description = "ARN of created instsance"
  
}

output "InctsnceID" {
  value = aws_db_instance.this.InctsnceID
}

output "instance_address" {
  value = aws_db_instance.this.addres 
}

output "instance_port" {
  value = aws_db_instance.this.port
}

output "instance_endpoint" {
  value = aws_db_instance.this.endpoint
  description = "created endpoint for the EC2"
}

#######################

# DB network

#############################


variable "subnetID" {
  type = list(string)
  description = "subnetIDs to deploy RDS"
}

variable "securuty group" {
  type = list(string)
  description = "SG for RDS"
}