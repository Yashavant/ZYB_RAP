@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Fight Connection View'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@UI.headerInfo: {             //Show Header details in Main(first) Screen
    typeName: 'Connection',
    typeNamePlural: 'Connections',
    title: { type: #STANDARD, value: 'CarrierName' },    //Display Carrier Name as Header text in Object Page Header part
    description: { type: #STANDARD, value: 'ConnectionId' } //Display Connectoin ID as Desc in Object Page header part
}
@Search.searchable: true      //Show Global Search Box in Filter
define view entity ZI_CONN_YB
  as select from /dmo/connection
  association [1..1] to /DMO/I_Carrier as _Carrier on $projection.CarrierId = _Carrier.AirlineID
  association [1..*] to ZI_I_FLIGHT_YB as _Flight on $projection.CarrierId = _Flight.CarrierId and $projection.ConnectionId = _Flight.ConnectionId
{
      @UI.facet: [{                         //Display in Details Page(Second Page)
          id: 'IdCarrier',
          purpose: #STANDARD,
          position:10 ,
          label: 'Connection Details',                 //Page Text(Tab)
          type: #IDENTIFICATION_REFERENCE             // IDENTIFICATION_REFERENCE linked with @UI.identification to display that field in Details Page on mentined Position
      },{                                            //Display Flight List on Page(Second Page)
          id: 'IdFlight',
          purpose: #STANDARD,
          position:20 ,                                //Page Text(Tab Text)
          label: 'Fights',                
          type: #LINEITEM_REFERENCE,               // Allow to display Table Entry
          targetElement: '_Flight'                 // Display data from this Association -_Flight
      },{                         //Display in Details Page(Second Page Object Page)
          id: 'idAirportFrom',
          purpose: #HEADER,          // type HEADARE to display in Header part of Page below Hedare Title
          position:10 ,
          label: 'Departure',                 // Name for field that value going to display
          type: #DATAPOINT_REFERENCE ,            // #DATAPOINT_REFERENCE linked with @UI.dataPoint to display that field in Headare Page on mentined Position
          targetQualifier: 'tgAirportFrom'        // Same Name pass in @UI.dataPoint { qualifier: 'tgAirportFrom' to display that field value
      },{                         //Display in Details Page(Second Page Object Page)
          id: 'idAirportTo',
          purpose: #HEADER,          // type HEADARE to display in Header part of Page below Hedare Title
          position:20 ,
          label: 'Destination',                 // Name for field that value going to display
          type: #DATAPOINT_REFERENCE ,            // #DATAPOINT_REFERENCE linked with @UI.dataPoint to display that field in Headare Page on mentined Position
          targetQualifier: 'tgAirportTo'        // Same Name pass in @UI.dataPoint { qualifier: 'tgAirportFrom' to display that field value
      }
      ]
      @UI.lineItem: [{position: 10 ,label: 'Fight ID'  }]        // Display field in main (first) screen with mentined position
     // @UI.identification: [{ position: 10, label: 'Fight ID' }]  // Display field in details (second) screen with mentined position
      //@ObjectModel.text.association: '_Carrier'                  //It will take name from association _Carrier and display Carrier iD and name in output
      @ObjectModel.text.element: [ 'CarrierName' ]   //-> this one also show but Name field exist in same view
  key carrier_id      as CarrierId,
     
      @UI.lineItem: [{position: 20  }]
     // @UI.identification: [{ position: 20 }]
  key connection_id   as ConnectionId,

      @UI.lineItem: [{position: 30 , label: 'From Airport' }]
     // @UI.identification: [{ position: 30 }]        // Display field in details (second) screen with mentined position
      @UI.selectionField: [{ position: 10 }]       //Display Filter box for same field with mentioned position
      @Search.defaultSearchElement: true           //Allow to search this field value by global search box
      @Search.fuzzinessThreshold: 0.90             //Search matching 0.90 90% Match,.08 80& Match, 1 exact match for global search
      @Consumption.valueHelpDefinition: [{         //F4 Seach help for field at filtering or edit field value at screen and aslo display combined both Airport ID and Name in second page
          entity: { name: '/DMO/I_Airport_StdVH',   //F4 search view name
                   element: 'AirportID' } }]         //same field name from f4 search help view
       @UI.dataPoint: {
           qualifier: 'tgAirportFrom',              // Same Name from targetQualifier: 'tgAirportFrom' @UI.facet: [{ id: 'idAirportFrom'
           title: 'From'  }                          // Display Text title for this field value to 
                    
      airport_from_id as AirportFromId,

      @UI.lineItem: [{position: 40 , label: 'To Airport' }]
      //@UI.identification: [{ position: 40 }]             // Display field in details (second) screen with mentined position
      @UI.selectionField: [{ position: 20 }]               //Display Filter box for same field with mentioned position
      @Search.defaultSearchElement: true                   //Allow to search this field value by global search box
      @Search.fuzzinessThreshold: 0.90                     //Search matching 0.90 90% Match,.08 80& Match, 1 exact match for global search
      @Consumption.valueHelpDefinition: [{         //F4 Seach help for field at filtering or edit field value at screen and aslo display combined both Airport ID and Name in second page
          entity: { name: '/DMO/I_Airport_StdVH',   //F4 search view name
                   element: 'AirportID' } }]         //same field name from f4 search help view     
       @UI.dataPoint: {
           qualifier: 'tgAirportTo',              // Same Name from targetQualifier: 'tgAirportTo' @UI.facet: [{ id: 'idAirportTo'
           title: 'To'  }                          // Display Text title for this field value to 
                            
      airport_to_id   as AirportToId,

      @UI.lineItem: [{position: 60 , label: 'Departure Time' }]
      @UI.identification: [{ position: 60 }]
      departure_time  as DepartureTime,

      @UI.lineItem: [{position: 50 ,label: 'Arrival Time' }]
      @UI.identification: [{ position: 60 }]
      arrival_time    as ArrivalTime,

      @UI.lineItem: [{position: 70  }]
      @UI.identification: [{ position: 70 }]
      @Semantics.quantity.unitOfMeasure: 'DistanceUnit' //Display Qty and unit in same field
      distance        as Distance,

      @UI.lineItem: [{ hidden: true  }] //Hide in Main screen
      distance_unit   as DistanceUnit,
      _Carrier.Name as CarrierName,
      //Exposed Association
      _Carrier,
      @Search.defaultSearchElement: true           //Allow to Association field search by global search box
      _Flight
}
