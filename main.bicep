var businessUnit = 'NASE'
var enviroment = 'test'
param location string = 'southeastasia'

param HUBsubscriptionId string
param SPOKEAsubscriptionId string
param SPOKEBsubscriptionId string
param OnpremsubscriptionId string

targetScope = 'subscription'

//HUB
//rg
module rghubvnet 'modules/resource-group/rgCreation.bicep' = {
  name: 'rg-Hubvnet-${businessUnit}-${enviroment}-001'
  scope: subscription(HUBsubscriptionId)
  params: {
    resourceGroupName: 'rg-Hubvnet-${businessUnit}-${enviroment}-001'
    location: location
  }
}
//vnet
module hubvnet 'modules/Hub-vnet/hub-vnet-module.bicep' = {
  name: 'Vnet-Hub-${enviroment}-${location}-001'
  scope: resourceGroup(HUBsubscriptionId, rghubvnet.name)
  params: {
    vnetName: 'Vnet-Hub-${enviroment}-${location}-001'
    location: location
  }
  dependsOn: [
    rghubvnet
  ]
}

//spoke A
//rg
module rgspokeAvnet 'modules/resource-group/rgCreation.bicep' = {
  name: 'rg-SpokevnetA-${businessUnit}-${enviroment}-001'
  scope: subscription(SPOKEAsubscriptionId)
  params: {
    resourceGroupName: 'rg-SpokevnetA-${businessUnit}-${enviroment}-001'
    location: location
  }
}
//vnet
module spokeAvnet 'modules/vnet/spoke-vnet-A.bicep' = {
  name: 'Vnet-SpokeA-${enviroment}-${location}-001'
  scope: resourceGroup(SPOKEAsubscriptionId, rgspokeAvnet.name)
  params: {
    vnetName: 'Vnet-SpokeA-${enviroment}-${location}-001'
    location: location
  }
  dependsOn: [
    rgspokeAvnet
  ]
}

//spoke B
//rg
module rgspokeBvnet 'modules/resource-group/rgCreation.bicep' = {
  name: 'rg-SpokevnetB-${businessUnit}-${enviroment}-001'
  scope: subscription(SPOKEBsubscriptionId)
  params: {
    resourceGroupName: 'rg-SpokevnetB-${businessUnit}-${enviroment}-001'
    location: location
  }
}
//vnet
module spokeBvnet 'modules/vnet/spoke-vnet-B.bicep' = {
  name: 'Vnet-SpokeB-${enviroment}-${location}-001'
  scope: resourceGroup(SPOKEBsubscriptionId, rgspokeBvnet.name)
  params: {
    vnetName: 'Vnet-SpokeB-${enviroment}-${location}-001'
    location: location
  }
  dependsOn: [
    rgspokeBvnet
  ]
}

//Onprem
//rg
module rgOnpremvnet 'modules/resource-group/rgCreation.bicep' = {
  name: 'rg-Onpremvnet-${businessUnit}-${enviroment}-001'
  scope: subscription(OnpremsubscriptionId)
  params: {
    resourceGroupName: 'rg-Onpremvnet-${businessUnit}-${enviroment}-001'
    location: location
  }
}
//vnet
module Onpremvnet 'modules/vnet/onprem.bicep' = {
  name: 'Vnet-Onprem-${enviroment}-${location}-001'
  scope: resourceGroup(OnpremsubscriptionId, rgOnpremvnet.name)
  params: {
    vnetName: 'Vnet-Onprem-${enviroment}-${location}-001'
    location: location
  }
  dependsOn: [
    rgOnpremvnet
  ]
}

// resource hubresourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
//   name: resourceGroupName
//   location: location
//   scope: subscription('dddd')
// }
