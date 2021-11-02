packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/googlecompute"
    }
  }
}

source "googlecompute" "cardano-test" {
  image_name = "cardano-test-${uuidv4()}"
  project_id = "puglies"
  disk_size = 50 
  source_image = "debian-10-buster-v20211028"
  ssh_username = "cardano"
  zone = "us-central1-a"
}

build {
  name = "cardano-test"
  sources = ["sources.googlecompute.cardano-test"]
  provisioner "shell" {
      environment_vars = ["CardanoNetwork=testnet"]
      scripts = ["scripts/cardano-node.sh"]
  }
}