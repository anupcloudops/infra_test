resource "azurerm_resource_group" "rgblock" {

  for_each = {
    for k, v in var.rgs : k => v
    if upper(v.location) == "CENTRAL INDIA"
  }

  name     = each.value.name
  location = each.value.location

  lifecycle {
    prevent_destroy = false

  }
}


resource "azurerm_resource_group" "rgblock1" {

  for_each = {
    for k, v in var.rgs : k => v
    if upper(v.location) != "CENTRAL INDIA"
  }

  name     = each.value.name
  location = each.value.location

  lifecycle {
    prevent_destroy = false
  }
}


resource "null_resource" "rg_provisioner" {

  for_each = merge(
    azurerm_resource_group.rgblock,
    azurerm_resource_group.rgblock1
  )

  triggers = {
    rg_name     = each.value.name
    rg_location = each.value.location
  }

  provisioner "local-exec" {
    command = "echo Resource Group ${each.value.name} created in ${each.value.location}"
  }

  provisioner "local-exec" {
    when = destroy

    command = "echo Resource Group ${self.triggers.rg_name} is being destroyed"
  }
}