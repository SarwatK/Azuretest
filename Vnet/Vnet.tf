provider "azurerm" {
  features {}
}
# Define the virtual network
resource "azurerm_virtual_network" "new" {
  name                = "new-vnet"
  address_space       = ["10.20.0.0/16"]
  location            = azurerm_resource_group.new.location
  resource_group_name = azurerm_resource_group.new.name

  tags = {
  }
}

# Define a subnet within the virtual network
resource "azurerm_subnet" "subnet1" {
  name                 = "subnet1-subnet"
  resource_group_name  = azurerm_resource_group.new.name
  virtual_network_name = azurerm_virtual_network.new.name
  address_prefixes     = ["10.20.1.0/24"]

  service_endpoints = [
    "Microsoft.Storage",
  ]
}
