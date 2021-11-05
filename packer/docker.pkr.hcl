
packer {
  required_plugins {
    googlecompute = {
      version = ">= 0.0.1"
      source = "github.com/hashicorp/docker"
    }
  }
}

source "docker" "debian" {
  image = "debian:latest"
  commit = true
    changes = [
        "USER cardano"
    ]
}

build {
  name = "cardano-test"
  sources = ["sources.docker.debian"]
  provisioner "shell" {
      environment_vars = ["CardanoNetwork=testnet"]
      scripts = ["scripts/docker-node.sh"]
  }
  post-processors {
      post-processor "docker-tag" {
          repository = "devhulk/cardano"
          tags = ["1.30.1", "test"]
      }
      post-processor "docker-push" {}
  }
}