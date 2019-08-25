terraform {
  backend "remote" {
    organization = "marino"

    workspaces {
      name = "mine-deploy"
    }
  }
}
