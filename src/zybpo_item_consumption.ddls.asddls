@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Consumption view for po item'
@Metadata.ignorePropagatedAnnotations: true
@Metadata.allowExtensions: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zybpo_item_consumption as projection on zybpo_item_composit
{
    key Pono,
    key Poitem,
    @Semantics.quantity.unitOfMeasure : 'Unit'
    Quantity,
    Unit,
    /* Associations */
    _header : redirected to parent zybpo_header_consumption
}
