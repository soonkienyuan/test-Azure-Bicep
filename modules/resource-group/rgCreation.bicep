param resourceGroupName string
param location string

targetScope = 'subscription'

resource hubresourceGroup 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
}
