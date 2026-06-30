###############
#General information 

#####################


variable "project name" {
  type = string
  description = "the project name used to name the RDS and add tags"
}

########################
# DB configs

#########################

variable "instance_class" {
  type = string
  default = "db.t3.micro"
  description = "the instance class used to ctreate the instance"

  validation {
    condition = contains(["db.t3.micro"], var.instance_class)
    error_message = "only t3 micro is allowed for DB usage"
  }
}

variable "storage_size" {
  type = number
  default = 10
  description = "storage amount to allocate to your DB instances"

  validation {
    condition = var.storage_size >= 5 && var.storage_size <= 10
    error_message = "DB size must be between 5 GB and 10 GB"
  }
}

variable "engine" {
  type = string
  default = "posgress-latrest"
  description = "which engine to use the RDS instance. currently only is supported"

  validation {
    condition = contains(["posgress-latest, postgress-14"], var.engine)
    error_message = "DB engine must be posgres-latest or postgres-14"
  }
}

###################    
#DB credentials

###################

variable "credentials" {
  type = object({
    username = string
    password = string
  })

  sensitive = true
  description = "root username and password for RDS ec2"

  validation {
    condition = (
      length(regexall("[a-zA-Z]+", var.credentials.password)) > 0
      && length(regexall("[0-9]+", var.credentials,password)) > 0
      && length(regexall("^[a-z0-9+_?-]{8,}$", var.credentials.password)) > 0

    )
    error_message = "password must comply with thge format:"
  }
  
}