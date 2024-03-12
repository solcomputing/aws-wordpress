locals {
    settings        = {  
                          organization         = "solcomputing"
                          defaultaccount       = "student17_jan24_bootcamp_devops_services"
                          accountbuilder       = "terraform_admin_development"
                          region               = "eu-west-3"
                          group = {
                               organization    = "solcomputing"
                               group_name      = "administrators"
                               groups          = ["group_administrators"]
                               group_members   = ["terraform_admin_development", 
                                                  "terraform_admin_prod", 
                                                  "terraform_admin_preprod"] 
                               group_policies  = []
                              }
                           }
}