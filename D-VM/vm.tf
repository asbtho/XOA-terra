# vm.tf
data "xenorchestra_pool" "pool" {
  name_label = "xcp-ng-ozzy"
}

data "xenorchestra_template" "vm_template" {
  name_label = "Debian 11 Cloud-Init (Hub)"
}

data "xenorchestra_sr" "sr" {
  name_label = "Local storage"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id = data.xenorchestra_pool.pool.id
}

resource "xenorchestra_vm" "vm" {
  memory_max = 4294967296
  cpus = 4
  name_label = "Terraform Debian"
  template = data.xenorchestra_template.vm_template.id

  network {
    network_id = data.xenorchestra_network.network.id
  }

  disk {
    sr_id = data.xenorchestra_sr.sr.id
    name_label = "VM root volume"
    size = 50212254720
  }

  cloud_config = templatefile("cloud_config.tftpl", {
    hostname = "terradebian"
    domain = "ozzy.lan"
  })
  cloud_network_config = templatefile("cloud_network_config.tftpl", {
    ip = "192.168.0.185"
  })
}

