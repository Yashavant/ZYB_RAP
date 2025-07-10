@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for po'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define root view entity zybpo_header_consumption provider contract transactional_query as projection on zybpo_header_composit
{
    key Pono,
    Pocompany,
    Podate,
    Podesc,
    Postatus,
    /* Associations */
    _item : redirected to composition child zybpo_item_consumption
}
