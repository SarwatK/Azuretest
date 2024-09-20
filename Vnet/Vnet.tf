provider "azurerm" {
  features {}
}
 
# Define variables for resource names and values (optional)
variable "resource_group_name" {
  type    = string
  default = "myResourceGroup"
}
 
variable "location" {
  type    = string
  default = "West US"
}
 
variable "vnet_name" {
  type    = string
  default = "myVnet"
}
 
variable "vnet_address_space" {
  type    = list(string)
  default = ["10.0.0.0/16"]
}
 
variable "subnet_name" {
  type    = string
  default = "mySubnet"
}
 
variable "subnet_address_prefix" {
  type    = string
  default = "10.0.1.0/24"
}
 
# Resource Group Creation
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group_name
  location = var.location
}
 
# Virtual Network Creation
resource "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = azurerm_resource_group.rg.name
  location            = azurerm_resource_group.rg.location
  address_space       = var.vnet_address_space
 
  # Tags (optional)
  tags = {
    environment = "Dev"
    project     = "VnetDeployment"
  }
}
 
# Subnet Creation
resource "azurerm_subnet" "subnet" {
  name                 = var.subnet_name
  resource_group_name  = azurerm_resource_group.rg.name
  virtual_network_name = azurerm_virtual_network.vnet.name
  address_prefixes     = [var.subnet_address_prefix]
}
 
# Output the VNet and Subnet details
output "vnet_id" {
  value = azurerm_virtual_network.vnet.id
}
 
output "subnet_id" {
  value = azurerm_subnet.subnet.id
}