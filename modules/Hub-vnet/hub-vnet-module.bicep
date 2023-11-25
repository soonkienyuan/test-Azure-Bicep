param vnetName string
param location string = 'southeastasia'

resource hubvnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [
        '10.1.0.0/16'
      ]
    }
    subnets: [
      {
        name: 'GatewaySubnet'
        properties: {
          addressPrefix: '10.1.0.0/25'
        }
      }
      {
        name: 'AzureFirewallSubnet'
        properties: {
          addressPrefix: '10.1.0.128/25'
        }
      }
    ]
  }
}

// resource commonVnet 'Microsoft.Network/virtualNetworks@2020-11-01' = {
//   name: vnetName
//   location: resourceGroup().location
//   properties: {
//     addressSpace: {
//       addressPrefixes: [
//         '10.0.0.0/24'
//       ]
//     }
//     subnets: [
//       {
//         name: 'default'
//         properties: {
//           addressPrefix: '10.0.0.0/25'
//         }
//       }
//     ]
//     virtualNetworkPeerings: []
//     enableDdosProtection: false
//   }
// }
