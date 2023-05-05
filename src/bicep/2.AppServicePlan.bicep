param locationStr string= resourceGroup().location
resource azbicepasp1 'Microsoft.Web/serverfarms@2020-12-01' = {
  name: 'azbicep-qa-eus-asp1'
  location: locationStr
  sku: {
    name: 's1'
    capacity: 1
  }
}
resource azbicepas 'Microsoft.Web/sites@2021-01-15' = {
  name: 'azbicep-qa-eus-wapp1'
  location: locationStr 
  properties: {
    serverFarmId: resourceId('Microsoft.Web/serverfarms','azbicep-qa-eus-asp1')
  }
  dependsOn:[azbicepasp1]
}

resource azbicepwebapp1appSetting 'Microsoft.Web/sites/config@2022-03-01'={
  name:'web'
  parent:azbicepas
  properties:{
    appSettings:[
      {
       name:'APPINSIGHTS_INSTRUMENTIONKEY'
       value:azbicepappinsights.properties.InstrumentationKey
      }
      {
        name:'key n'
        value:'value n'
       }
    ]
  }  
}

resource azbicepappinsights 'Microsoft.Insights/components@2020-02-02' = {
  name: 'azbicep-qa-eus-ai'
  location: locationStr
  kind: 'web'
  properties: {
    Application_Type: 'web'
  }
}


