
packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "cardano-main" {
  project_id = "puglies"
  source_image = "debian-10-buster-v20211028"
  ssh_username = "packer"
  zone = "us-central1-a"
}

build {
  name = "cardano-main"
  sources = ["sources.googlecompute.cardano-main"]
  provisioner "shell" {
      environment_vars = ["CardanoNetwork=mainnet"]
      scripts = ["scripts/cardano-node.sh"]
  }
}