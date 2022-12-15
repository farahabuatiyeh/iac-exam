param rgLocation string = resourceGroup().location
param storageNames array = [
  'Farah finalexam1'
  'fFarah finalexam2'
]

resource createStorages 'Microsoft.Storage/storageAccounts@2021-06-01' = [for (name, i) in storageNames: {
  name: '${i}${name}${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]
