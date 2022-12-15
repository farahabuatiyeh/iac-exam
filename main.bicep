@sys.description('The Web App name.')
@minLength(3)
@maxLength(24)
param appServiceAppName string = 'farah-app-bicep'
@sys.description('The App Service Plan name.')
@minLength(3)
@maxLength(24)
param appServicePlanName string = 'farah-app-bicep'
@sys.description('The Storage Account name.')
@minLength(3)
@maxLength(24)
param storageNames array = [
  'Farah finalexam1'
  'Farah finalexam2'
]
param environmentType string = 'nonprod'
param location string = resourceGroup().location

var storageAccountSkuName = (environmentType == 'prod') ? 'Standard_GRS' : 'Standard_LRS'  

resource createStorages 'Microsoft.Storage/storageAccounts@2021-06-01' = [for (name, i) in storageNames: {
  name: '${i}${name}${uniqueString(resourceGroup().id)}'
  location: rgLocation
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
}]


module appService 'modules/appStuff.bicep' = {
  name: 'appService'
  params: { 
    location: location
    appServiceAppName: appServiceAppName
    appServicePlanName: Farah-asp
    environmentType: environmentType
  }
}

  output appServiceAppHostName string = appService.outputs.appServiceAppHostName

    