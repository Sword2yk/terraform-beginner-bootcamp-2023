terraform {
  required_providers {
    terratowns = {
      source = "local.providers/local/terratowns"
      version = "1.0.0"
    }
  }
  #backend "remote" {
  #  hostname = "app.terraform.io"
  #  organization = "ExamPro"

  #  workspaces {
  #    name = "terra-house-1"
  #  }
  #}
  cloud {
    organization = "TerraBootCamp"
    workspaces {
      name = "terra-house-1"
    }
  }

}

provider "terratowns" {
  endpoint = var.terratowns_endpoint
  user_uuid = var.teacherseat_user_uuid
  token = var.terratowns_access_token
}

module "home_arcanum_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  content_version = var.arcanum.content_version
  public_path = var.arcanum.public_path
}

resource "terratowns_home" "home" {
  name = "How to play Blue sky in 2023!"
  description = <<DESCRIPTION
Blue sky is a building cast for gamers.
DESCRIPTION
  domain_name = module.home_arcanum_hosting.domain_name
  town = "missingo"
  content_version = var.arcanum.content_version
}

module "home_payday_hosting" {
  source = "./modules/terrahome_aws"
  user_uuid = var.teacherseat_user_uuid
  content_version = var.payday.content_version
  public_path = var.payday.public_path
}

resource "terratowns_home" "home_payday" {
  name = "Make my day Payday!"
  description = <<DESCRIPTION
Payday is a cooperative first-person shooter video game developed by Overkill Software and published by 505 Games. 
The game is a sequel to 2011's Payday: The Heist. It was released in August 2013 for Windows, PlayStation 3 and Xbox 360. 
DESCRIPTION
  domain_name = module.home_payday_hosting.domain_name
  town = "missingo"
  content_version = var.payday.content_version
}