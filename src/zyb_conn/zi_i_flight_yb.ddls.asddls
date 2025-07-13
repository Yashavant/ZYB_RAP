@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'View for Flight'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
@Search.searchable: true //Show Global Search Box in Filter
@UI.headerInfo: {             //Show Header details in Main(first) Screen
    typeName: 'Flight',
    typeNamePlural: 'Plane Type',
    title: { type: #STANDARD, value: 'PlaneTypeId' }    //Display Flight Name as Header text in Object Page Header part
    //description: { type: #STANDARD, value: 'ConnectionId' } //Display Connectoin ID as Desc in Object Page header part
}
define view entity ZI_I_FLIGHT_YB
  as select from /dmo/flight
{
      @UI.facet: [{                         //Display in Details Page(Second Page)
          id: 'IdCarrier',
          purpose: #STANDARD,
          position:10 ,
          label: 'Flight Details',                 //Object Page for Flight List
          type: #IDENTIFICATION_REFERENCE             // IDENTIFICATION_REFERENCE linked with @UI.identification to display that field in Details Page on mentined Position
      },{                         //Display in Details Page(Second Page Object Page)
          id: 'idPlaneDate',
          purpose: #HEADER,          // type HEADARE to display in Header part of Page below Hedare Title
          position:10 ,
          label: 'Plane Date',                 // Name for field that value going to display
          type: #DATAPOINT_REFERENCE ,            // #DATAPOINT_REFERENCE linked with @UI.dataPoint to display that field in Headare Page on mentined Position
          targetQualifier: 'tgPlaneDate'        // Same Name pass in @UI.dataPoint { qualifier: 'tgPlaneDate' to display that field value
      }
      ]
      @UI.lineItem: [{position: 10 ,label: 'Fight ID'  }]        // Display field in main (first) screen with mentined position
      @UI.identification: [{ position: 10, label: 'Fight ID' }]  // Display field in details (second) screen with mentined position
  key carrier_id     as CarrierId,

      @UI.lineItem: [{position: 20 }]
      @UI.identification: [{ position: 20 }] 
  key connection_id  as ConnectionId,

      @UI.lineItem: [{position: 30 }]
     // @UI.identification: [{ position: 30 }]
       @UI.dataPoint: {
           qualifier: 'tgPlaneDate',              // Same Name from targetQualifier: 'tgPlaneDate' @UI.facet: [{ id: 'idPlaneDate'
           title: 'Plane Date'  }                          // Display Text title for this field value to 
                          
  key flight_date    as FlightDate,

      @UI.lineItem: [{position: 40 }]
      @UI.identification: [{ position: 40 }]
      @Semantics.amount.currencyCode: 'CurrencyCode' //Display Price and unit in same field
      price          as Price,

      @UI.lineItem: [{ hidden: true }]
      currency_code  as CurrencyCode,

      @UI.lineItem: [{position: 50 }]
     // @UI.identification: [{ position: 50 }]
      @Search.defaultSearchElement: true           //Allow to search this field value by global search box
      @Search.fuzzinessThreshold: 0.90             //Search matching 0.90 90% Match,.08 80& Match, 1 exact match for global search
      plane_type_id  as PlaneTypeId,

      @UI.lineItem: [{position: 60 }]
      @UI.identification: [{ position: 60 }]
      seats_max      as SeatsMax,

      @UI.lineItem: [{position: 70 }]
      @UI.identification: [{ position: 70 }]
      seats_occupied as SeatsOccupied
}
