# vm.tf
data "xenorchestra_pool" "pool" {
  name_label = "xcp-ng-ozzy"
}

data "xenorchestra_template" "vm_template" {
  name_label = "kali_COPY"
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
  name_label = "Terraform kali"
  template = data.xenorchestra_template.vm_template.id

  network {
    network_id = data.xenorchestra_network.network.id
  }

  disk {
    sr_id = data.xenorchestra_sr.sr.id
    name_label = "VM root volume"
    size = 50212254720
  }
}

