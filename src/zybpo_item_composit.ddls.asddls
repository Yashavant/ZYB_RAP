@AbapCatalog.viewEnhancementCategory: [#NONE]
@AccessControl.authorizationCheck: #NOT_REQUIRED
@EndUserText.label: 'Composit view for po item'
@Metadata.ignorePropagatedAnnotations: true
@ObjectModel.usageType:{
    serviceQuality: #X,
    sizeCategory: #S,
    dataClass: #MIXED
}
define view entity zybpo_item_composit as select from zybpo_item_base
association to parent zybpo_header_composit as _header
    on $projection.Pono = _header.Pono
{
    key Pono,
    key Poitem,
    @Semantics.quantity.unitOfMeasure : 'Unit'
    Quantity,
    Unit,
    _header 
}
