locals {
    usersgroup        = {  group = {
                               organisation    = "solcomputing.es"
                               group_name      = "administrators"
                               groups          = ["group_administrators"]
                               group_members   = ["terraform_admin_dev", 
                                                  "terraform_admin_prod", 
                                                  "terraform_admin_preprod"] 
                               group_policies  = ["SolcomputingAWSCreateGroup"]
                              }
                           } 
}