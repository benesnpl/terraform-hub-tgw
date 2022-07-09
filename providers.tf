#Setting UP provider settings for AWS
#Variables needed : aws_region, aws_access_key_id, aws_secret_access_key
#Ask OS team to have an IAM with admin role in Networking, EC2 AND have CreateLinkService policy enabled 
#"Version" is about to get debricated - Warning message may appear while planning.

provider "aws" {
  region = var.aws_region
  version="4.3.0"
  access_key = var.aws_access_key_id
  secret_key = var.aws_secret_access_key
}
