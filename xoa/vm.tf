# vm.tf
data "xenorchestra_pool" "pool" {
  name_label = "xcp-ng-ozzy"
}

data "xenorchestra_template" "vm_template" {
  name_label = "Debian12terra"
}

data "xenorchestra_sr" "sr" {
  name_label = "Local storage"
  pool_id = data.xenorchestra_pool.pool.id
}

data "xenorchestra_network" "network" {
  name_label = "Pool-wide network associated with eth0"
  pool_id = data.xenorchestra_pool.pool.id
}