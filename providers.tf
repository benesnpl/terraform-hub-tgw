#Setting UP provider settings for AWS
#Variables needed : aws_region, aws_access_key_id, aws_secret_access_key
#Ask OS team to have an IAM with admin role in Networking, EC2 AND have CreateLinkService policy enabled 
#"Version" is about to get debricated - Warning message may appear while planning.

provider "aws" {
  region = var.aws_region
  access_key = "AKIA2I3LMA5XH4SEF5HD"
  secret_key = "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"
}
