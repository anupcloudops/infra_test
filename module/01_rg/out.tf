output "rg_name" {
  value = merge ( {
    for k, v in azurerm_resource_group.rgblock : k => v.name
  },
  {
    for k, v in azurerm_resource_group.rgblock1 : k => v.name
  })
}